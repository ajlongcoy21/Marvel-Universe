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

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *coverImage;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    MarvelAPIClient *apiClient = [[MarvelAPIClient alloc] init];
    JSONDownloader *downloader = [[JSONDownloader alloc] init];
    
    [apiClient getCharactersURL:20 withOffset:0];
    [apiClient getThumbnailURL:@"http://i.annihil.us/u/prod/marvel/i/mg/3/40/4bb4680432f73" withVariant: portraitSmall withExtension:@"jpg"];
    
    [downloader downloadData:[apiClient getCharactersURL:100 withOffset:0] comletionHandler:^(NSData * _Nonnull data, NSError * _Nonnull error)
    {
        if (error == NULL)
        {
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            NSString *code = [dictionary valueForKey:@"code"];
            NSLog(@"HTTP Error Code: %@",code);
            NSString *status = [dictionary valueForKey:@"status"];
            NSLog(@"HTTP Error description: %@",status);
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

    }];
    
}


@end
