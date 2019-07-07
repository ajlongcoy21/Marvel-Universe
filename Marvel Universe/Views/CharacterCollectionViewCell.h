//
//  CharacterCollectionViewCell.h
//  Marvel Universe
//
//  Created by Alan Longcoy on 7/6/19.
//  Copyright © 2019 Alan Longcoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Character.h"

NS_ASSUME_NONNULL_BEGIN

@interface CharacterCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *characterImage;
@property (weak, nonatomic) IBOutlet UILabel *characterLabel;

extern NSString *const characterCellReuseIdentifier;

-(void) setupCharacterCell: (Character *) marvelCharacter;

@end

NS_ASSUME_NONNULL_END
