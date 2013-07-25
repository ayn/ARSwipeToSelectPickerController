//
//  SwipePhotoPickerViewController.h
//  Selective Show
//
//  Created by Andrew Ng on 6/19/13.
//  Copyright (c) 2013 Andrew Ng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ARSwipeToSelectPickerController.h"

@interface ARSwipePhotoPickerViewController : UICollectionViewController
@property (nonatomic, strong) ALAssetsGroup *group;
@property (nonatomic, weak) id <ARSwipeToSelectPickerControllerDelegate> delegate;
@end
