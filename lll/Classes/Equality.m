//
//  Equality.m
//  ll
//
//  Created by Cameron Pulsford on 7/3/11.
//  Copyright 2011 SMD. All rights reserved.
//

#import "Equality.h"
#import "Constants.h"

@implementation Bool
{
    BOOL value_;
}

- (id)initWithBool:(BOOL)val
{
    if ((self = [super init])) {
        value_ = val;
    }
    
    return self;
}

- (NSString *)description
{
    return value_ ? @"true" : @"false";
}

- (const Bool *)equalsTrue
{
    return self == T ? T : F;
}

- (const Bool *)equalsFalse
{
    return self == F ? T : F;
}

+ (BOOL)isTruthy:(id)val
{
    if (val == nil || val == NIL || val == F) {
        return NO;
    }
    
    return YES;
}

+ (BOOL)isFalsey:(id)val
{
    if (val == nil || val == NIL || val == F) {
        return YES;
    }
    
    return NO;
}

@end


@implementation Equality

+ (const Bool *)areEqual:(id <ISequence>)objs
{
    NSArray *array = [objs reify];
    
    NSUInteger objCount = [array count];
    
    NSUInteger i;
    
    id first = [array objectAtIndex:0];
    
    for (i = 1; i < objCount; i++) {
        if (![[array objectAtIndex:i] isEqual:first]) {
            return F;
        }
    }
    
    return T;
}

@end
