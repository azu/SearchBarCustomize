//
//  ViewController.h
//  SearchBarCustomize
//
//  Created by azu on 2013/02/18.
//  Copyright (c) 2013年 azu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AZJCAutocompletingSearchBarDelegate.h"

@interface ViewController : UIViewController <AZJCAutocompletingSearchBarDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;

@property(nonatomic, copy) NSString *inputText;

- (void)updateOutlets;
@end
