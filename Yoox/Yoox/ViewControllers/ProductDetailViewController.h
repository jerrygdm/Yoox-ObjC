//
//  ProductDetailViewController.h
//  Yoox
//
//  Created by Gianmaria Dal Maistro on 17/02/17.
//  Copyright © 2017 it.whiteworld.yoox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailSettableProtocol.h"

@interface ProductDetailViewController : UIViewController <DetailSettableProtocol>

@property (nonatomic, strong) id detail;

@end
