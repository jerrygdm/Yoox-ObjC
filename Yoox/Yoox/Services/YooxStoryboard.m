//
//  EnnovaStoryboard.m
//  sosdigital
//
//  Created by Gianmaria Dal Maistro on 04/09/15.
//  Copyright (c) 2015 it.ennova.myhd. All rights reserved.
//

#import "YooxStoryboard.h"

#import "NetworkServiceDependencyProtocol.h"
#import "NetworkServiceLayer.h"

#import "CVDelegateDependencyProtocol.h"
#import "CVDataSourceDependencyProtocol.h"

#import "CollectionViewDelegate.h"
#import "CollectionViewDataSource.h"

@interface YooxStoryboard ()

@property (nonatomic, readwrite) NSObject <NetworkServiceProtocol> *networkService;

@end

@implementation YooxStoryboard


- (id<NetworkServiceProtocol>)networkService
{
    if (!_networkService)
        _networkService = [NetworkServiceLayer new];
    
    return _networkService;
}

- (id)instantiateViewControllerWithIdentifier:(NSString *)identifier
{
    id ctrl = [super instantiateViewControllerWithIdentifier:identifier];
    
    [self setDependencyToController:ctrl];

    if ([ctrl isKindOfClass:[UINavigationController class]])
    {
        for (id controller in ((UINavigationController *)ctrl).viewControllers)
        {
            [self setDependencyToController:controller];
        }
    }
    
    return ctrl;
}

- (void)setDependencyToController:(id)controller
{
    if ([controller conformsToProtocol:@protocol(NetworkServiceDependencyProtocol)])
        [controller setNetworkService:self.networkService];
    
    if ([controller conformsToProtocol:@protocol(CVDelegateDependencyProtocol)])
        [controller setCvDelegate:[CollectionViewDelegate new]];

    if ([controller conformsToProtocol:@protocol(CVDataSourceDependencyProtocol)])
        [controller setCvDataSource:[CollectionViewDataSource new]];
}

@end
