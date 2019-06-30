//
//  ViewController.m
//  Marvel Universe
//
//  Created by Alan Longcoy on 6/23/19.
//  Copyright © 2019 Alan Longcoy. All rights reserved.
//

#import "ViewController.h"
#import "MarvelAPIClient.h"
#import "imageVarients.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    MarvelAPIClient *apiClient = [[MarvelAPIClient alloc] init];
    
    [apiClient getCharactersURL:20 withOffset:0];
    [apiClient getThumbnailURL:@"http://i.annihil.us/u/prod/marvel/i/mg/3/40/4bb4680432f73" withVariant: portraitSmall withExtension:@"jpg"];
    
}


@end
