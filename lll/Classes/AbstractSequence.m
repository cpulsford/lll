//
//  AbstractSequence.m
//  lll
//
//  Created by Cameron Pulsford on 7/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AbstractSequence.h"
#import "PersistentList.h"
#import "Exception.h"

@implementation AbstractSequence

- (NSString *)description
{
    return [NSString stringWithFormat:@"(%@)", [[self reify] componentsJoinedByString:@" "]];
}

+ (id <ISequence>)createFromArray:(NSArray *)array
{
    id <ISequence> pl = [PersistentList empty];
    
    NSInteger i;
    
    for (i = [array count] - 1; i >= 0; i--) {
        pl = [pl cons:[array objectAtIndex:i]];
    }
    
    return pl;
}

- (NSArray *)reify
{
    NSMutableArray *a = [NSMutableArray array];
    
    id <ISequence> s;
    
    for (s = self; [s seq]; s = [s more]) {
        [a addObject:[s first]];
    }
    
    return [NSArray arrayWithArray:a];
}

- (id <ISequence>)seq
{
    return self;
}

+ (id <ISequence>)empty
{
    unsupportedOperation;
}

- (id)first
{
    unsupportedOperation;
}

- (id <ISequence>)next
{
    unsupportedOperation;
}

- (id <ISequence>)more
{
    unsupportedOperation;
}

- (id <ISequence>)cons:(id)value
{
    unsupportedOperation;
}

- (NSUInteger)count
{
    unsupportedOperation;
}

@end
