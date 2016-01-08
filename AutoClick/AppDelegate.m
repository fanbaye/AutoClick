//
//  AppDelegate.m
//  AutoClick
//
//  Created by lucas on 3/14/15.
//  Copyright (c) 2015 lucas. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate () <NSWindowDelegate>

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    self.window.delegate = self;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self _action];
    });
    
}

- (void)windowWillClose:(NSNotification *)notification
{
    exit(0);
}

- (void)_action
{
    CGPoint firstPoint = CGPointMake(200, 200);
    CGPoint secondPoint = CGPointMake(400, 350);
    // Move to posxXposy
    CGEventRef move1 = CGEventCreateMouseEvent(NULL, kCGEventMouseMoved, firstPoint, kCGMouseButtonLeft );
    CGEventRef move2 = CGEventCreateMouseEvent(NULL, kCGEventMouseMoved, secondPoint, kCGMouseButtonLeft );
    
    // Left button down at posxXposy
    CGEventRef click1_down = CGEventCreateMouseEvent(NULL, kCGEventLeftMouseDown, firstPoint, kCGMouseButtonLeft);
    CGEventRef click2_down = CGEventCreateMouseEvent(NULL, kCGEventLeftMouseDown, secondPoint, kCGMouseButtonLeft);
    
    // Left button up at posxXposy
    CGEventRef click1_up = CGEventCreateMouseEvent(NULL, kCGEventLeftMouseUp, firstPoint, kCGMouseButtonLeft);
    CGEventRef click2_up = CGEventCreateMouseEvent(NULL, kCGEventLeftMouseUp, secondPoint, kCGMouseButtonLeft);
    
    
    
    
    CGEventPost(kCGHIDEventTap, move1);
    CGEventPost(kCGHIDEventTap, click1_down);
    CGEventPost(kCGHIDEventTap, click1_up);
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((arc4random()%10) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CGEventPost(kCGHIDEventTap, move2);
        CGEventPost(kCGHIDEventTap, click2_down);
        CGEventPost(kCGHIDEventTap, click2_up);
        // Release the events
        
        CFRelease(move1);
        CFRelease(move2);
        CFRelease(click1_up);
        CFRelease(click2_up);
        CFRelease(click1_down);
        CFRelease(click2_down);
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((arc4random()%10) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self _action];
        });
    });
    
    
    
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
