//
//  Character.m
//  Marvel Universe
//
//  Created by Alan Longcoy on 6/23/19.
//  Copyright © 2019 Alan Longcoy. All rights reserved.
//

#import "Character.h"

@implementation Character

+ (instancetype) characterWithDictionary:(NSDictionary *) dictionary
{
    // create a character object
    
    Character *character = [[Character alloc] init];
    
    // if character is created successfully add the properties to the character and return
    
    if (character)
    {
        character.characterName = [dictionary valueForKeyPath:@"name"];
        character.characterDescription = [dictionary valueForKeyPath:@"description"];
        character.characterID = [dictionary valueForKeyPath:@"id"];
        
        NSMutableString *modifiedThumbnailPath = [NSMutableString stringWithFormat:@"%@", [dictionary valueForKeyPath:@"thumbnail.path"]];
        //[modifiedThumbnailPath insertString:@"s" atIndex:4];
        
        character.thumbnailPath = modifiedThumbnailPath;
        character.thumbnailExtension = [dictionary valueForKeyPath:@"thumbnail.extension"];
        
    }
    
    return character;
}

@end
