//
//  MarvelAPIError.h
//  Marvel Universe
//
//  Created by Alan Longcoy on 6/30/19.
//  Copyright © 2019 Alan Longcoy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MarvelAPIError : NSObject

+ (NSError *) getMarvelAPIErrorWithCode: (int) marvelErrorCode withStatus: (NSString *) status;

@end

NS_ASSUME_NONNULL_END
