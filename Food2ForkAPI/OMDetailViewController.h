//
//  OMDetailViewController.h
//  Food2ForkAPI
//
//  Created by Орест on 17.05.16.
//  Copyright © 2016 HOME. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OMDetailViewController : UIViewController

+ (NSString *) storyboardID;

@property (strong, nonatomic) NSString *titleRecipes;
@property (strong, nonatomic) NSString *recipeIngredients;
@property (strong, nonatomic) NSURL *imageURL;

@end
