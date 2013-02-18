//
// Created by azu on 2013/02/11.
//


#import <Foundation/Foundation.h>
#import <JCAutocompletingSearch/JCAutocompletingSearchViewControllerDelegate.h>

@protocol AZJCAutocompletingSearchBarDelegate <JCAutocompletingSearchViewControllerDelegate>
// input delegate
- (void)searchControllerSubmit:(JCAutocompletingSearchViewController *) searchController inputResultText:(NSString *)result;

@end