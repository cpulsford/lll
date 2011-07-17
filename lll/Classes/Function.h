//
//  Function.h
//  lll
//
//  Created by Cameron Pulsford on 7/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ISequence;
@class Scope;

@interface Function : NSObject

+ (id)fnWithForm:(id <ISequence>)form shouldEvaluateArgs:(BOOL)isMacro;

- (id)invokeWithArgs:(id <ISequence>)form withinScope:(Scope *)scope;

@end
