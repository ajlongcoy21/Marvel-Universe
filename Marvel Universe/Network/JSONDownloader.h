//
//  JSONDownloader.h
//  Marvel Universe
//
//  Created by Alan Longcoy on 6/30/19.
//  Copyright © 2019 Alan Longcoy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JSONDownloader : NSObject

- (void) downloadData: (NSURL *) url comletionHandler: (void (^)(NSData *data, NSError *error))completionHandler;

@end

NS_ASSUME_NONNULL_END
