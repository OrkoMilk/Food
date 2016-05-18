//
//  OMRecipes.h
//  Food2ForkAPI
//
//  Created by Орест on 17.05.16.
//  Copyright © 2016 HOME. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OMRecipes : NSObject

@property (strong, nonatomic) NSString* publisherName;
@property (strong, nonatomic) NSString* title;
@property (assign, nonatomic) NSUInteger socialRank;
@property (strong, nonatomic) NSURL* imageURL;
@property (assign, nonatomic) NSUInteger recipeID;

- (id) initWithServerRespons:(NSDictionary*) responsObject;

@end
