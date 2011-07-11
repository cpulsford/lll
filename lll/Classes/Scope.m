//
//  Scope.m
//  ll
//
//  Created by Cameron Pulsford on 6/28/11.
//  Copyright 2011 SMD. All rights reserved.
//

#import "Scope.h"
#import "Symbol.h"
#import "Exception.h"

@implementation Scope

@synthesize localVars   = localVars_;
@synthesize parentScope = parentScope_;

static Scope *GLOBAL;

+ (void)initialize
{
    GLOBAL = [[Scope alloc] init];
}

- (void)dealloc
{
    [localVars_ release];
    
    [super dealloc];
}

- (id)init
{
    if ((self = [super init])) {
        localVars_   = [[NSMutableDictionary alloc] init];
        parentScope_ = nil;
    }
    
    return self;
}

- (id)initWithParentScope:(Scope *)parentScope
{
    if ((self = [super init])) {
        localVars_   = [[NSMutableDictionary alloc] init];
        parentScope_ = parentScope;
    }
    
    return self;
}

+ (id)scope
{
    return [[[self alloc] init] autorelease];
}

+ (id)scopeWithParentScope:(Scope *)parentScope
{
    return [[[self alloc] initWithParentScope:parentScope] autorelease];
}

+ (id)scopeWithParentScope:(Scope *)parentScope
                 andValues:(NSArray *)values
                forSymbols:(NSArray *)symbols
{
    id newScope = [self scopeWithParentScope:parentScope];
    
    [newScope setValues:values forSymbols:symbols allowOverwriting:YES];
    
    return newScope;
}

+ (id)rootScope
{
    return GLOBAL;
}

- (id)valueForSymbol:(Symbol *)symbol
{
    id retValue;
    
    retValue = [self.localVars objectForKey:symbol];
    
    if (!retValue) {
        retValue = [self.parentScope valueForSymbol:symbol];
    }
    
    if (!retValue) {
        RAISE_ERROR(IMMUTABLESTATE_EXCEPTION, @"'%@' is not bound in this scope", symbol);
    }
    
    return retValue;
}

- (void)setValue:(id)value
       forSymbol:(Symbol *)symbol
allowOverwriting:(BOOL)allowOverwriting
{
    if (!allowOverwriting) {
        if ([self.localVars objectForKey:[symbol name]]) {
            RAISE_ERROR(IMMUTABLESTATE_EXCEPTION, @"'%@' is already bound in this scope", symbol);
        }
    }

    [self.localVars setObject:(value ? value : [NSNull null])
                       forKey:[symbol name]];
}

- (void)setValues:(NSArray *)values
       forSymbols:(NSArray *)symbols
 allowOverwriting:(BOOL)allowOverwriting
{
    NSUInteger i, length;
    
    for (i = 0, length = [values count]; i < length; i++) {
        [self setValue:[values objectAtIndex:i]
             forSymbol:[symbols objectAtIndex:i]
      allowOverwriting:allowOverwriting];
    }
}

- (NSString *)description
{
    NSMutableArray *scopes = [NSMutableArray array];
    
    Scope *s;
    
    for (s = self; s != nil; s = [s parentScope]) {
        [scopes insertObject:[s localVars] atIndex:0];
    }
    
    NSMutableDictionary *acc = [NSMutableDictionary dictionary];
    
    for (NSMutableDictionary *d in scopes) {
        [acc addEntriesFromDictionary:d];
    }
    
    return [acc description];
}

@end
