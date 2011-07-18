//
//  RT.h
//  lll
//
//  Created by Cameron Pulsford on 7/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ISequence;

@interface RT : NSObject

+ (id)cons:(id)x withSeq:(id <ISequence>)s;

+ (id)conj:(id)x withSeq:(id <ISequence>)s;

@end
