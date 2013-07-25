//
//  ImagePickerViewController.h
//  Selective Show
//
//  Created by Andrew Ng on 6/19/13.
//  Copyright (c) 2013 Andrew Ng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ARSwipeToSelectPickerControllerDelegate;

@interface ARSwipeToSelectPickerController : UITableViewController
- (id)initWithDelegate:(id <ARSwipeToSelectPickerControllerDelegate>)delegate;
@end

@protocol ARSwipeToSelectPickerControllerDelegate <UINavigationControllerDelegate>

- (void)swipeToSelectPickerControllerDidCancel:(ARSwipeToSelectPickerController *)sender;
- (void)swipeToSelectPickerController:(ARSwipeToSelectPickerController *)sender didFinishPickingMediaWithAssets:(NSArray *)assets;

@end
