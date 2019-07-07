//
//  CharacterCollectionViewController.h
//  Marvel Universe
//
//  Created by Alan Longcoy on 7/6/19.
//  Copyright © 2019 Alan Longcoy. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MarvelAPIClient.h"
#import "JSONDownloader.h"

NS_ASSUME_NONNULL_BEGIN

@interface CharacterCollectionViewController : UICollectionViewController

@property (weak, nonatomic) NSMutableArray *characterArray;
@property (weak, nonatomic) MarvelAPIClient *apiClient;
@property (weak, nonatomic) JSONDownloader *downloader;
@property (weak, nonatomic) NSNumber *currentOffset;
@property (weak, nonatomic) NSNumber *totalNumberOfCharacters;

@end

NS_ASSUME_NONNULL_END
