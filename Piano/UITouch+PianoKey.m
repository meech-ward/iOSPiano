//
//  UITouch+PianoKey.m
//  BurpAndFartPiano
//
//  Created by Sam Meech-Ward on 2014-08-01.
//  Copyright (c) 2014 Sam Meech-Ward. All rights reserved.
//
#import <objc/runtime.h>
#import "UITouch+PianoKey.h"

static void * CurrentKeyPropertyKey = &CurrentKeyPropertyKey;
static void * LastKeyPropertyKey = &LastKeyPropertyKey;

@implementation UITouch (PianoKey)
@dynamic currentKey, lastKey;

-(void)reset {
    // Reset the values ready for a new set of keys
    self.currentKey = -1;
    self.lastKey = -1;
}

-(BOOL)isSameKey:(int)key {
    // Determine if the new key is the same as the current key
    self.lastKey = self.currentKey;
    self.currentKey = key;
    return self.currentKey == self.lastKey;
}

#pragma mark - getters and setters

-(int)currentKey {
    return [objc_getAssociatedObject(self, CurrentKeyPropertyKey) intValue];
}
-(void)setCurrentKey:(int)currentKey {
    objc_setAssociatedObject(self, CurrentKeyPropertyKey, [NSNumber numberWithInt:currentKey], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(int)lastKey {
    return [objc_getAssociatedObject(self, LastKeyPropertyKey) intValue];
}
-(void)setLastKey:(int)lastKey {
    objc_setAssociatedObject(self, LastKeyPropertyKey, [NSNumber numberWithInt:lastKey], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end
