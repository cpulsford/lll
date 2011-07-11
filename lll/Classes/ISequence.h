//
//  Sequence.h
//  lll
//
//  Created by Cameron Pulsford on 7/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ISequence <NSObject>

+ (id <ISequence>)empty;

+ (id <ISequence>)createFromArray:(NSArray *)array;

- (NSArray *)reify;

- (id <ISequence>)seq;

- (id)first;

- (id <ISequence>)next;

- (id <ISequence>)more;

- (id <ISequence>)cons:(id)value;

@end
