//
//  Character.h
//  Marvel Universe
//
//  Created by Alan Longcoy on 6/23/19.
//  Copyright © 2019 Alan Longcoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Character : NSObject

@property (strong, nonatomic) NSNumber *characterID;
@property (strong, nonatomic) NSString *characterName;
@property (strong, nonatomic) NSString *characterDescription;
@property (strong, nonatomic) NSString *thumbnailPath;
@property (strong, nonatomic) NSString *thumbnailExtension;
@property (strong, nonatomic) UIImage *thumbnail;

@end

NS_ASSUME_NONNULL_END
