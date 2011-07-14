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

- (const Bool *)equalsTrue;
- (const Bool *)equalsFalse;

+ (BOOL)isTruthy:(id)val;
+ (BOOL)isFalsey:(id)val;

@end


@interface Equality : NSObject

+ (const Bool *)areEqual:(id <ISequence>)objs;

@end
