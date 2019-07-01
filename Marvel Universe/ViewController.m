//
//  ViewController.m
//  Marvel Universe
//
//  Created by Alan Longcoy on 6/23/19.
//  Copyright © 2019 Alan Longcoy. All rights reserved.
//

#import "ViewController.h"

#import "MarvelAPIClient.h"
#import "JSONDownloader.h"
#import "imageVarients.h"

#import "Character.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *coverImage;

@property NSMutableArray *characterArray;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.characterArray = [[NSMutableArray alloc] init];
    MarvelAPIClient *apiClient = [[MarvelAPIClient alloc] init];
    JSONDownloader *downloader = [[JSONDownloader alloc] init];
    
    [downloader downloadData:[apiClient getCharactersURL:30 withOffset:0] comletionHandler:^(NSData * _Nonnull data, NSError * _Nonnull error)
    {
        if (error == NULL)
        {
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            //NSString *code = [dictionary valueForKey:@"code"];
            //NSLog(@"HTTP Error Code: %@",code);
            //NSString *status = [dictionary valueForKey:@"status"];
            //NSLog(@"HTTP Error description: %@",status);
            
            NSArray *dictionaries = [dictionary valueForKeyPath:@"data.results"];
            
            for(NSDictionary *dict in dictionaries)
            {
                Character *character = [Character characterWithDictionary:dict];
                [self.characterArray addObject:character];
            }
        }
        else
        {
            if ([error.domain.uppercaseString  isEqual: @"MARVEL UNIVERSE ERROR"])
            {
                [apiClient alertNotificationForUser:error.domain.uppercaseString withMessage:error.localizedDescription withViewController:self];
            }
            else
            {
                [apiClient alertNotificationForUser:@"HULK SMASH!" withMessage:error.localizedDescription withViewController:self];
            }
            
        }
        
        [self downloadImages:downloader withClient:apiClient];

    }];
    
}

- (void) downloadImages: (JSONDownloader *) downloader withClient: (MarvelAPIClient *) client
{
    for (Character *marvelCharacter in self.characterArray)
    {
        NSURL *test = [client getThumbnailURL:marvelCharacter.thumbnailPath withVariant:portraitUncanny withExtension:marvelCharacter.thumbnailExtension];
    
        [downloader downloadData:test comletionHandler:^(NSData * _Nonnull data, NSError * _Nonnull error)
        {
            marvelCharacter.thumbnail = [UIImage imageWithData:data];
        }];
    
    }
}


@end
