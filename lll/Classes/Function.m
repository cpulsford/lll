//
//  Function.m
//  lll
//
//  Created by Cameron Pulsford on 7/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Function.h"
#import "PersistentList.h"
#import "Scope.h"
#import "Evaluator.h"
#import "RT.h"

@implementation Function
{
    id <IPersistentList> args_;
    
    id <IPersistentList> body_;
    
    BOOL shouldEvaluateArgs_;
}

- (void)dealloc
{
    [args_ release];
    
    [body_ release];
    
    [super dealloc];
}

- (id)initWithForm:(id <IPersistentList>)form shouldEvaluateArgs:(BOOL)evalArgs
{
    if ((self = [super init])) {
        args_ = [[form first] retain];
        body_ = [[[form more] first] retain];
        shouldEvaluateArgs_ = evalArgs;
    }
    
    return self;
}

+ (id)fnWithForm:(id <IPersistentList>)form shouldEvaluateArgs:(BOOL)evalArgs
{
    return [[[self alloc] initWithForm:form shouldEvaluateArgs:evalArgs] autorelease];
}

- (id)invokeWithArgs:(id <IPersistentList>)args withinScope:(Scope *)scope
{
    Scope *newScope = [Scope scopeWithParentScope:scope];
    
    id <ISequence> cp, ca;
    
    for (cp = args_, ca = args; [cp seq]; cp = [cp more], ca = [ca more]) {
        Symbol *name = [cp first];
        id value = shouldEvaluateArgs_ ? evaluateAtom([ca first], newScope) : [ca first];
        
        [newScope setValue:value forSymbol:name allowOverwriting:YES];
    }
    
    id value = evaluateAtom(body_, newScope);
    
    if (shouldEvaluateArgs_) {
        return value;
    }
    else {
        return evaluateAtom(value, newScope);
    }
}

@end
