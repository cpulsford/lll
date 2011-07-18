//
//  Equality.h
//  clisp
//
//  Created by Cameron Pulsford on 6/13/11.
//  Copyright 2011 UMass Amherst. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ISequence.h"

@interface Bool : NSObject
- (id)initWithBool:(BOOL)val;
@end

@interface Equality : NSObject
+ (const Bool *)areEqual:(id <ISequence>)objs;
@end

const Bool * isTrue(const Bool *b);
const Bool * isFalse(const Bool *b);
BOOL isTruthy(id val); // these two are for implementing the if form. falsey = nil || NSNull || false
BOOL isFalsey(id val);