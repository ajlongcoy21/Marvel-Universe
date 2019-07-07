//
//  CharacterCollectionViewCell.m
//  Marvel Universe
//
//  Created by Alan Longcoy on 7/6/19.
//  Copyright © 2019 Alan Longcoy. All rights reserved.
//

#import "CharacterCollectionViewCell.h"

@implementation CharacterCollectionViewCell

NSString *const characterCellReuseIdentifier = @"CharacterCell";



-(void) setupCharacterCell: (Character *) marvelCharacter
{
    self.characterImage.image = marvelCharacter.thumbnail;
    self.characterLabel.text = marvelCharacter.characterName;
}

@end
