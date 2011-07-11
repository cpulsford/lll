//
//  Symbol.m
//  ll
//
//  Created by Cameron Pulsford on 6/28/11.
//  Copyright 2011 SMD. All rights reserved.
//

#import "Symbol.h"


@implementation Symbol

static Class SELFCLASS;

@synthesize name = name_;

+ (void)initialize
{
    SELFCLASS = [self class];
}

- (void)dealloc
{
    [name_ release];
    
    [super dealloc];
}

- (id)initWithName:(NSString *)name
{
    if ((self = [super init])) {
        name_ = [name retain];
    }
    
    return self;
}

+ (id)withName:(NSString *)name
{
    return [[[self alloc] initWithName:name] autorelease];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"'%@", self.name];
}

- (BOOL)isEqual:(id)object
{
    if (self == object) {
        return YES;
    }
    
    if (SELFCLASS == [object class]) {
        return [self.name isEqualToString:[(Symbol *)object name]];
    }
    
    return NO;
}

@end


@implementation Keyword

- (NSString *)description
{
    return [NSString stringWithFormat:@":%@", self.name];
}

@end
