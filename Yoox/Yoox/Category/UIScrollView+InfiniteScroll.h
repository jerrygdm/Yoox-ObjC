//
//  UIScrollView+InfiniteScroll.h
//  Yoox
//
//  Created by Gianmaria Dal Maistro on 17/02/17.
//  Copyright © 2017 it.whiteworld.yoox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (InfiniteScroll)

/**
 *  Flag that indicates whether infinite scroll is animating
 */
@property (nonatomic, readonly, getter=isAnimatingInfiniteScroll) BOOL animatingInfiniteScroll;

/**
 *  Infinite scroll activity indicator style (default: UIActivityIndicatorViewStyleGray on iOS, UIActivityIndicatorViewStyleWhite on tvOS)
 */
@property (nonatomic) UIActivityIndicatorViewStyle infiniteScrollIndicatorStyle;

/**
 *  Infinite indicator view
 *
 *  You can set your own custom view instead of default activity indicator,
 *  make sure it implements methods below:
 *
 *  * `- (void)startAnimating`
 *  * `- (void)stopAnimating`
 *
 *  Infinite scroll will call implemented methods during user interaction.
 */
@property (nonatomic, nullable) UIView *infiniteScrollIndicatorView;

/**
 *  Vertical margin around indicator view (Default: 11)
 */
@property (nonatomic) CGFloat infiniteScrollIndicatorMargin;

/**
 *  Sets the offset between the real end of the scroll view content and the scroll position, so the handler can be triggered before reaching end.
 *  Defaults to 0.0;
 */
@property (nonatomic) CGFloat infiniteScrollTriggerOffset;

/**
 *  Setup infinite scroll handler
 *
 *  @param handler a handler block
 */
- (void)addInfiniteScrollWithHandler:(void(^)(UIScrollView *scrollView))handler;

/**
 *  Set a handler to be called to check if the infinite scroll should be shown
 *
 *  @param handler a handler block
 */
- (void)setShouldShowInfiniteScrollHandler:(nullable BOOL(^)(UIScrollView *scrollView))handler;

/**
 *  Unregister infinite scroll
 */
- (void)removeInfiniteScroll;

/**
 *  Manually begin infinite scroll animations
 *
 *  This method provides identical behavior to user initiated scrolling.
 *
 *  @param forceScroll pass YES to scroll to indicator view
 */
- (void)beginInfiniteScroll:(BOOL)forceScroll;

/**
 *  Finish infinite scroll animations
 *
 *  You must call this method from your infinite scroll handler to finish all
 *  animations properly and reset infinite scroll state
 *
 *  @param handler a completion block handler called when animation finished
 */
- (void)finishInfiniteScrollWithCompletion:(nullable void(^)(UIScrollView *scrollView))handler;

/**
 *  Finish infinite scroll animations
 *
 *  You must call this method from your infinite scroll handler to finish all
 *  animations properly and reset infinite scroll state
 */
- (void)finishInfiniteScroll;

@end

/**
 Convenience interface for UIScrollView+InfiniteScroll category.
 */
@interface UITableView (InfiniteScrollConvenienceInterface)

/**
 *  Setup infinite scroll handler
 *
 *  @param handler a handler block
 */
- (void)addInfiniteScrollWithHandler:(void(^)(UITableView *tableView))handler;

/**
 *  Set a handler to be called to check if the infinite scroll should be shown
 *
 *  @param handler a handler block
 */
- (void)setShouldShowInfiniteScrollHandler:(BOOL(^)(UITableView *tableView))handler;

/**
 *  Finish infinite scroll animations
 *
 *  You must call this method from your infinite scroll handler to finish all
 *  animations properly and reset infinite scroll state
 *
 *  @param handler a completion block handler called when animation finished
 */
- (void)finishInfiniteScrollWithCompletion:(nullable void(^)(UITableView *tableView))handler;

@end


/**
 Convenience interface for UIScrollView+InfiniteScroll category.
 */
@interface UICollectionView (InfiniteScrollConvenienceInterface)

/**
 *  Setup infinite scroll handler
 *
 *  @param handler a handler block
 */
- (void)addInfiniteScrollWithHandler:(void(^)(UICollectionView *collectionView))handler;

/**
 *  Set a handler to be called to check if the infinite scroll should be shown
 *
 *  @param handler a handler block
 */
- (void)setShouldShowInfiniteScrollHandler:(BOOL(^)(UICollectionView *collectionView))handler;

/**
 *  Finish infinite scroll animations
 *
 *  You must call this method from your infinite scroll handler to finish all
 *  animations properly and reset infinite scroll state
 *
 *  @param handler a completion block handler called when animation finished
 */
- (void)finishInfiniteScrollWithCompletion:(nullable void(^)(UICollectionView *collectionView))handler;

@end
