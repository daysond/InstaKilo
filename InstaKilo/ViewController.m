//
//  ViewController.m
//  InstaKilo
//
//  Created by Dayson Dong on 2019-05-15.
//  Copyright © 2019 Dayson Dong. All rights reserved.
//

#import "ViewController.h"
#import "ImageCollectionViewCell.h"
#import "HeaderView.h"

@interface ViewController () <UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *imageCollectionView;
@property (nonatomic) NSArray <NSArray<NSString*>*> *imageNames;
@property (nonatomic) NSArray *sections;
@property (nonatomic) UICollectionViewFlowLayout *flowLayoutOne;
//@property (nonatomic) UICollectionViewFlowLayout *flowLayoutTwo;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.imageCollectionView registerClass:[ImageCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([ImageCollectionViewCell class])]; this is only for doing programmatically
    
    [self setupDataArray:0];
    self.imageCollectionView.backgroundColor = [UIColor blackColor];
    self.flowLayoutOne = [[UICollectionViewFlowLayout alloc]init];
    self.flowLayoutOne = (UICollectionViewFlowLayout*)self.imageCollectionView.collectionViewLayout;
    [self.flowLayoutOne setMinimumInteritemSpacing:20.0];
    CGFloat width = CGRectGetWidth(self.imageCollectionView.bounds);
    CGFloat heigth = width * (717.0/1215.0);
    [self.flowLayoutOne setItemSize:CGSizeMake(width, heigth)];

    



    
    
}

#pragma mark helpers

-(void)setupDataArray: (NSInteger) index {
    
    if (index == 0) {
        self.sections = @[@"Mage",@"Assassin",@"Support"];
        self.imageNames = @[@[@"Annie",@"Brand",@"Lux"],@[@"Fizz",@"Zed",@"Kaisa",@"Teemo"],@[@"Morgana",@"Blitzcrank",@"Kayle"]];
    } else {
        self.sections = @[@"BANDLE CITY",@"BILGEWATER",@"DEMACIA", @"IONIA",@"VOID",@"ZAUN",@"UNKNOWN"];
        self.imageNames = @[@[@"Teemo"],@[@"Fizz"],@[@"Lux",@"Morgana",@"Kayle"],@[@"Zed"],@[@"Kaisa"],@[@"Blitzcrank"],@[@"Annie",@"Brand"]];
    }
}


#pragma mark Set up collection view

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.sections.count;
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
}


#pragma mark Gesture and Action

- (IBAction)pinchRecog:(UIPinchGestureRecognizer *)sender {
    //-> <- scale goes to 0
//    self.flowLayoutOne = (UICollectionViewFlowLayout*)self.imageCollectionView.collectionViewLayout;
//    [self.flowLayoutOne setMinimumInteritemSpacing:20.0];
//    CGFloat width = CGRectGetWidth(self.imageCollectionView.bounds);
//    CGFloat heigth = width * (717.0/1215.0);
//    [self.flowLayoutOne setItemSize:CGSizeMake(width, heigth)];
    NSLog(@"%f",sender.scale);
    
}

- (IBAction)segmentedControl:(UISegmentedControl *)sender {
    
    [self setupDataArray:sender.selectedSegmentIndex];
    [self.imageCollectionView reloadData];
    NSLog(@"%ld", sender.selectedSegmentIndex);
    
}




@end
