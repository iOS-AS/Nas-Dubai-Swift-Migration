//
//  PolicyAndInsuranceViewController.h
//  BISAD
//
//  Created by Ajith on 25/05/18.
//  Copyright © 2018 KrrishnaRajSalim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PolicyAndInsuranceViewController : UIViewController
{
    UIView *baseView;
    NSString *descrptionStr;
    NSString *emailStr;
}
@property(nonatomic)BOOL isBlogSelected;
@property(nonatomic)BOOL isUniformSelected;
@property (strong, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property(strong, nonatomic)NSMutableArray *dataArray;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIImageView *bannerImageView;
@property (strong, nonatomic) IBOutlet UIView *bannerBaseView;
@end
