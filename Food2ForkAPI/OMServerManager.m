//
//  OMServerManager.m
//  Food2ForkAPI
//
//  Created by Орест on 17.05.16.
//  Copyright © 2016 HOME. All rights reserved.
//

#import "OMServerManager.h"
#import "AFNetworking.h"
#import "OMRecipes.h"

static NSString* baseSearchURL  = @"http://food2fork.com/api/search";
static NSString* baseGetURL     = @"http://food2fork.com/api/get";

@interface OMServerManager()

@property (strong, nonatomic) NSDictionary* params;

@end

@implementation OMServerManager

+ (OMServerManager *) sharedManager {
    
    static OMServerManager* manager = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        manager = [[OMServerManager alloc] init];
    });
    
    return manager;
}

- (void) getRecipesWihtCount:(NSInteger) count
                   witParams:(NSString *) recipeParams
                   onSuccess:(void(^)(NSArray*recipes)) success
                   onFailure:(void(^)(NSError* error)) failure{
    
    self.params = [NSDictionary dictionaryWithObjectsAndKeys:@"dd4e507812d2650644d1b89e51233b79", @"key", @"r", @"sort", @(count), @"page", recipeParams, @"q", nil];

    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    [manager GET:baseSearchURL parameters:self.params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        NSArray* dictsArray = [responseObject objectForKey:@"recipes"];
        
        NSMutableArray* objectArray = [NSMutableArray array];
        
        for (NSDictionary *dict in dictsArray) {
            OMRecipes *recipes = [[OMRecipes alloc] initWithServerRespons:dict];
            [objectArray addObject:recipes];
        }
        
        if (success) {
            success(objectArray);
        }
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
        if (failure) {
            failure(error);
        }
        
    }];
}

- (void) getDetailRecipeWithID:(NSInteger) recipeID
                     onSuccess:(void(^)(NSString* recipeIngredients)) success
                     onFailure:(void(^)(NSError* error)) failure{
    
    NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:@"dd4e507812d2650644d1b89e51233b79", @"key",
                                                                      @(recipeID), @"rId", nil];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    [manager GET:baseGetURL parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        NSArray* objectArray = responseObject[@"recipe"][@"ingredients"];
        
        NSMutableString *stringWithDescription = [NSMutableString string];
        for (NSArray *arr in objectArray) {
            [stringWithDescription  appendString:[NSString stringWithFormat:@"%@\n",arr]];
        }
        NSLog(@"stringWithDescription %@",stringWithDescription);
        
        if (success) {
            success(stringWithDescription);
        }
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
        if (failure) {
            failure(error);
        }
        
    }];

    
}


@end
