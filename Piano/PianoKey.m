//
//  PianoKey.m
//  BurpAndFartPiano
//
//  Created by Sam Meech-Ward on 2014-08-01.
//  Copyright (c) 2014 Sam Meech-Ward. All rights reserved.
//

#import "PianoKey.h"

@interface PianoKey()

@property (nonatomic) BOOL isUp;
@property (nonatomic) BOOL isHighlighted;

@end

@implementation PianoKey

+(id)newKey {
    // Return a new key
    return [self newKeyWithFrame:CGRectMake(0, 0, 0, 0)];
}

+(id)newKeyWithFrame:(CGRect)frame {
    // Create a new piano key with the passed in frame
    PianoKey *key = [self layer];
    key.frame = frame;
    [key setup];
    return key;
}

-(void)down {
    [self.pianoDelegate pianoKeyDown:self];
}
-(void)up {
    [self.pianoDelegate pianoKeyUp:self];
}

// Abstract methods
-(void)setup {}

@end
