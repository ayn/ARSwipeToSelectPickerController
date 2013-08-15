# ARSwipeToSelectPickerController

A UIImagePickerController-like assets picker that utilizes [`ARMultiSelectGestureRecognizer`](http://github.com/ayn/ARSwipeToSelectGestureRecognizer) for swipe-to-select

## Adding to your project

The easiest way to add `ARSwipeToSelectPickerController` to your project is via CocoaPods:

`pod 'ARSwipeToSelectPickerController'`

Alternatively you could copy all the files in the `Classes/` directory into your project. Be sure 'Copy items to destination group's folder' is checked.

## Use

1. Import the header: `#import "ARSwipeToSelectPickerController.h"`
2. Conform to the `ARSwipeToSelectPickerControllerDelegate` protocol,
   implement its [delegate methods](#delegate-methods)
3. Instantiate the controller:

```` objective-c
ARSwipeToSelectPickerController *picker = [[ARSwipeToSelectPickerController alloc] initWithDelegate:self];
[self.navigationController pushViewController:picker animated:YES];
````

You can also show the picker modally by embedding it inside a `UINavigationController` first:

```` objective-c
ARSwipeToSelectPickerController *picker = [[ARSwipeToSelectPickerController alloc] initWithDelegate:self];
UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:picker];
[self presentViewController:nav animated:YES completion:nil];
````

## Delegate Methods

```` objective-c
#pragma mark - ARSwipeToSelectPickerControllerDelegate methods

- (void) swipeToSelectPickerControllerDidCancel:(ARSwipeToSelectPickerController *)sender
{
    // use popViewControllerAnimated if using navigation controller for viewcontroller stack
    //[self.navigationController popViewControllerAnimated:YES];

    // use dismissViewControllerAnimated if not using a navigation controller
    //[self dismissViewControllerAnimated:YES completion:nil];
}

- (void) swipeToSelectPickerController:(ARSwipeToSelectPickerController *)sender didFinishPickingMediaWithAssets:(NSArray *)assets
{
    // Use MWPhotoBrowser to show the selected photos
    [self dismissViewControllerAnimated:NO completion:^{
        NSMutableArray *tmpArray = [[NSMutableArray alloc] initWithCapacity:[assets count]];
        [assets enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            UIImage *image = [UIImage imageWithCGImage:[[((ALAsset *) obj) defaultRepresentation] fullScreenImage]];
            [tmpArray addObject:[MWPhoto photoWithImage:image]];
        }];
        self.photos = tmpArray;
        MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
        browser.displayActionButton = NO;
        [browser setInitialPageIndex:0];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:browser animated:YES completion:nil];
        });
    }];
}
````

Or if you are inside a `UINavigationController` stack, do something like the following to dismiss the picker controller:

```` objective-c
[self.navigationController popToViewController:self animated:YES];
````

## Demo
A cool demo can be found in the [demo folder](Demo/)!

## Co-Authors

- [Andrew Ng](http://github.com/ayn)
- [Ray Tsaihong](http://github.com/rmundo)


[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/ayn/ARSwipeToSelectPickerController/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

