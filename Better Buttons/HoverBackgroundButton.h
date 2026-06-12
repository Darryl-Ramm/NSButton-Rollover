// HoverBackgroundButton.h
#import <AppKit/AppKit.h>

@interface HoverBackgroundButton : NSButton

@property (nonatomic, assign) BOOL isHovered;

- (instancetype)initWithTitle:(NSString *)title 
                      toolTip:(NSString *)toolTipText 
                       target:(id)target 
                       action:(SEL)action;

@end
