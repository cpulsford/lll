//
//  Symbol.m
//  ll
//
//  Created by Cameron Pulsford on 6/28/11.
//  Copyright 2011 SMD. All rights reserved.
//

#import "Symbol.h"

#define SYMBOL_HASH_OFFSET 1
#define KEYWORD_HASH_OFFSET 1

@implementation Symbol

@synthesize name = name_;

- (void)dealloc
{
    [name_ release];
    
    [super dealloc];
}

- (NSUInteger)hash
{
    return [self.name hash] + SYMBOL_HASH_OFFSET;
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
    return [NSString stringWithFormat:@"%@", self.name];
}

- (id)copyWithZone:(NSZone *)zone
{
    // copy name shallowly
    return [[[self class] allocWithZone:zone] initWithName:self.name];
}

- (BOOL)isEqual:(id)object
{
    if (self == object) {
        return YES;
    }
    
    // [Keyword withName:@"foo"] does not equal [Symbol withName:@"foo"]
    if ([self class] == [object class]) {
        return [self.name isEqualToString:[(Symbol *)object name]];
    }
    
    return NO;
}

@end


@implementation Keyword

- (NSUInteger)hash
{
    return [self.name hash] + KEYWORD_HASH_OFFSET;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@":%@", self.name];
}

@end
