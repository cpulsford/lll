//
//  Runtime.h
//  lll
//
//  Created by Cameron Pulsford on 7/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ISequence;

@interface Runtime : NSObject

- (id)evaluateString:(NSString *)s;

- (id)evaluateAtom:(id <ISequence>)s;

@end
