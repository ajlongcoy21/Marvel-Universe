//
//  MarvelAPIClient.h
//  Marvel Universe
//
//  Created by Alan Longcoy on 6/23/19.
//  Copyright © 2019 Alan Longcoy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MarvelAPIClient : NSObject

extern NSString *const publicAPIKey;
extern NSString *const privateAPIKey;
extern NSString *const baseURL;
extern NSString *const version;

@property NSString *timeStampString;

- (NSString *) md5;
- (NSURL *) getCharactersURL: (int) limit withOffset: (int) offset;
- (NSURL *) getThumbnailURL: (NSString *) path withVariant: (NSString *) variant withExtension: (NSString *) extension;

@end

NS_ASSUME_NONNULL_END
