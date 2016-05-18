//
//  OMViewController.m
//  Food2ForkAPI
//
//  Created by Орест on 17.05.16.
//  Copyright © 2016 HOME. All rights reserved.
//

#import "OMViewController.h"
#import "OMTableViewCell.h"
#import "OMServerManager.h"
#import "OMRecipes.h"
#import "UIImageView+AFNetworking.h"
#import "OMDetailViewController.h"

static NSInteger pageToloade;

@interface OMViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *recipesArray;
@property (strong, nonatomic) NSString *recipesSearch;
@end

@implementation OMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   self.recipesArray = [NSMutableArray array];
    pageToloade = 1;
    [self getRecipesFromServer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - API

- (void) getRecipesFromServer {

    [[OMServerManager sharedManager] getRecipesWihtCount:pageToloade
                                               witParams:self.recipesSearch
                                               onSuccess:^(NSArray *recipes) {
        
                                                   [self.recipesArray addObjectsFromArray:recipes];
                                                   [self.tableView reloadData];
                                                   
                                               } onFailure:^(NSError *error) {
                                                   NSLog(@"error = %@", error);
                                               }];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.recipesArray count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString* identifier = @"Cell";
    
    OMTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell){
        cell = [[OMTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if (indexPath.row == [self.recipesArray count]) {
        cell.title.text = @"LOADE MORE";
        cell.publisher.text = nil;
        cell.rank.text = nil;
        cell.image.image = nil;
    }
    else{
        OMRecipes* recipes = [self.recipesArray objectAtIndex:indexPath.row];
        cell.title.text = recipes.title;
        cell.publisher.text = recipes.publisherName;
        cell.rank.text = [NSString stringWithFormat:@"%ld", (long)recipes.socialRank];
        
        cell.image.image = nil;
        
        NSURLRequest *request = [NSURLRequest requestWithURL:recipes.imageURL];
        __weak OMTableViewCell* weakCell = cell;
        [cell.image setImageWithURLRequest:request
                              placeholderImage:nil
                                       success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
                                           weakCell.image.image = image;
                                           [weakCell layoutSubviews];
                                       } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
                                           
                                       }];

    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == self.recipesArray.count) {
         pageToloade ++;
        [self getRecipesFromServer];
    }else{
        
        OMRecipes* recipes = [self.recipesArray objectAtIndex:indexPath.row];
        __weak typeof(self) weakSelf = self;
        [[OMServerManager sharedManager] getDetailRecipeWithID:recipes.recipeID onSuccess:^(NSString* recipeIngredients) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (recipeIngredients)
                {
                    OMDetailViewController *detailViewController = [weakSelf.storyboard instantiateViewControllerWithIdentifier:[OMDetailViewController storyboardID]];
                    detailViewController.titleRecipes = recipes.title;
                    detailViewController.recipeIngredients = recipeIngredients;
                    detailViewController.imageURL = recipes.imageURL;
                    [weakSelf.navigationController pushViewController:detailViewController animated:YES];
                    
                }
            });
         
        } onFailure:^(NSError *error) {
            NSLog(@"Error");
        }];
        
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    self.recipesSearch = textField.text;
    pageToloade = 1;
    [self.recipesArray removeAllObjects];
    [self getRecipesFromServer];
    [self.tableView reloadData];
    [textField resignFirstResponder];
    return YES;
}


@end
