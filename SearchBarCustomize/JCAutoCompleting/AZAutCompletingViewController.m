//
//  AZAutCompletingViewController.m
//  YMedicineNote
//
//  Created by azu on 02/11/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "AZAutCompletingViewController.h"
#import "AZJCAutocompletingSearchBarDelegate.h"

@implementation AZAutCompletingViewController


+ (instancetype)viewController {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"AZAutCompletingViewController" bundle:nil];
    return [storyboard instantiateInitialViewController];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.searchBar becomeFirstResponder];
}

- (IBAction)handleSubmitButton:(id)sender {
    [self searchBarSubmit];
}

- (IBAction)handleCancelButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - delegate
- (void)searchBarSubmit{
    if ([self.delegate respondsToSelector:@selector(searchControllerSubmit:inputResultText:)]){
        [self.delegate searchControllerSubmit:self inputResultText:self.searchBar.text];
    }
}

@end
