//
//  Evaluator.h
//  lll
//
//  Created by Cameron Pulsford on 7/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Scope;

id evaluateString(NSString *s);

id evaluateAtom(id atom, Scope *scope);
