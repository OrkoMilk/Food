//
//  OMRecipes.m
//  Food2ForkAPI
//
//  Created by Орест on 17.05.16.
//  Copyright © 2016 HOME. All rights reserved.
//

#import "OMRecipes.h"

@implementation OMRecipes

- (id) initWithServerRespons:(NSDictionary*) responsObject
{
    self = [super init];
    if (self) {
        self.publisherName = [responsObject objectForKey:@"publisher"];
        self.title = [responsObject objectForKey:@"title"];
        self.socialRank = [[responsObject objectForKey:@"social_rank"] integerValue];
        self.recipeID = [[responsObject objectForKey:@"recipe_id"] integerValue];
        
        NSString* urlString = [responsObject objectForKey:@"image_url"];
        
        if (urlString) {
            self.imageURL = [NSURL URLWithString:urlString];
        }
        
    }
    return self;
}


@end
