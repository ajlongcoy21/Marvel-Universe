//
//  MarvelAPIClient.h
//  Marvel Universe
//
//  Created by Alan Longcoy on 6/23/19.
//  Copyright © 2019 Alan Longcoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MarvelAPIClient : NSObject

- (NSString *) md5;
- (NSURL *) getCharactersURL: (int) limit withOffset: (int) offset;
- (NSURL *) getThumbnailURL: (NSString *) path withVariant: (NSString *) variant withExtension: (NSString *) extension;
- (void) alertNotificationForUser: (NSString *) title withMessage: (NSString *) message withViewController: (UIViewController *) currentViewController;

@end

NS_ASSUME_NONNULL_END
