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
        [self.contentView addSubview:self.imageView];
    }
    return self;
}

- (void)toggleSelected
{
    NSIndexPath *indexPath = [((UICollectionView *)[self superview]) indexPathForCell:self];
    self.selected = !self.selected;
    self.alpha = self.selected ? 0.5 : 1.0;
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
