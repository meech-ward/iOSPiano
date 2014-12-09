//
//  PianoView.m
//  BurpAndFartPiano
//
//  Created by Sam Meech Ward on 2014-08-01.
//  Copyright (c) 2014 Appsamax Ltd. All rights reserved.
//

// Piano Keys
#import "UITouch+PianoKey.h"
#import "PianoKeyBlack.h"
#import "PianoKeyWhite.h"

#import "PianoView.h"

@interface PianoView()

// Create arrays to hold the piano keys
@property (nonatomic) NSArray *whiteKeys;
@property (nonatomic) NSArray *blackKeys;
@property (nonatomic) NSArray *allKeys;

@end

@implementation PianoView {
    float whiteKeyWidth;
}

#pragma mark - Setup

-(id)init {
    self = [super init];
    if (self) {
        // Enable multiple keys to be played at once
        self.multipleTouchEnabled = YES;
    }
    return self;
}

-(void)layoutSubviews {
    // Layout the keys here to ensure they are the correct size
    [self addWhiteKeys];
    [self addBlackKeys];
}

#pragma mark Piano Keys


-(void)addWhiteKeys {
    // Create an array to add the white keys to
    NSMutableArray *tempWhiteKeys = [[NSMutableArray alloc] init];
    
    // Set the width of the white keys relative to the size of the view
    whiteKeyWidth = (self.bounds.size.width/TOTAL_WHITE_KEYS);
    
    // Loop though the number of white keys
    for (int i = 0; i < TOTAL_WHITE_KEYS; i++) {
        
        PianoKeyWhite *whiteKey;
        CGRect whiteKeyFrame = CGRectMake(whiteKeyWidth*i, 0, whiteKeyWidth, self.bounds.size.height);
        // Check if key already exisits at index
        if (self.whiteKeys && self.whiteKeys.count > i) {
            // Use existing key
            whiteKey = self.whiteKeys[i];
            // Set its new frame
            whiteKey.frame = whiteKeyFrame;
        } else {
            // Create a new white piano key next to the last one
            whiteKey = [PianoKeyWhite newKeyWithFrame: whiteKeyFrame];
            whiteKey.pianoDelegate = self;
            
            // Set its key number to the value of i, this will be used later when the key is tapped
            whiteKey.keyNumber = i;
            
            // Add the piano key to the view
            [self.layer addSublayer:whiteKey];
        }
        // Add the current key to the array
        [tempWhiteKeys addObject:whiteKey];
    }
    
    // Setup the white keys array with all the white keys
    self.whiteKeys = [[NSArray alloc] initWithArray:tempWhiteKeys];
}

-(void)addBlackKeys {
    // Set the black key width relative to the white key width
    float blackWidth = whiteKeyWidth/1.5;
    
    // Set the black key x value to start in the center of the first two white keys
    PianoKeyWhite *secondWhiteKey = self.whiteKeys[1];
    float blackX = secondWhiteKey.frame.origin.x - (blackWidth/2);
    
    // Set the black key's height relative to the current view's size
    float blackHeight = self.bounds.size.height/2;

    // Create an array to add the white keys to
    NSMutableArray *tempBlackKeys = [[NSMutableArray alloc] init];
    
    // Setup loop variables
    BOOL flag = false;
    int current = 0;
    
    // Loop through the number of black keys
    for (int i = 0; i < TOTAL_BLACK_KEYS; i++) {
        
        // Declare the black key and its frame
        PianoKeyBlack *blackKey;
        CGRect blackKeyFrame = CGRectMake(blackX, 0, blackWidth, blackHeight);

        // Check if key already exisits at index
        if (self.blackKeys && self.blackKeys.count > i) {
            // Use existing key
            blackKey = self.blackKeys[i];
            // Set its new frame
            blackKey.frame = blackKeyFrame;
        } else {
            // Create a new black key
            blackKey = [PianoKeyBlack newKeyWithFrame:blackKeyFrame];
            blackKey.pianoDelegate = self;
            
            // Set its key number to the value of i, this will be used later when the key is tapped
            blackKey.keyNumber = i;
            
            // Add it to the view and array
            [self.layer addSublayer:blackKey];
        }
        
        // Add it to the temp array
        [tempBlackKeys addObject:blackKey];
        
        // Adjust the x value for the next black key
        blackX += whiteKeyWidth;
        
        
        // Adjust the x value so that it alternates between groups of 2 and 3 black keys, with 1 black key at the start
        if (i == 0 || (flag && current == 2) || (!flag && current == 3)) {
            flag = !flag;
            current = 0;
            blackX += whiteKeyWidth;
        }
        current++;
    }
    
    // Setup the black keys array with all the black keys
    self.blackKeys = [[NSArray alloc] initWithArray:tempBlackKeys];
}



#pragma mark - Piano Key Delegate

-(void)PianoKeyUp:(PianoKey *)key {
    [self.delegate PianoView:self keyUp:key.keyNumber];
}

-(void)PianoKeyDown:(PianoKey *)key {
    [self.delegate PianoView:self keyDown:key.keyNumber];
}




@end
