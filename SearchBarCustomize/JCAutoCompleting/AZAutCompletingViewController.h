//
//  AZAutCompletingViewController.h
//  YMedicineNote
//
//  Created by azu on 02/11/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//



#import "JCAutocompletingSearchViewController.h"

@protocol AZJCAutocompletingSearchBarDelegate;

@interface AZAutCompletingViewController : JCAutocompletingSearchViewController


@property(weak, nonatomic) NSObject <AZJCAutocompletingSearchBarDelegate> *delegate;
@property(weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property(weak, nonatomic) IBOutlet UITableView *resultsTableView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;

- (IBAction)handleSubmitButton:(id)sender;

- (IBAction)handleCancelButton:(id)sender;

+ (instancetype)viewController;
@end
