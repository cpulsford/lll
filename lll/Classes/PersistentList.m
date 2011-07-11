//
//  PersistentList.m
//  lll
//
//  Created by Cameron Pulsford on 7/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PersistentList.h"

@implementation EmptyList

- (id <IPersistentList>)empty
{
    return self;
}

- (NSArray *)reify
{
    return [NSArray array];
}

- (id <IPersistentList>)seq
{
    return nil;
}

- (id)first
{
    return nil;
}

- (id <IPersistentList>)next
{
    return nil;
}

- (id <IPersistentList>)more
{
    return self;
}

- (id <IPersistentList>)cons:(id)value
{
    return [PersistentList persistentListWithFirst:value tail:self count:1];
}

- (NSUInteger)count
{
    return 0;
}

@end

@implementation PersistentList

@synthesize first = first_;
@synthesize tail  = tail_;
@synthesize count = count_;

static EmptyList *EMPTY;

+ (void)initialize
{
    EMPTY = [[EmptyList alloc] init];
}

- (void)dealloc
{
    [first_ release];
    
    [tail_ release];
    
    [super dealloc];
}

- (id)initWithFirst:(id)first tail:(id <IPersistentList>)tail count:(NSUInteger)count
{
    if ((self = [super init])) {
        first_ = [first retain];
        tail_  = [tail retain];
        count_ = count;
    }
    
    return self;
}

+ (id)persistentListWithFirst:(id)first tail:(id <IPersistentList>)tail count:(NSUInteger)count
{
    return [[[self alloc] initWithFirst:first tail:tail count:count] autorelease];
}

+ (id <IPersistentList>)empty
{
    return EMPTY;
}

- (id <IPersistentList>)seq
{
    return self;
}

- (id <IPersistentList>)next
{
    return count_ == 1 ? nil : tail_;
}

- (id <IPersistentList>)more
{
    return count_ == 1 ? EMPTY : tail_;
}

- (id <IPersistentList>)cons:(id)value
{
    return [PersistentList persistentListWithFirst:value tail:self count:count_ + 1];
}

- (id)valueForKey:(id)key
{
    return [self nth:[((NSNumber *)key) integerValue]];
}

- (id)nth:(NSInteger)n
{
    if (n >= count_ || n < 0) {
        @throw [NSException exceptionWithName:@"Index out of bounds" reason:nil userInfo:nil];
    }
    
    id <ISequence> s;
    
    NSInteger i;
    
    for (i = 0, s = self; i < n; i++, s = [s more]);
    
    return [s first];
}

@end
