//
//  ViewController.h
//  Yoox
//
//  Created by Gianmaria Dal Maistro on 17/02/17.
//  Copyright © 2017 it.whiteworld.yoox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetworkServiceDependencyProtocol.h"
#import "CVDataSourceDependencyProtocol.h"
#import "CVDelegateDependencyProtocol.h"

@interface ProductListViewController : UIViewController <NetworkServiceDependencyProtocol, CVDataSourceDependencyProtocol, CVDelegateDependencyProtocol>

@property (nonatomic, strong) id <UICollectionViewDataSource> cvDataSource;
@property (nonatomic, strong) id <UICollectionViewDelegate> cvDelegate;

@end

