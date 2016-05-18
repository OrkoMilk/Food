//
//  OMDetailViewController.m
//  Food2ForkAPI
//
//  Created by Орест on 17.05.16.
//  Copyright © 2016 HOME. All rights reserved.
//

#import "OMDetailViewController.h"
#import "UIImageView+AFNetworking.h"

@interface OMDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLebal;
@property (weak, nonatomic) IBOutlet UITextView *recipeIngredientsTextView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation OMDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view
    [self setAllProperty];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (NSString *) storyboardID {
  return @"OMDetailViewController";
}

- (void) setAllProperty {
    self.titleLebal.text = self.titleRecipes;
    self.recipeIngredientsTextView.text = self.recipeIngredients;
    
    __weak typeof(self) weakSelf = self;
    NSURLRequest *request = [NSURLRequest requestWithURL:self.imageURL];
    [weakSelf.imageView setImageWithURLRequest:request
                              placeholderImage:nil
                                       success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
                                           weakSelf.imageView.image = image;
                                       } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
                                           
                                       }];

}

#pragma mark - Actions

- (IBAction)beckToRecipes:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}



@end
