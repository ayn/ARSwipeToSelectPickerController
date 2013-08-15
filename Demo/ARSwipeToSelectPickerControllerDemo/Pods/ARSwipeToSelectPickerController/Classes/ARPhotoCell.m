//
//  PhotoCell.m
//  Selective Show
//
//  Created by Andrew Ng on 6/19/13.
//  Copyright (c) 2013 Andrew Ng. All rights reserved.
//

#import "ARPhotoCell.h"

@implementation ARPhotoCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.selected = NO;
        self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        self.imageView.contentMode = UIViewContentModeScaleToFill;
        self.imageView.clipsToBounds = YES;
        self.imageView.userInteractionEnabled = NO;
        self.fogView = [[UIView alloc] initWithFrame:self.bounds];
        self.fogView.clipsToBounds = YES;
        self.fogView.userInteractionEnabled = NO;
        self.fogView.hidden = YES;
        self.fogView.backgroundColor = [UIColor whiteColor];
        self.fogView.alpha = 0.5;
        self.checkView = [[UIImageView alloc] initWithFrame:CGRectMake(50.0, 50.0, 27.0, 27.0)];
        self.checkView.image = [UIImage imageNamed:@"checkmark"];
        self.checkView.clipsToBounds = YES;
        self.checkView.userInteractionEnabled = NO;
        self.checkView.hidden = YES;
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.fogView];
        [self.contentView addSubview:self.checkView];
    }
    return self;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.imageView.image = nil;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
