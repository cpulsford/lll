//
//  Cons.m
//  lll
//
//  Created by Cameron Pulsford on 7/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Cons.h"
#import "PersistentList.h"

@implementation Cons
{
    id first_;

    id rest_;
}

- (id)initWithFirst:(id)obj andRest:(id <ISequence>)rest
{
    if ((self = [super init])) {
        first_ = [obj retain];
        rest_  = [rest retain];
    }
    
    return self;
}

+ (Cons *)consWithFirst:(id)obj andRest:(id <ISequence>)rest
{
    return [[[self alloc] initWithFirst:obj andRest:rest] autorelease];
}

- (id)first
{
    return first_;
}

- (id <ISequence>)next
{
    return rest_;
}

- (id <ISequence>)more
{
    return rest_ ? rest_ : [PersistentList empty];
}

- (id <ISequence>)cons:(id)value
{
    return [Cons consWithFirst:value andRest:self];
}


@end
