//
//  PianoView.h
//  BurpAndFartPiano
//
//  Created by Sam Meech Ward on 2014-08-01.
//  Copyright (c) 2014 Appsamax Ltd. All rights reserved.
//

// Constants
#define TOTAL_WHITE_KEYS ((UInt8)52)
#define TOTAL_BLACK_KEYS ((UInt8)36)

// Frameworks
#import <UIKit/UIKit.h>

// Piano Key
#import "PianoKey.h"

// Declare a piano view delegate
@protocol PianoViewDelegate;

@interface PianoView : UIView <PianoKeyDelegate>

@property (nonatomic) IBOutlet id <PianoViewDelegate> delegate;

@end

// Setup the piano view delegate methods
@protocol PianoViewDelegate

@optional
-(void)pianoView:(PianoView *)piano keyDown:(short)key;
-(void)pianoView:(PianoView *)piano keyUp:(short)key;

@end