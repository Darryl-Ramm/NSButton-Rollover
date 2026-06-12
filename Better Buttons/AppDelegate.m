// AppDelegate.m
#import "AppDelegate.h"
#import "HoverBackgroundButton.h"

@interface AppDelegate ()
@property (strong) NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // 1. Setup minimal application menu
    NSMenu *mainMenu = [[NSMenu alloc] init];
    NSMenuItem *appMenuItem = [[NSMenuItem alloc] init];
    [mainMenu addItem:appMenuItem];
    [NSApp setMainMenu:mainMenu];
    
    NSMenu *appMenu = [[NSMenu alloc] init];
    NSMenuItem *quitMenuItem = [[NSMenuItem alloc] initWithTitle:@"Quit"
                                                           action:@selector(terminate:)
                                                    keyEquivalent:@"q"];
    [appMenu addItem:quitMenuItem];
    [appMenuItem setSubmenu:appMenu];

    // 2. Setup programmatic Window
    NSRect rect = NSMakeRect(0, 0, 300, 400);
    self.window = [[NSWindow alloc] initWithContentRect:rect
                                              styleMask:(NSWindowStyleMaskTitled | 
                                                         NSWindowStyleMaskClosable | 
                                                         NSWindowStyleMaskResizable)
                                                backing:NSBackingStoreBuffered
                                                  defer:NO];
    [self.window setTitle:@"Rollover Demo"];
    [self.window center];
    
    self.window.contentView.wantsLayer = YES;
    self.window.contentView.layer.backgroundColor = [NSColor colorWithWhite:0.95 alpha:1.0].CGColor;
    
    // 3. Setup Layout Stack
    NSStackView *stackView = [NSStackView stackViewWithViews:@[]];
    stackView.orientation = NSUserInterfaceLayoutOrientationVertical;
    stackView.spacing = 12.0;
    stackView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.window.contentView addSubview:stackView];
    
    [NSLayoutConstraint activateConstraints:@[
        [stackView.centerXAnchor constraintEqualToAnchor:self.window.contentView.centerXAnchor],
        [stackView.centerYAnchor constraintEqualToAnchor:self.window.contentView.centerYAnchor],
        [stackView.widthAnchor constraintEqualToConstant:160.0]
    ]];
    
    // 4. Instantiate custom buttons with specific Tooltips
    NSArray *titles = @[@"One", @"Two", @"Three", @"Four", @"Five"];
    for (NSUInteger i = 0; i < titles.count; i++) {
        NSString *title = titles[i];
        NSString *toolTip = [NSString stringWithFormat:@"This is the button %lu tool tip", (unsigned long)(i + 1)];
        
        HoverBackgroundButton *btn = [[HoverBackgroundButton alloc] initWithTitle:title 
                                                                          toolTip:toolTip 
                                                                          target:self 
                                                                          action:@selector(buttonClicked:)];
        [stackView addArrangedSubview:btn];
        [btn.widthAnchor constraintEqualToAnchor:stackView.widthAnchor].active = YES;
    }
    
    [self.window makeKeyAndOrderFront:nil];
}

// 5. Present the modal popup alert when triggered
- (void)buttonClicked:(id)sender {
    NSButton *button = (NSButton *)sender;
    
    NSAlert *alert = [[NSAlert alloc] init];
    [alert setMessageText:[NSString stringWithFormat:@"Button %@ pressed", button.title]];
    [alert setAlertStyle:NSAlertStyleInformational];
    [alert addButtonWithTitle:@"OK"]; // Standard default button dismiss key
    
    // Present the alert modal sheet attached to the primary window frame
    [alert beginSheetModalForWindow:self.window completionHandler:nil];
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
    return YES;
}

@end
