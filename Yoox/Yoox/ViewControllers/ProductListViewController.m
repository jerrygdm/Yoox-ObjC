//
//  ViewController.m
//  Yoox
//
//  Created by Gianmaria Dal Maistro on 17/02/17.
//  Copyright © 2017 it.whiteworld.yoox. All rights reserved.
//

#import "ProductListViewController.h"
#import "NetworkServiceProtocol.h"

#import "UIScrollView+InfiniteScroll.h"
#import "EXTScope.h"
#import "ProductListCollectionViewCell+Configure.h"
#import "DetailSettableProtocol.h"
#import "Product.h"

#define kCellsPerRow 3

@interface ProductListViewController ()

@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) id <NetworkServiceProtocol> networkService;

@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, assign) NSInteger paginationIndex;
@property (nonatomic, strong) Product *selectedProduct;

@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicator;
@end

@implementation ProductListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.paginationIndex = 0;
    [self.activityIndicator startAnimating];
    
    self.items = [NSMutableArray array];
        
    @weakify(self)
    [self.collectionView addInfiniteScrollWithHandler:^(UICollectionView *collectionView) {
        @strongify(self)
        
        self.paginationIndex++;
        
        [self loadItemsWithIndex:self.paginationIndex completionBlock:^(NSArray *newItems, NSError *error) {
            NSIndexSet *newIndexes = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(self.items.count, newItems.count)];
            NSMutableArray *newIndexPaths = [[NSMutableArray alloc] init];
            
            [newIndexes enumerateIndexesUsingBlock:^(NSUInteger idx, __unused BOOL *stop) {
                [newIndexPaths addObject:[NSIndexPath indexPathForRow:idx inSection:0]];
            }];
            
            [self.items addObjectsFromArray:newItems];
            
            [self.collectionView performBatchUpdates:^{
                [self.collectionView insertItemsAtIndexPaths:newIndexPaths];
            } completion:^(__unused BOOL finished) {
//                finish();
                
            }];
            
            [collectionView finishInfiniteScroll];
        }];
    }];
    
    // Load initial data
    [self.collectionView beginInfiniteScroll:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController *destination = segue.destinationViewController;
    if ([destination conformsToProtocol:@protocol(DetailSettableProtocol)])
        [destination setValue:self.selectedProduct.imageHiresUrlString forKey:@"detail"];
}

- (IBAction)unwindAfterPhotoDetail:(UIStoryboardSegue *)unwindSegue
{

}

- (void)loadItemsWithIndex:(NSInteger)index completionBlock:(CompletionBlock)completion
{
    NSString *pageIndex = [NSString stringWithFormat:@"%ld", (long)index];
    [self.networkService getProductListPage:pageIndex withCompletion:^(id data) {
        
        [self.activityIndicator stopAnimating];
        
        if (completion)
            completion(data, nil);
    } failure:^(NSError *error) {
        if (completion)
            completion(nil, error);
    }];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.items count];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"ProductListCellID" forIndexPath:indexPath];
    
    if ([cell isKindOfClass:[ProductListCollectionViewCell class]])
    {
        ProductListCollectionViewCell *productCell = cell;
        id item = [self modelAtIndex:indexPath.row];

        if (item)
            [productCell configureCell:item];
    }
    
    return cell;
}

- (id)modelAtIndex:(NSInteger)index
{
    if (index < [self.items count])
        return self.items[index];
    
    return nil;
}

- (CGSize)calculateCellSize
{
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout*)self.collectionView.collectionViewLayout;
    CGFloat availableWidthForCells = CGRectGetWidth(self.collectionView.frame) - flowLayout.sectionInset.left - flowLayout.sectionInset.right - flowLayout.minimumInteritemSpacing * (kCellsPerRow - 1);
    CGFloat cellWidth = availableWidthForCells / kCellsPerRow;
    
    return CGSizeMake(cellWidth, flowLayout.itemSize.height);
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self calculateCellSize];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    id item = [self modelAtIndex:indexPath.row];
    self.selectedProduct = item;
    [self performSegueWithIdentifier:@"detailSegueID" sender:self];
}

@end
