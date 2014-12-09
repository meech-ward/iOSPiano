//
//  ViewController.m
//  Piano
//
//  Created by Sam Meech Ward on 2014-12-08.
//  Copyright (c) 2014 Sam Meech-Ward. All rights reserved.
//



#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Piano View Delegate

-(void)pianoView:(PianoView *)piano keyDown:(short)key {
    // Find the frequency using the piano key number
    // Equation found at http://en.wikipedia.org/wiki/Piano_key_frequencies
    float frequency = pow(pow(2, 1.0/12.0), key-49)*440;
    
    NSLog(@"piano key down: %i, frequency: %f", key, frequency);
}

-(void)pianoView:(PianoView *)piano keyUp:(short)key {
    
}

@end
