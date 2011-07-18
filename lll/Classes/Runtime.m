//
//  Runtime.m
//  lll
//
//  Created by Cameron Pulsford on 7/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Runtime.h"
#import "Scope.h"
#import "Evaluator.h"
#import "LispReader.h"

@implementation Runtime
{
    Scope *globalScope_;
}

- (void)dealloc
{
    [globalScope_ release];
    
    [super dealloc];
}

- (void)bootstrap
{
    [self evaluateString:@"(def cons (fn (x s) (static :RT :cons:withSeq: x s)))"];
    [self evaluateString:@"(def conj (fn (s x) (static :RT :conj:withSeq: x s)))"];
}

- (id)init
{
    if ((self = [super init])) {
        globalScope_ = [[Scope alloc] init];
        
        [self bootstrap];
    }
    
    return self;
}

- (id)evaluateString:(NSString *)s;
{
    return evaluateAtom([LispReader readString:s], globalScope_);
}

- (id)evaluateAtom:(id <ISequence>)s
{
    return evaluateAtom(s, globalScope_);
}

@end
