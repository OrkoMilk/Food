//
//  OMServerManager.h
//  Food2ForkAPI
//
//  Created by Орест on 17.05.16.
//  Copyright © 2016 HOME. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OMServerManager : NSObject

+ (OMServerManager*) sharedManager;

- (void) getRecipesWihtCount:(NSInteger) count
                   witParams:(NSString *) recipeParams
                   onSuccess:(void(^)(NSArray*recipes)) success
                   onFailure:(void(^)(NSError* error)) failure;

- (void) getDetailRecipeWithID:(NSInteger) recipeID
                     onSuccess:(void(^)(NSString* recipeIngredients)) success
                     onFailure:(void(^)(NSError* error)) failure;
@end
