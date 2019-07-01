//
//  MarvelAPIClient.m
//  Marvel Universe
//
//  Created by Alan Longcoy on 6/23/19.
//  Copyright © 2019 Alan Longcoy. All rights reserved.
//

#import "MarvelAPIClient.h"
#import <CommonCrypto/CommonDigest.h>

@implementation MarvelAPIClient

NSString * const publicAPIKey = @"bae59d2adf1b3c596960861205c1e073";
NSString * const privateAPIKey = @"75e1f1be21f180dae80a7e18b6fb020f3365a457";
NSString * const baseURLString = @"https://gateway.marvel.com";
NSString * const version = @"v1";

NSString *timeStampString = @"";

- (NSString *) md5
{
    // get the current time stamp for the request
    
    [self setTimeStampNow];
    
    // Create string for MD5 Hash for Marvel API Request
    
    NSMutableString *md5Input = [NSMutableString stringWithFormat:@"%@%@%@", timeStampString, privateAPIKey, publicAPIKey];
    
    // Convert string to the MD5 encoding
    
    const char *cStr = [md5Input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (unsigned int)strlen(cStr), digest); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    // return the MD5 encoded string value
    
    return  output;
}

- (void) setTimeStampNow
{
    NSTimeInterval  timeStamp = [[NSDate date] timeIntervalSince1970];
    timeStampString = [NSString stringWithFormat:@"%f", timeStamp];
}

- (NSURL *) getCharactersURL: (int) limit withOffset: (int) offset
{
    // Create base url for Marvel API
    
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    
    // obtain hash value
    
    NSString *hashString = [self md5];
    
    // Create relative url string
    
    NSString *relativePath = [NSString stringWithFormat:@"/%@/public/characters?orderBy=name&limit=%i&offset=%i&apikey=%@&ts=%@&hash=%@", version, limit, offset, publicAPIKey, timeStampString, hashString];
    
    // create full URL for the request
    
    NSURL *charactersURL = [NSURL URLWithString:relativePath relativeToURL:baseURL];
    
    return charactersURL;
    
}

- (NSURL *) getThumbnailURL: (NSString *) path withVariant: (NSString *) variant withExtension: (NSString *) extension
{
    // Create the URL string to obtian the thumbnail image
    
    NSString *urlString = [NSString stringWithFormat:@"%@/%@.%@", path, variant, extension];
    
    // Create the URL from the string
    
    NSURL *thumbnailURL = [NSURL URLWithString:urlString];
    
    return thumbnailURL;
}

- (void) alertNotificationForUser: (NSString *) title withMessage: (NSString *) message withViewController: (UIViewController *) currentViewController
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    //We add buttons to the alert controller by creating UIAlertActions:
    UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:nil]; //You can use a block here to handle a press on this button
    [alertController addAction:actionOk];
    
    dispatch_async(dispatch_get_main_queue(), ^
     {
         [currentViewController presentViewController:alertController animated:YES completion:nil];
     });
    
}

@end
