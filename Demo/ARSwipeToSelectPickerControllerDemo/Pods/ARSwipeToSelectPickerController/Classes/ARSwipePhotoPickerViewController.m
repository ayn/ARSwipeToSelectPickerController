//
//  SwipePhotoPickerViewController.m
//  Selective Show
//
//  Created by Andrew Ng on 6/19/13.
//  Copyright (c) 2013 Andrew Ng. All rights reserved.
//

#import "ARSwipePhotoPickerViewController.h"
#import "ARSwipeToSelectGestureRecognizer.h"
#import "ARPhotoCell.h"

@interface ARSwipePhotoPickerViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate, UICollectionViewDelegate>
@property (nonatomic, strong) NSMutableArray *assets;
@end

@implementation ARSwipePhotoPickerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.collectionView registerClass:[ARPhotoCell class] forCellWithReuseIdentifier:@"ARPhotoCell"];
    self.collectionView.allowsSelection = self.collectionView.allowsMultipleSelection = YES;
    self.assets = [[NSMutableArray alloc] initWithCapacity:[self.group numberOfAssets]];

    [self loadAssets];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonSystemItemDone target:self action:@selector(done:)];
	// Do any additional setup after loading the view.
    ARSwipeToSelectGestureRecognizer *gestureRecognizer = [[ARSwipeToSelectGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:) toggleSelectedHandler:^(NSIndexPath *indexPath) {
        if ([[self.collectionView indexPathsForSelectedItems] containsObject:indexPath]) {
            [self.collectionView deselectItemAtIndexPath:indexPath animated:NO];
            ARPhotoCell *photoCell = (ARPhotoCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
            photoCell.checkView.hidden = YES;
            photoCell.fogView.hidden = YES;
        } else {
            [self.collectionView selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
            ARPhotoCell *photoCell = (ARPhotoCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
            photoCell.checkView.hidden = NO;
            photoCell.fogView.hidden = NO;
        }
    }];
    [self.collectionView addGestureRecognizer:gestureRecognizer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionView Datasource

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section
{
    return [self.assets count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ARPhotoCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"ARPhotoCell" forIndexPath:indexPath];
    ALAsset * asset = (ALAsset *)self.assets[indexPath.row];
    cell.imageView.image = [UIImage imageWithCGImage:asset.thumbnail];
    if ([[self.collectionView indexPathsForSelectedItems] containsObject:indexPath]) {
        cell.checkView.hidden = NO;
        cell.fogView.hidden = NO;
    }
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
}

#pragma mark - Private methods

- (void)handleGesture:(UIGestureRecognizer *)gestureRecognizer
{
}

- (void)loadAssets
{
    [self.group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
        if (result) {
            [self.assets addObject:result];
        }
    }];
}

- (void)done:(id)sender
{
    NSMutableArray *returnAssets = [[NSMutableArray alloc] initWithCapacity:[self.group numberOfAssets]];
    [[self.collectionView indexPathsForSelectedItems] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSIndexPath *indexPath = (NSIndexPath *)obj;
        [returnAssets addObject:self.assets[indexPath.row]];
    }];
    [self.delegate swipeToSelectPickerController:nil didFinishPickingMediaWithAssets:returnAssets];
}

@end
