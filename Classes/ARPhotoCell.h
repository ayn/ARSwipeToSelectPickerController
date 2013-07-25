//
//  PhotoCell.h
//  Selective Show
//
//  Created by Andrew Ng on 6/19/13.
//  Copyright (c) 2013 Andrew Ng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ARPhotoCell : UICollectionViewCell
- (void)toggleSelected;
@property (nonatomic, strong, readwrite) UIImageView *imageView;
@end