//
// Created by azu on 2013/02/13.
//


#import "AZAutoCompletingList.h"


@implementation AZAutoCompletingList {

}

+ (NSString *)loadTextData {
    NSString *textFileName;
    NSString *textFilePath;
    textFileName = @"AZAutoCompleting_list.txt";
    textFilePath = [[[NSBundle bundleForClass:[self class]] resourcePath] stringByAppendingPathComponent:textFileName];
    // textFilePath で指定されたテキストファイルを UTF8 形式で開きます。
    NSError *error = nil;
    NSString *loadedData = [NSString stringWithContentsOfFile:textFilePath encoding:NSUTF8StringEncoding error:&error];
    if (error) {
        NSLog(@"when open , occur error : %@", [error localizedDescription]);
        return nil;
    }
    return loadedData;
}

+ (NSArray *)sharedList {

    static NSArray *itemList = nil;
    if (itemList == nil) {
        NSString *loadedData = [self loadTextData];
        if (loadedData == nil) {
            return nil;
        }
        itemList = [loadedData componentsSeparatedByString:@"\n"];
    }
    return itemList;
}
@end