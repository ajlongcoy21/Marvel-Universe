//
//  DetailedViewController.m
//  Marvel Universe
//
//  Created by Alan Longcoy on 7/7/19.
//  Copyright © 2019 Alan Longcoy. All rights reserved.
//

#import "DetailedViewController.h"

@interface DetailedViewController ()

@end

@implementation DetailedViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupGestures];
    
    self.marvelCharacterNameLabel.text = self.marvelCharacter.characterName;
    self.marvelCharacterImage.image = self.marvelCharacter.thumbnail;
    
    if ([self.marvelCharacter.characterDescription compare:@""])
    {
        self.marvelCharacterDescriptionLabel.text = self.marvelCharacter.characterDescription;
    }
    else
    {
        self.marvelCharacterDescriptionLabel.text = @"No Description Available.";
    }
    
}

- (void) setupGestures
{
    UITapGestureRecognizer *dismiss = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    
    dismiss.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:dismiss];
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeToDismiss)];
    
    swipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipe];
}

- (void) dismiss
{
    [UIView animateWithDuration:0.75 animations:^{
        self.view.transform = CGAffineTransformMakeScale(0.01, 0.01);
        self.view.alpha = 0.0;
    } completion:^(BOOL finished)
     {
         [self dismissViewControllerAnimated:YES completion:nil];
     }];
}

- (void) swipeToDismiss
{
    [UIView animateWithDuration:0.5 animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(400, 0);
    } completion:^(BOOL finished)
     {
         [self dismissViewControllerAnimated:YES completion:nil];
     }];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
