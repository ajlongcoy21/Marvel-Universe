//
//  ViewController.m
//  Marvel Universe
//
//  Created by Alan Longcoy on 6/23/19.
//  Copyright © 2019 Alan Longcoy. All rights reserved.
//

#import "ViewController.h"
#import "CharacterCollectionViewController.h"

#import "MarvelAPIClient.h"
#import "JSONDownloader.h"
#import "imageVarients.h"

#import "Character.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *coverImage;

@property NSMutableArray *characterArray;
@property MarvelAPIClient *apiClient;
@property JSONDownloader *downloader;
@property NSNumber *totalNumberOfCharacters;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.enterButton.hidden = TRUE;
    
    self.characterArray = [[NSMutableArray alloc] init];
    self.apiClient = [[MarvelAPIClient alloc] init];
    self.downloader = [[JSONDownloader alloc] init];
    
    [self.downloader downloadData:[self.apiClient getCharactersURL:100 withOffset:0] comletionHandler:^(NSData * _Nonnull data, NSError * _Nonnull error)
    {
        if (error == NULL)
        {
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            
            NSArray *dictionariesInfo = [dictionary valueForKeyPath:@"data"];
            NSArray *dictionaries = [dictionary valueForKeyPath:@"data.results"];
            
            self.totalNumberOfCharacters = [dictionariesInfo valueForKey:@"total"];
            
            for(NSDictionary *dict in dictionaries)
            {
                Character *character = [Character characterWithDictionary:dict];
                [self.characterArray addObject:character];
            }
            
            [self downloadImages:self.downloader withClient:self.apiClient comletionHandler:^() {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.enterButton.hidden = FALSE;
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

- (void) downloadImages: (JSONDownloader *) downloader withClient: (MarvelAPIClient *) client comletionHandler: (void (^)(void))completionHandler
{
    
    NSNumber *count = [NSNumber numberWithInt:0];
    
    for (Character *marvelCharacter in self.characterArray)
    {
        count = [NSNumber numberWithInt:(count.intValue+1)];
        
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if([segue.identifier isEqualToString:@"showCharacters"])
    {
        
        CharacterCollectionViewController *characterViewController = segue.destinationViewController;
        characterViewController.characterArray = self.characterArray;
        characterViewController.apiClient = self.apiClient;
        characterViewController.downloader = self.downloader;
        characterViewController.currentOffset = [NSNumber numberWithInt:0];
        characterViewController.totalNumberOfCharacters = self.totalNumberOfCharacters;
        
    }
    
}


@end
