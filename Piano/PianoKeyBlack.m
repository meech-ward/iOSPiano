//
//  PianoKeyBlack.m
//  BurpAndFartPiano
//
//  Created by Sam Meech Ward on 2014-08-01.
//  Copyright (c) 2014 Appsamax Ltd. All rights reserved.
//

#import "PianoKeyBlack.h"

@implementation PianoKeyBlack

-(void)setup {
    // Set background color as the up (normal) background color
    [self up];
}

-(void)down {
    self.backgroundColor = [UIColor grayColor].CGColor;
}
-(void)up {
    self.backgroundColor = [UIColor blackColor].CGColor;
}

@end