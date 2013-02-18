//
// Created by azu on 2013/02/08.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "AZCustomSearchBar.h"
#import "AZAutCompletingViewController.h"


@implementation AZCustomSearchBar {

}
UIImage *(^createImageFromUIColor)(UIColor *) = ^(UIColor *color) {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(contextRef, [color CGColor]);
    CGContextFillRect(contextRef, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
};

- (void)awakeFromNib {
    [super awakeFromNib];
    // 背景画像を透明にする
    [[UISearchBar appearanceWhenContainedIn:[AZAutCompletingViewController class], nil]
            setBackgroundImage:createImageFromUIColor([UIColor clearColor])];
    // 検索アイコンを変更(透明にする)
    [[UISearchBar appearanceWhenContainedIn:[AZAutCompletingViewController class], nil]
            setImage:createImageFromUIColor([UIColor clearColor]) forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];

//    for (UIView *subview in self.subviews) {
//
//        // テキストフィールドを特定、カスタマイズ
//        // UISearchBarTextField は UITextField のサブクラスらしい
//        if ([subview isKindOfClass:[UITextField class]]) {
//            // UIImage を渡せばそれが検索フィールドの背景になる. nil なら背景が消える
//            UITextField *textField = (UITextField *) subview;
//            [textField setBorderStyle:UITextBorderStyleNone];
//            [textField setBackgroundColor:[UIColor whiteColor]];
//            [textField setBackground:nil];
//            [textField setLeftView:nil];
//        }
//    }
}


@end