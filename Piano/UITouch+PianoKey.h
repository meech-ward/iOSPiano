//
//  UITouch+PianoKey.h
//  BurpAndFartPiano
//
//  Created by Sam Meech-Ward on 2014-08-01.
//  Copyright (c) 2014 Sam Meech-Ward. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITouch (PianoKey)

// Keep track of the current key and last key that is being touched
@property (nonatomic) int currentKey;
@property (nonatomic) int lastKey;
-(int)currentKey;
-(void)setCurrentKey:(int)currentKey;
-(int)lastKey;
-(void)setLastKey:(int)lastKey;

-(BOOL)isSameKey:(int)key;
-(void)reset;

@end
