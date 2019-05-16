//
//  DecorationView.m
//  InstaKilo
//
//  Created by Dayson Dong on 2019-05-15.
//  Copyright © 2019 Dayson Dong. All rights reserved.
//

#import "DecorationView.h"

@implementation DecorationView

- (instancetype)init
{
    self = [super init];
    if (self) {
        _background.image = [UIImage imageNamed:@"background"];
    }
    return self;
}

@end
