//
//  CustomCollectionViewFlowLayout.m
//  InstaKilo
//
//  Created by Dayson Dong on 2019-05-15.
//  Copyright © 2019 Dayson Dong. All rights reserved.
//

#import "CustomCollectionViewFlowLayout.h"
#import "DecorationView.h"

@implementation CustomCollectionViewFlowLayout



-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    NSMutableArray *attributes = [[super layoutAttributesForElementsInRect:rect] copy];
    UICollectionViewLayoutAttributes *attribute = [self layoutAttributesForDecorationViewOfKind:@"background" atIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
    [attributes addObject:attribute];
    
    return [attributes copy];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    
    if ([elementKind isEqualToString:@"background"]) {
        UICollectionViewLayoutAttributes * attr = [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:elementKind withIndexPath:indexPath];
        attr.frame = self.collectionView.frame;
        attr.zIndex = -1;
        return attr;
    } else {
        return nil;
        
    }
}

@end
