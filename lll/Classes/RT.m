//
//  RT.m
//  lll
//
//  Created by Cameron Pulsford on 7/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RT.h"
#import "Constants.h"
#import "PersistentList.h"
#import "Cons.h"

@implementation RT

+ (id)cons:(id)x withSeq:(id <ISequence>)s
{
    if ([s conformsToProtocol:@protocol(IPersistentList)]) {
        return [s cons:x];
    }
    else if ([s isEqual:NIL]) {
        return [PersistentList listWithValue:x];
    }
    else {
        return [Cons consWithFirst:x andRest:s];
    }
}

+ (id)conj:(id)x withSeq:(id <ISequence>)s
{
    if ([s isEqual:NIL]) {
        return [PersistentList listWithValue:x];
    }
    else {
        return [s cons:x];
    }
}

@end
