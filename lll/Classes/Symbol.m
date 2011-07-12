//
//  Symbol.m
//  ll
//
//  Created by Cameron Pulsford on 6/28/11.
//  Copyright 2011 SMD. All rights reserved.
//

#import "Symbol.h"

@implementation Symbol

@synthesize name = name_;

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

- (id)copyWithZone:(NSZone *)zone
{
    // FIXME: this is broken I think
    return [[[self class] alloc] initWithName:[[self.name copyWithZone:zone] autorelease]];
}

- (BOOL)isEqual:(id)object
{
    if (self == object) {
        return YES;
    }
    
    // symbols and keywords are never equal
    if ([self class] == [object class]) {
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
