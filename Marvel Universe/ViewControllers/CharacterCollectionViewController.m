//
//  CharacterCollectionViewController.m
//  Marvel Universe
//
//  Created by Alan Longcoy on 7/6/19.
//  Copyright © 2019 Alan Longcoy. All rights reserved.
//

#import "CharacterCollectionViewController.h"
#import "CharacterCollectionViewCell.h"

#import "DetailedViewController.h"

#import "imageVarients.h"

@interface CharacterCollectionViewController ()

@property Boolean downloadInProgress;

@end

@implementation CharacterCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Do any additional setup after loading the view.
    
    self.downloadInProgress = false;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    //#warning Incomplete implementation, return the number of sections
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    //#warning Incomplete implementation, return the number of items
    
    return self.characterArray.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    CharacterCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: characterCellReuseIdentifier forIndexPath:indexPath];
   
    Character *marvelCharacter = [self.characterArray objectAtIndex:indexPath.row];
    
    
    // Configure the cell
    
    [cell setupCharacterCell:marvelCharacter];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    // Check to see if we need to download the other characters
    
    if (self.currentOffset.intValue < self.totalNumberOfCharacters.intValue && indexPath.row > (self.currentOffset.intValue - 20) && self.downloadInProgress == FALSE)
    {
        self.downloadInProgress = true;
        
        self.currentOffset = [NSNumber numberWithInt:self.currentOffset.intValue+100];
        
        [self.downloader downloadData:[self.apiClient getCharactersURL:100 withOffset:self.currentOffset.intValue+100] comletionHandler:^(NSData * _Nonnull data, NSError * _Nonnull error)
         {
             if (error == NULL)
             {
                 NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                 
                 NSArray *dictionaries = [dictionary valueForKeyPath:@"data.results"];
                 
                 for(NSDictionary *dict in dictionaries)
                 {
                     Character *character = [Character characterWithDictionary:dict];
                     [self.characterArray addObject:character];
                 }
                 
                 [self downloadImages:self.downloader withClient:self.apiClient comletionHandler:^() {
                     
                     dispatch_async(dispatch_get_main_queue(), ^{
                         
                         [self.collectionView reloadData];
                         self.downloadInProgress = false;
                         
                     });
                     
                 }];
             }
             else
             {
                 if ([error.domain.uppercaseString  isEqual: @"MARVEL UNIVERSE ERROR"])
                 {
                     [self.apiClient alertNotificationForUser:error.domain.uppercaseString withMessage:error.localizedDescription withViewController:self];
                 }
                 else
                 {
                     [self.apiClient alertNotificationForUser:@"HULK SMASH!" withMessage:error.localizedDescription withViewController:self];
                 }
                 
             }
             
         }];
    }
}

- (void) downloadImages: (JSONDownloader *) downloader withClient: (MarvelAPIClient *) client comletionHandler: (void (^)(void))completionHandler
{
    
    NSNumber *count = [NSNumber numberWithInt:0];
    
    for (Character *marvelCharacter in self.characterArray)
    {
        count = [NSNumber numberWithInt:(count.intValue+1)];
        
        if (count.intValue > self.currentOffset.intValue)
        {
            NSURL *characterImageURL = [client getThumbnailURL:marvelCharacter.thumbnailPath withVariant:portraitXLarge withExtension:marvelCharacter.thumbnailExtension];
            
            [downloader downloadData:characterImageURL comletionHandler:^(NSData * _Nonnull data, NSError * _Nonnull error)
             {
                 marvelCharacter.thumbnail = [UIImage imageWithData:data];
                 
                 if (count.intValue == self.characterArray.count)
                 {
                     completionHandler();
                 }
                 
             }];
        }
        
        
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if([segue.identifier isEqualToString:@"showDetail"])
    {
        NSIndexPath *selectedIndexPath = [self.collectionView indexPathsForSelectedItems][0];
        Character *marvelCharacter = self.characterArray[selectedIndexPath.row];
        DetailedViewController *detailedViewController = segue.destinationViewController;
        detailedViewController.marvelCharacter = marvelCharacter;
        
    }
    
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
 
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath
{
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
	
}
*/

@end
