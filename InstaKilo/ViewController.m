//
//  ViewController.m
//  InstaKilo
//
//  Created by Dayson Dong on 2019-05-15.
//  Copyright © 2019 Dayson Dong. All rights reserved.
//

#import "ViewController.h"
#import "ImageCollectionViewCell.h"
#import "CustomCollectionViewFlowLayout.h"
#import "DecorationView.h"
#import "HeaderView.h"

@interface ViewController () <UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *imageCollectionView;
@property (nonatomic) NSMutableArray <NSMutableArray<NSString*>*> *imageNames;
@property (nonatomic) NSArray *sections;
@property (nonatomic) CustomCollectionViewFlowLayout *flowLayoutMax;
@property (nonatomic) CustomCollectionViewFlowLayout *flowLayoutMed;
@property (nonatomic) CustomCollectionViewFlowLayout *flowLayoutMin;
@property (nonatomic) NSUInteger currentLayout;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.imageCollectionView registerClass:[ImageCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([ImageCollectionViewCell class])]; this is only for doing programmatically
    
    [self setupDataArray:0];
//    self.imageCollectionView.backgroundColor = [UIColor blackColor];
    self.imageCollectionView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background"]];
    self.flowLayoutMax = [[CustomCollectionViewFlowLayout alloc]init];
    self.flowLayoutMed = [[CustomCollectionViewFlowLayout alloc]init];
    self.flowLayoutMin = [[CustomCollectionViewFlowLayout alloc]init];
    [self.flowLayoutMax registerClass:[DecorationView class] forDecorationViewOfKind:@"background"];
    [self.flowLayoutMed registerClass:[DecorationView class] forDecorationViewOfKind:@"background"];
    [self.flowLayoutMin registerClass:[DecorationView class] forDecorationViewOfKind:@"background"];
    self.flowLayoutMax = (CustomCollectionViewFlowLayout*)self.imageCollectionView.collectionViewLayout;
    [self setupMaxLayout];
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(deleteImage:)];
    [tap setNumberOfTapsRequired:2];
    [self.imageCollectionView addGestureRecognizer:tap];


    
    
}


#pragma mark helpers

-(void)setupDataArray: (NSInteger) index {
    
    if (index == 0) {
        self.sections = @[@"Mage",@"Assassin",@"Support"];
        NSMutableArray *mage = [[NSMutableArray alloc]initWithObjects:@"Annie",@"Brand",@"Lux", nil];
        NSMutableArray *assassin = [[NSMutableArray alloc]initWithObjects:@"Fizz",@"Zed",@"Kaisa",@"Teemo", nil];
        NSMutableArray *support = [[NSMutableArray alloc]initWithObjects: @"Morgana",@"Blitzcrank",@"Kayle",nil];
        self.imageNames = [[NSMutableArray alloc] initWithObjects:mage,assassin,support,nil] ;
    } else {
        self.sections = @[@"BANDLE CITY",@"BILGEWATER",@"DEMACIA", @"IONIA",@"VOID",@"ZAUN",@"UNKNOWN"];
        self.imageNames = [[NSMutableArray alloc]initWithObjects:@[@"Teemo"],@[@"Fizz"],@[@"Lux",@"Morgana",@"Kayle"],@[@"Zed"],@[@"Kaisa"],@[@"Blitzcrank"],@[@"Annie",@"Brand"],nil];
    }
}

-(void)setupMaxLayout {
    [self.flowLayoutMax setMinimumInteritemSpacing:20.0];
    CGFloat width = CGRectGetWidth(self.imageCollectionView.bounds);
    CGFloat heigth = width * (717.0/1215.0);
    [self.flowLayoutMax setItemSize:CGSizeMake(width, heigth)];
    self.currentLayout = 0;
}

-(void)setupMedLayout {
    [self.flowLayoutMed setMinimumInteritemSpacing:20.0];
    CGFloat width = (CGRectGetWidth(self.imageCollectionView.bounds) - 20) /2;
    CGFloat heigth = width * (717.0/1215.0);
    [self.flowLayoutMed setItemSize:CGSizeMake(width, heigth)];
    self.currentLayout = 1;
}

-(void)setupMinLayout {
    [self.flowLayoutMin setMinimumInteritemSpacing:20.0];
    CGFloat width = (CGRectGetWidth(self.imageCollectionView.bounds) - 60) /4;
    CGFloat heigth = width * (717.0/1215.0);
    [self.flowLayoutMin setItemSize:CGSizeMake(width, heigth)];
    self.currentLayout = 2;
}

#pragma mark Set up collection view

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.imageNames.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageNames[section].count;
}


#pragma mark Set up cell

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ImageCollectionViewCell *cell = [self.imageCollectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ImageCollectionViewCell class]) forIndexPath:indexPath];
    cell.cellImageView.image = [UIImage imageNamed:self.imageNames[indexPath.section][indexPath.item]];

    return cell;
}



#pragma mark Header view

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    HeaderView *supplementaryView;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        supplementaryView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
        supplementaryView.backgroundColor = [UIColor blackColor];

    }
    
    supplementaryView.roleLabel.text = self.sections[indexPath.section];
    return supplementaryView;
   
//    if ([kind isEqualToString:@"background"]) {
//        
//        DecorationView *background = [collectionView dequeueReusableSupplementaryViewOfKind:@"background" withReuseIdentifier:@"background" forIndexPath:indexPath];
//        background.background.image = [UIImage imageNamed:@"background"];
//        return background;
//    }
//    
//    return nil;
   
}




#pragma mark Gesture and Action

- (IBAction)pinchRecog:(UIPinchGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateEnded) {
        if (sender.scale > 2.0) {
            if (self.currentLayout == 2) {
                self.flowLayoutMed = (CustomCollectionViewFlowLayout*)self.imageCollectionView.collectionViewLayout;
                [self setupMedLayout];
                NSLog(@"back to med from min");
                return;
            } else if (self.currentLayout == 1) {
               self.flowLayoutMax = (CustomCollectionViewFlowLayout*)self.imageCollectionView.collectionViewLayout;
               [self setupMaxLayout];
                NSLog(@"back to Max from med");
                return;
            }
        } else {
            if (self.currentLayout == 1) {
                self.flowLayoutMin = (CustomCollectionViewFlowLayout*)self.imageCollectionView.collectionViewLayout;
                [self setupMinLayout];
                NSLog(@"back to min from med");
                return;
            }
            if (self.currentLayout == 0) {
                self.flowLayoutMed = (CustomCollectionViewFlowLayout*)self.imageCollectionView.collectionViewLayout;
                [self setupMedLayout];
                NSLog(@"back to med from max");
                return;
            }
        }
    }
}

- (IBAction)segmentedControl:(UISegmentedControl *)sender {
    
    [self setupDataArray:sender.selectedSegmentIndex];
    [self.imageCollectionView reloadData];
    NSLog(@"%ld", sender.selectedSegmentIndex);
    
}
-(void)deleteImage:(UITapGestureRecognizer *)sender {
    
    CGPoint location = [sender locationInView:self.view];
    NSIndexPath *indexPath = [self.imageCollectionView indexPathForItemAtPoint:location];
    NSLog(@"taptap %ld %ld",indexPath.section, indexPath.item);
    NSString *photoName = self.imageNames[indexPath.section][indexPath.item];
    [self.imageNames[indexPath.section] removeObject:photoName];
    [self.imageCollectionView deleteItemsAtIndexPaths:@[indexPath]];
    [self.imageCollectionView reloadData];
    
//    [self.imageCollectionView performBatchUpdates:^{
//                                                    [self.imageNames[indexPath.section] removeObject:photoName];
//                                                    [self.imageCollectionView deleteItemsAtIndexPaths:@[indexPath]];
//
//    } completion:nil];
  
    
    
    
}




@end
