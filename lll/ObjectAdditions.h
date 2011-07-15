//
//  ObjectAdditions.h
//  lll
//
//  Created by Cameron Pulsford on 7/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ISequence;
@class Scope;

@interface NSObject (Additions)
- (id)performSelector:(SEL)selector withObjects:(id <ISequence>)arguments andScope:(Scope *)scope;
@end
