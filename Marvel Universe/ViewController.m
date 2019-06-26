//
//  ViewController.m
//  Marvel Universe
//
//  Created by Alan Longcoy on 6/23/19.
//  Copyright © 2019 Alan Longcoy. All rights reserved.
//

#import "ViewController.h"
#import "MarvelAPIClient.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    MarvelAPIClient *apiClient = [[MarvelAPIClient alloc] init];
    
    NSLog(@"Timestamp String: %@", apiClient.timeStampString);
    NSLog(@"%@", [apiClient md5]);
    NSLog(@"Timestamp String: %@", apiClient.timeStampString);
}


@end
