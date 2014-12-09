//
//  PianoView.m
//  BurpAndFartPiano
//
//  Created by Sam Meech-Ward on 2014-08-01.
//  Copyright (c) 2014 Sam Meech-Ward. All rights reserved.
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
    [self layoutPianoKeys];
}

#pragma mark - Piano Keys


-(void)layoutPianoKeys {
    // Check if keys have already been created
    BOOL alreadyCreated = (self.allKeys != nil && self.allKeys.count > 0);
    
    // Create temporary mutable arrays to add the keys to
    NSMutableArray *tempWhiteKeys = !alreadyCreated ? [[NSMutableArray alloc] init] : nil;
    NSMutableArray *tempBlackKeys = !alreadyCreated ? [[NSMutableArray alloc] init] : nil;
    NSMutableArray *tempAllKeys = !alreadyCreated ? [[NSMutableArray alloc] init] : nil;
    
    // Set up the piano key sizes
    whiteKeyWidth = (self.bounds.size.width/TOTAL_WHITE_KEYS);
    float blackWidth = whiteKeyWidth/1.5;
    float blackHeight = self.bounds.size.height/2;
    
    // Create a variable to hold the current key index
    int currentKeyIndex = 1;
    
    // Setup varaibles to help place the black keys
    BOOL blackGroupOfTwo = NO;
    int numberOfWhiteKeys = 0;
    int currentBlackKey = 0;
    
    // Loop though the number of white keys
    for (int i = 0; i < TOTAL_WHITE_KEYS; i++) {
        
        // Setup the white key frame
        CGRect whiteKeyFrame = CGRectMake(whiteKeyWidth*i, 0, whiteKeyWidth, self.bounds.size.height);
        
        // Check if keys already exisits
        if (alreadyCreated) {
            // Use existing key
            PianoKeyWhite *whiteKey = self.whiteKeys[i];
            // Set its new frame
            whiteKey.frame = whiteKeyFrame;
        } else {
            // Create a new white piano key next to the last one
            PianoKeyWhite *whiteKey = [PianoKeyWhite newKeyWithFrame: whiteKeyFrame];
            whiteKey.pianoDelegate = self;
            
            // Set its key number to the value of i, this will be used later when the key is tapped
            whiteKey.keyNumber = currentKeyIndex++;
            
            // Add the piano key to the view and temp array
            [self.layer insertSublayer:whiteKey atIndex:0];
            [tempWhiteKeys addObject:whiteKey];
            // Add the key to the all keys array
            [tempAllKeys addObject:whiteKey];
            
        }// White keys
        
        // Make sure not to exceed the total black keys
        if (currentBlackKey < TOTAL_BLACK_KEYS) {
            
            // Check if we need to add a black key, or if we leave a blank space
            BOOL lonelyBlackKey = i == 1; // If i == 1 leave a blank space because an 88 key keyboard has 1 black key to start
            BOOL groupOfTwo = (blackGroupOfTwo && numberOfWhiteKeys == 3);// Alternate between a group of two black keys and a group of three black keys
            BOOL groupOfThree = (!blackGroupOfTwo && numberOfWhiteKeys == 4);// A group of two black keys sits on top of a 3 white keys, a group of three black keys sits on top of 4 white keys
            if (lonelyBlackKey || groupOfTwo || groupOfThree) {
                // Leave a gap
                blackGroupOfTwo = !blackGroupOfTwo;
                numberOfWhiteKeys = 0;
            } else {
                // Add a new black key
                
                // Set black key size
                CGRect blackKeyFrame = CGRectMake(whiteKeyFrame.origin.x+whiteKeyFrame.size.width - (blackWidth/2), 0, blackWidth, blackHeight);
                
                // Check if key already exisits
                if (alreadyCreated) {
                    // Use existing key
                    PianoKeyBlack *blackKey = self.blackKeys[currentBlackKey];
                    // Set its new frame
                    blackKey.frame = blackKeyFrame;
                } else {
                    // Create a new black key
                    PianoKeyBlack *blackKey = [PianoKeyBlack newKeyWithFrame:blackKeyFrame];
                    blackKey.pianoDelegate = self;
                    
                    // Set its key number to the value of i, this will be used later when the key is tapped
                    blackKey.keyNumber = currentKeyIndex++;
                    
                    // Add it to the view and array
                    [self.layer insertSublayer:blackKey atIndex:1];
                    [tempBlackKeys addObject:blackKey];
                    // Add the key to the all keys array
                    [tempAllKeys addObject:blackKey];
                }
                currentBlackKey++;
            }
            numberOfWhiteKeys++;
        } // Black Keys
        
    } // For loop
    
    // Update the arrays
    if (!alreadyCreated) {
        self.blackKeys = [[NSArray alloc] initWithArray:tempBlackKeys];
        self.whiteKeys = [[NSArray alloc] initWithArray:tempWhiteKeys];
        self.allKeys = [[NSArray alloc] initWithArray:tempAllKeys];
    }
}

#pragma mark - Touches 

// Apple touch events

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        [touch reset];
    }
    [self touchesDown:touches];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [self touchesDown:touches];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self touchesUp:touches];
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [self touchesUp:touches];
}

// My touch events

-(void)touchesDown:(NSSet *)touches {
    // Loop through all the touches
    for (UITouch *touch in touches) {
        
        // Get the current key being touched
        int keyNumber = [self getKeyForPoint:[touch locationInView:self]];
        if (keyNumber < 0) { break; }
        
        // Check if the key is already being played
        if (![touch isSameKey:keyNumber]) {
            
            // Different Key
            PianoKey *newKey = [self.allKeys objectAtIndex:keyNumber-1];
            [newKey down];
            
            // Reset the old key
            int lastKeyNumber = [touch lastKey];
            if (lastKeyNumber > -1) {
                PianoKey *oldKey = [self.allKeys objectAtIndex:lastKeyNumber-1];
                [oldKey up];
            }
        }
    }
}

-(void)touchesUp:(NSSet *)touches {
    // Loop through all the touches
    for (UITouch *touch in touches) {
        
        //Reset the key and the touch
        int currentKey = [touch currentKey];
        if (currentKey < 0) { break; }
        PianoKey *key = [self.allKeys objectAtIndex:currentKey-1];
        [key up];
        [touch reset];
    }
}

-(int)getKeyForPoint:(CGPoint)point {
    // First loop through the black keys
    for (PianoKey *key in self.blackKeys) {
        if (CGRectContainsPoint(key.frame, point)) {
            return key.keyNumber;
        }
    }
    
    // Then check the white keys
    for (PianoKey *key in self.whiteKeys) {
        if (CGRectContainsPoint(key.frame, point)) {
            return key.keyNumber;
        }
    }
    
    // No key was tapped
    return -1;
}

#pragma mark - Piano Key Delegate

-(void)pianoKeyUp:(PianoKey *)key {
    [self.delegate pianoView:self keyUp:key.keyNumber];
}

-(void)pianoKeyDown:(PianoKey *)key {
    [self.delegate pianoView:self keyDown:key.keyNumber];
}

@end
