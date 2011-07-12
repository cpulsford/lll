//
//  PersistentList.m
//  lll
//
//  Created by Cameron Pulsford on 7/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PersistentList.h"
#import "Exception.h"

@implementation PersistentList
{
    id first_;
    
    id <IPersistentList> tail_;
    
    NSUInteger count_;
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

+ (id <ISequence>)empty
{
    static dispatch_once_t pred;
    
    static EmptyList *shared = nil;
    
    dispatch_once(&pred, ^{
        shared = [[EmptyList alloc] init];
    });
    
    return shared;
}

- (id)first
{
	return first_;
}

- (id <ISequence>)next
{
    return count_ == 1 ? nil : tail_;
}

- (id <ISequence>)more
{
    return count_ == 1 ? [PersistentList empty] : tail_;
}

- (id <ISequence>)cons:(id)value
{
    return [PersistentList persistentListWithFirst:value tail:self count:count_ + 1];
}

- (NSUInteger)count
{
	return count_;
}

- (id)valueForKey:(id)key
{
    return [self nth:[((NSNumber *)key) integerValue]];
}

- (id)nth:(NSInteger)n
{
    if (n >= count_ || n < 0) {
        RAISE_ERROR(INDEXOUTOFBOUNDS_EXCEPTION, @"%ld is out of range %ul", n, [self count]);
    }
    
    id <ISequence> s;
    
    NSInteger i;
    
    for (i = 0, s = self; i < n; i++, s = [s more]);
    
    return [s first];
}

@end

@implementation EmptyList

- (id <ISequence>)empty
{
    return self;
}

- (id <ISequence>)seq
{
    return nil;
}

- (id)first
{
    return nil;
}

- (id <ISequence>)next
{
    return nil;
}

- (id <ISequence>)more
{
    return self;
}

- (id <ISequence>)cons:(id)value
{
    return [PersistentList persistentListWithFirst:value tail:self count:1];
}

- (NSUInteger)count
{
    return 0;
}

@end
