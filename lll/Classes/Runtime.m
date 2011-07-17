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

- (id)init
{
    if ((self = [super init])) {
        globalScope_ = [[Scope alloc] init];
    }
    
    return self;
}

- (id)evaluateString:(NSString *)s;
{
    return evaluateAtom([LispReader readString:s], globalScope_);
}

@end
