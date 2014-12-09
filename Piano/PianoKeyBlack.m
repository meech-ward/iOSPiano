//
//  PianoKeyBlack.m
//  BurpAndFartPiano
//
//  Created by Sam Meech-Ward on 2014-08-01.
//  Copyright (c) 2014 Sam Meech-Ward. All rights reserved.
//

#import "PianoKeyBlack.h"

@implementation PianoKeyBlack

-(void)setup {
    // Set background color as the up (normal) background color
    [self up];
}

-(void)down {
    [super down];
    self.backgroundColor = [UIColor grayColor].CGColor;
}
-(void)up {
    [super up];
    self.backgroundColor = [UIColor blackColor].CGColor;
}

@end
