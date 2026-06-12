//
//  main.m
//  Better Buttons
//
//  Created by Darryl Ramm  on 6/11/26.
//

// main.m
#import <AppKit/AppKit.h>
#import "AppDelegate.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSApplication *app = [NSApplication sharedApplication];
        AppDelegate *delegate = [[AppDelegate alloc] init];
        app.delegate = delegate;
        [app run];
    }
    return 0;
}
