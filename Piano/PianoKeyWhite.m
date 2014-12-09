//
//  PianoKeyWhite.m
//  BurpAndFartPiano
//
//  Created by Sam Meech-Ward on 2014-08-01.
//  Copyright (c) 2014 Sam Meech-Ward. All rights reserved.
//

#import "PianoKeyWhite.h"

@implementation PianoKeyWhite

-(void)setup {
    self.borderColor = [UIColor blackColor].CGColor;
    self.borderWidth = 1.0;
    // Set background color as the up (normal) background color
    [self up];
}

-(void)down {
    [super down];
    self.backgroundColor = [UIColor grayColor].CGColor;
}
-(void)up {
    [super up];
    self.backgroundColor = [UIColor whiteColor].CGColor;
}


@end
