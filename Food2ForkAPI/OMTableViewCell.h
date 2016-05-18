//
//  OMTableViewCell.h
//  Food2ForkAPI
//
//  Created by Орест on 17.05.16.
//  Copyright © 2016 HOME. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OMTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *publisher;
@property (weak, nonatomic) IBOutlet UILabel *rank;
@property (weak, nonatomic) IBOutlet UIImageView *image;

@end
