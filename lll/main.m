//
//  main.m
//  lll
//
//  Created by Cameron Pulsford on 7/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Symbol.h"
#import "PersistentList.h"
#import "LispReader.h"
#import "NullAdditions.h"
#import "Evaluator.h"
#import "Runtime.h"
#import "Scope.h"
#import "RT.h"

int main(int argc, char *argv[])
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
        
    Runtime *rt = [[Runtime alloc] init];
        
    PersistentList *pl = [LispReader readString:@"(cons -1 (cons 0 (cons 1 (cons 2 nil))))"];
    
    NSLog(@"CBP____ %@", [rt evaluateAtom:pl]);
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    NSLog(@"CBP____ %@", [rt evaluateAtom:pl]);
    
    [pool release];

    return 0;
}
