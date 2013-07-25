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
@property (nonatomic, strong) NSMutableArray *selectedAssets;
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
    self.selectedAssets = [[NSMutableArray alloc] initWithCapacity:[self.group numberOfAssets]];
    for (int i = 0; i < [self.group numberOfAssets]; i++) {
        self.selectedAssets[i] = [NSNumber numberWithBool:NO];
    }
    
    [self loadAssets];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonSystemItemDone target:self action:@selector(done:)];
	// Do any additional setup after loading the view.
    ARSwipeToSelectGestureRecognizer *gestureRecognizer = [[ARSwipeToSelectGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:) toggleSelectedHandler:^(NSIndexPath *indexPath) {
        ARPhotoCell *photoCell = (ARPhotoCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
        [photoCell toggleSelected];

        self.selectedAssets[indexPath.row] = ([self.selectedAssets[indexPath.row] boolValue] == YES ? [NSNumber numberWithBool:NO]: [NSNumber numberWithBool:YES]);
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
    return cell;}

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
    for (int i=0; i<[self.group numberOfAssets]; ++i) {
        if ([self.selectedAssets[i] boolValue]) {
            [returnAssets addObject:self.assets[i]];
        }
    }
    [self.delegate swipeToSelectPickerController:nil didFinishPickingMediaWithAssets:returnAssets];
}

@end
