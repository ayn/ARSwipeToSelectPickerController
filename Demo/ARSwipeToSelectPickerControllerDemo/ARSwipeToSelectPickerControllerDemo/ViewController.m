//
//  ViewController.m
//  ARSwipeToSelectPickerControllerDemo
//
//  Created by Ray Tsaihong on 8/15/13.
//  Copyright (c) 2013 Ray Tsaihong. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    // Instantiate PickerController and add to navigation controller
    ARSwipeToSelectPickerController *picker = [[ARSwipeToSelectPickerController alloc] initWithDelegate:self];
    [self.navigationController pushViewController:picker animated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ARSwipeToSelectPickerControllerDelegate methods

- (void) swipeToSelectPickerControllerDidCancel:(ARSwipeToSelectPickerController *)sender
{
    // Nothing before album picker, so cancel does not do anything here
}

- (void) swipeToSelectPickerController:(ARSwipeToSelectPickerController *)sender didFinishPickingMediaWithAssets:(NSArray *)assets
{
    // Use UIActivityViewController to send photos
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:assets applicationActivities:nil];
    [self presentViewController:activityViewController animated:YES completion:nil];
}

@end
