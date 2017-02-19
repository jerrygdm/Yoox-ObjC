//
//  ProductDetailViewController.m
//  Yoox
//
//  Created by Gianmaria Dal Maistro on 17/02/17.
//  Copyright © 2017 it.whiteworld.yoox. All rights reserved.
//

#import "ProductDetailViewController.h"
@import SDWebImage;

@interface ProductDetailViewController ()

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (nonatomic, strong) UIImageView *detailImage;

@end

@implementation ProductDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([self.detail isKindOfClass:[NSString class]])
    {
        self.detailImage = [[UIImageView alloc] initWithFrame:self.scrollView.bounds];
        self.detailImage.contentMode = UIViewContentModeScaleAspectFill;
        [self.scrollView addSubview:self.detailImage];

        [self.activityIndicator startAnimating];
        [self.detailImage sd_setImageWithURL:[NSURL URLWithString:self.detail]
                        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                            self.scrollView.contentSize = image.size;
                            [self.activityIndicator stopAnimating];
                        }];
    }
}

- (IBAction)handlePinch:(UIPinchGestureRecognizer *)recognizer
{
    recognizer.view.transform = CGAffineTransformScale(recognizer.view.transform, recognizer.scale, recognizer.scale);
    recognizer.scale = 1;
}

@end
