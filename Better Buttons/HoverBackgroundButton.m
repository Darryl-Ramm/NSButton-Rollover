// HoverBackgroundButton.m
#import "HoverBackgroundButton.h"

@implementation HoverBackgroundButton {
    NSTrackingArea *_trackingArea;
}

- (instancetype)initWithTitle:(NSString *)title 
                      toolTip:(NSString *)toolTipText 
                       target:(id)target 
                       action:(SEL)action {
    self = [super initWithFrame:NSZeroRect];
    if (self) {
        self.title = title;
        self.toolTip = toolTipText; // Sets native AppKit tooltip handling
        self.target = target;
        self.action = action;
        
        self.bordered = NO;
        self.wantsLayer = YES;
        self.contentTintColor = [NSColor blackColor];
        
        [self.heightAnchor constraintEqualToConstant:32.0].active = YES;
    }
    return self;
}

- (BOOL)wantsUpdateLayer {
    return YES;
}

- (void)updateLayer {
    [super updateLayer];
    
    self.layer.cornerRadius = self.bounds.size.height / 2.0;
    self.layer.borderWidth = 1.0;
    self.layer.borderColor = [NSColor colorWithWhite:0.85 alpha:1.0].CGColor;
    
    if (self.isHovered) {
        self.layer.backgroundColor = [NSColor colorWithWhite:0.90 alpha:1.0].CGColor;
    } else {
        self.layer.backgroundColor = [NSColor whiteColor].CGColor;
    }
}

- (void)updateTrackingAreas {
    [super updateTrackingAreas];
    if (_trackingArea) [self removeTrackingArea:_trackingArea];
    
    _trackingArea = [[NSTrackingArea alloc] initWithRect:self.bounds
                                                 options:NSTrackingMouseEnteredAndExited | 
                                                         NSTrackingActiveInActiveApp | 
                                                         NSTrackingInVisibleRect
                                                   owner:self
                                                userInfo:nil];
    [self addTrackingArea:_trackingArea];
}

- (void)mouseEntered:(NSEvent *)event {
    self.isHovered = YES;
    [self setNeedsDisplay:YES];
}

- (void)mouseExited:(NSEvent *)event {
    self.isHovered = NO;
    [self setNeedsDisplay:YES];
}

@end
