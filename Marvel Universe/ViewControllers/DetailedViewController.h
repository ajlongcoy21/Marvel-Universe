//
//  DetailedViewController.h
//  Marvel Universe
//
//  Created by Alan Longcoy on 7/7/19.
//  Copyright © 2019 Alan Longcoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Character.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailedViewController : UIViewController

@property (weak, nonatomic) Character *marvelCharacter;
@property (weak, nonatomic) IBOutlet UILabel *marvelCharacterNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *marvelCharacterImage;
@property (weak, nonatomic) IBOutlet UILabel *marvelCharacterDescriptionLabel;

@end

NS_ASSUME_NONNULL_END
