//
//  Cons.h
//  lll
//
//  Created by Cameron Pulsford on 7/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractSequence.h"

@protocol ISequence;

@interface Cons : AbstractSequence <ISequence>
+ (Cons *)consWithFirst:(id)obj andRest:(id <ISequence>)rest;
@end
