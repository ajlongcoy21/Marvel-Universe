//
//  MarvelAPIError.m
//  Marvel Universe
//
//  Created by Alan Longcoy on 6/30/19.
//  Copyright © 2019 Alan Longcoy. All rights reserved.
//

#import "MarvelAPIError.h"

@implementation MarvelAPIError

int const marvelHTTPResponseCode_409 = 409;
int const marvelHTTPResponseCode_500 = 500;
NSString const *marvelDomainError = @"Marvel Universe Error";


+ (NSError *) getMarvelAPIErrorWithCode: (int) marvelErrorCode withStatus: (NSString *) status
{
    if (marvelErrorCode == marvelHTTPResponseCode_409)
    {
        NSMutableString *reason = [NSMutableString stringWithFormat:@"%@ Please contact the developer for support.", status];
        
        NSMutableDictionary* details = [NSMutableDictionary dictionary];
        [details setValue:reason forKey:NSLocalizedDescriptionKey];
        
        NSError *apiError = [NSError errorWithDomain:marvelDomainError code:marvelErrorCode userInfo:details];
        
        return apiError;
    }
    else if (marvelErrorCode == marvelHTTPResponseCode_500)
    {
        NSMutableString *reason = [NSMutableString stringWithFormat:@"%@", status];
        
        NSMutableDictionary* details = [NSMutableDictionary dictionary];
        [details setValue:reason forKey:NSLocalizedDescriptionKey];
        
        NSError *apiError = [NSError errorWithDomain:marvelDomainError code:marvelErrorCode userInfo:details];
        
        return apiError;
    }
    else
    {
        NSMutableString *reason = [NSMutableString stringWithFormat:@"Unknown Error. Please contact the developer for support."];
        
        NSMutableDictionary* details = [NSMutableDictionary dictionary];
        [details setValue:reason forKey:NSLocalizedDescriptionKey];
        
        NSError *apiError = [NSError errorWithDomain:@"Marvel Universe Error" code:marvelErrorCode userInfo:details];
        
        return apiError;
    }
}

@end
