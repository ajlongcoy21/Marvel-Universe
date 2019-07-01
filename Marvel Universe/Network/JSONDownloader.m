//
//  JSONDownloader.m
//  Marvel Universe
//
//  Created by Alan Longcoy on 6/30/19.
//  Copyright © 2019 Alan Longcoy. All rights reserved.
//

#import "JSONDownloader.h"
#import "MarvelAPIError.h"

@implementation JSONDownloader

- (void) downloadData: (NSURL *) url comletionHandler: (void (^)(NSData *data, NSError *error))completionHandler
{
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:60];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
    {
        if (error == NULL)
        {
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            int httpCode = [[dictionary valueForKey:@"code"] intValue];
            NSString *status = [dictionary valueForKey:@"status"];
            
            if (httpCode == 200 || httpCode == 0)
            {
                completionHandler(data, nil);
            }
            else
            {
                NSLog(@"%i", httpCode);
                completionHandler(nil, [MarvelAPIError getMarvelAPIErrorWithCode:httpCode withStatus:status]);
            }
        }
        else
        {
            completionHandler(nil, error);
        }
    }];
    
    [task resume];

}

@end
