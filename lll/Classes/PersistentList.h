//
//  PersistentList.h
//  lll
//
//  Created by Cameron Pulsford on 7/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "IPersistentList.h"
#import "AbstractSequence.h"

@interface EmptyList : AbstractSequence <IPersistentList>
@end

@interface PersistentList : AbstractSequence <IPersistentList>
{
    id first_;
    
    id <IPersistentList> tail_;
    
    NSUInteger count_;
}

@property (nonatomic, readonly) id                  first;
@property (nonatomic, readonly) id<IPersistentList> tail;
@property (nonatomic, readonly) NSUInteger          count;

- (id)initWithFirst:(id)first tail:(id <IPersistentList>)tail count:(NSUInteger)count;

+ (id)persistentListWithFirst:(id)first tail:(id <IPersistentList>)tail count:(NSUInteger)count;

@end
