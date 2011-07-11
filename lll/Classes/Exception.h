//
//  Exception.h
//  cam
//
//  Created by Cameron Pulsford on 5/30/11.
//  Copyright 2011 UMass Amherst. All rights reserved.
//

#import <Foundation/Foundation.h>


#define RAISE_ERROR(ll, s, ...) @throw [NSException exceptionWithName:(ll) reason:[NSString stringWithFormat:(s), ##__VA_ARGS__] userInfo:nil]


//#define IMMUTABLESTATE_EXCEPTION (@"Immutable State Exception")
//
//#define SYMBOL_EXCEPTION          (@"Invalid Symbol Exception")

#define UNSUPPORTEDOPERATION_EXCEPTION (@"Unsupported Operation Exception")
