//
//  ViewController.m
//  SearchBarCustomize
//
//  Created by azu on 2013/02/18.
//  Copyright (c) 2013年 azu. All rights reserved.
//
#import "ViewController.h"
#import "AZAutCompletingViewController.h"
#import "AZAutoCompletingList.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)updateOutlets {
    self.textField.text = self.inputText;
}
#pragma mark - UITextField Delegate
- (void)textFieldDidBeginEditing:(UITextField *) textField {
    if ([textField isEqual:self.textField]) {
        [textField resignFirstResponder];
        AZAutCompletingViewController *searchController = [AZAutCompletingViewController viewController];
        searchController.delegate = self;
        [self.navigationController presentViewController:searchController animated:YES completion:^{
            [searchController.searchBar setText:self.textField.text];
        }];
    }
}


#pragma mark - AutoComplete
+ (NSArray *)possibleItems {
    return [AZAutoCompletingList sharedList];
}

- (void)searchController:(JCAutocompletingSearchViewController *) searchController
   performSearchForQuery:(NSString *) query
      withResultsHandler:(JCAutocompletingSearchResultsHandler) resultsHandler {
    // Simulate the asynchronicity and delay of a web request...
    __weak typeof (self) that = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray *possibleItems = [[that class] possibleItems];

        NSMutableArray *predicates = [NSMutableArray new];
        for (__strong NSString *queryPart in [query componentsSeparatedByString:@" "]) {
            if (queryPart && (queryPart = [queryPart stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]).length > 0) {
                // 先頭一致
//                [predicates addObject:[NSPredicate predicateWithFormat:@"SELF like[cd] %@", [NSString stringWithFormat:@"%@*", queryPart]]];
                // 部分一致
                [predicates addObject:[NSPredicate predicateWithFormat:@"SELF contains %@", [NSString stringWithFormat:@"%@", queryPart]]];
            }
        }
        NSPredicate *predicate = [NSCompoundPredicate andPredicateWithSubpredicates:predicates];

        NSArray *matchedItems = [possibleItems filteredArrayUsingPredicate:predicate];
        NSMutableArray *results = [NSMutableArray new];
        for (NSString *item in matchedItems) {
            [results addObject:@{@"label" : item}];
        }

        CGFloat delayInSeconds = 0.4;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void) {
            resultsHandler(results);
        });
    });
}
// input
- (void)searchControllerSubmit:(JCAutocompletingSearchViewController *) searchController inputResultText:(NSString *) result {
    __weak typeof (self) that = self;

    self.inputText = result;
    [searchController dismissViewControllerAnimated:YES completion:^{
        [that updateOutlets];
    }];
}

- (void)searchControllerCanceled:(JCAutocompletingSearchViewController *) searchController {
    __weak typeof (self) that = self;
    [searchController dismissViewControllerAnimated:YES completion:^{
        [that updateOutlets];
    }];
}
// select
- (void)searchController:(JCAutocompletingSearchViewController *) searchController
               tableView:(UITableView *) tableView
          selectedResult:(id) result {
    __weak typeof (self) that = self;

    NSString *resultLabel = [(NSDictionary *)result objectForKey:@"label"];
    self.inputText = resultLabel;
    [searchController dismissViewControllerAnimated:YES completion:^{
        [that updateOutlets];
    }];
}


// Optional.
- (BOOL)searchControllerShouldPerformBlankSearchOnLoad:(JCAutocompletingSearchViewController *) searchController {
    return YES;
}

// Optional.
- (BOOL)searchController:(JCAutocompletingSearchViewController *) searchController shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation) interfaceOrientation {
    return YES;
}

// Optional.
- (dispatch_time_t)searchControllerDelaySearchingUntilQueryUnchangedForTimeOffset:(JCAutocompletingSearchViewController *) searchController {
    return (dispatch_time_t)(0.2 * NSEC_PER_SEC);
}

// Optional.
- (BOOL)searchControllerShouldDisplayNetworkActivityIndicator:(JCAutocompletingSearchViewController *) searchController {
    return YES; // Defaults to YES.
}

// Optional.
- (void)searchController:(JCAutocompletingSearchViewController *) searchController didChangeActivityInProgressToEnabled:(BOOL) activityInProgress {
    NSLog(@"Activity indicator changed to: %@", (activityInProgress ? @"YES" : @"NO"));
}

@end
