//
//  ImagePickerViewController.m
//  Selective Show
//
//  Created by Andrew Ng on 6/19/13.
//  Copyright (c) 2013 Andrew Ng. All rights reserved.
//

//@import AssetsLibrary;
#import <AssetsLibrary/AssetsLibrary.h>
#import "ARSwipeToSelectPickerController.h"
#import "ARSwipePhotoPickerViewController.h"

@interface ARSwipeToSelectPickerController ()
@property (nonatomic, strong) NSMutableArray *groups;
@property (nonatomic, strong) ALAssetsLibrary *assetLibrary;
@property (nonatomic, weak) id <ARSwipeToSelectPickerControllerDelegate> delegate;
@end

@implementation ARSwipeToSelectPickerController

- (id)initWithDelegate:(id<ARSwipeToSelectPickerControllerDelegate>)delegate
{
    if (self = [super init]) {
        self.delegate = delegate;
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.hidesBackButton = YES;
    self.assetLibrary = [[ALAssetsLibrary alloc] init];
    self.groups = [[NSMutableArray alloc] initWithCapacity:10];
    [self loadPhotoAlbums];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.groups count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *CellIdentifier = @"ARSwipeToSelectPickerControllerCell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    //    NSLog (@"returning cell %@ at %@", cell, indexPath);

    ALAssetsGroup *groupForCell = [self.groups objectAtIndex:indexPath.row];
    CGImageRef posterImageRef = [groupForCell posterImage];
    UIImage *posterImage = [UIImage imageWithCGImage:posterImageRef];
    cell.imageView.image = posterImage;
    cell.textLabel.text = [groupForCell valueForProperty:ALAssetsGroupPropertyName];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    return cell;
}

#pragma mark - Private methods
- (void)loadPhotoAlbums
{
    NSUInteger groupTypes = ALAssetsGroupAll;//ALAssetsGroupAlbum| ALAssetsGroupEvent;// | ALAssetsGroupFaces;

    [self.assetLibrary enumerateGroupsWithTypes:groupTypes usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        if (group) {
            [self.groups addObject:group];
        } else {
            [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
        }

    } failureBlock:^(NSError *error) {
        NSString *errorMessage = nil;
        switch ([error code]) {
            case ALAssetsLibraryAccessUserDeniedError:
            case ALAssetsLibraryAccessGloballyDeniedError:
                errorMessage = @"The user has declined access to it.";
                break;
            default:
                errorMessage = @"Reason unknown.";
                break;
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"oops" message:@"msg" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }];
}

- (void)cancel:(id)sender
{
    [self.delegate swipeToSelectPickerControllerDidCancel:self];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.groups.count > indexPath.row) {
        // [self performSegueWithIdentifier:@"showSwipePhotoPicker" sender:indexPath];
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(79.0, 79.0);
        layout.minimumInteritemSpacing = 1.0;
        layout.minimumLineSpacing = 1.0;
        ARSwipePhotoPickerViewController *swipePhotoPickerViewController = [[ARSwipePhotoPickerViewController alloc] initWithCollectionViewLayout:layout];
        swipePhotoPickerViewController.delegate = self.delegate;
        swipePhotoPickerViewController.group = self.groups[indexPath.row];
        if (self.navigationController) {
            [self.navigationController pushViewController:swipePhotoPickerViewController animated:YES];
        } else {
            [self presentViewController:swipePhotoPickerViewController animated:YES completion:nil];
        }
    }
}

@end
