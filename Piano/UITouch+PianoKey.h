//
//  UITouch+PianoKey.h
//  BurpAndFartPiano
//
//  Created by Sam Meech Ward on 2014-08-01.
//  Copyright (c) 2014 Appsamax Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITouch (PianoKey)

@property (nonatomic) int currentKey;
@property (nonatomic) int lastKey;
-(int)currentKey;
-(void)setCurrentKey:(int)currentKey;
-(int)lastKey;
-(void)setLastKey:(int)lastKey;

-(BOOL)isSameKey:(int)key;

-(void)reset;

@end
