//
//  Exception.h
//  cam
//
//  Created by Cameron Pulsford on 5/30/11.
//  Copyright 2011 UMass Amherst. All rights reserved.
//

#import <Foundation/Foundation.h>

#define RAISE_ERROR(ll, s, ...) @throw [NSException exceptionWithName:(ll) reason:[NSString stringWithFormat:(s), ##__VA_ARGS__] userInfo:nil]

#define UNSUPPORTEDOPERATION_EXCEPTION (@"Unsupported Operation Exception")

#define INDEXOUTOFBOUNDS_EXCEPTION     (@"Index Out of Bounds Exception")

#define IMMUTABLESTATE_EXCEPTION       (@"Immutable State Exception")

#define READER_EXCEPTION               (@"Reader Exception")

#define ARITY_EXCEPTION                (@"Arity Exception")

#define INVALIDSYMBOLNAME_EXCEPTION    (@"Invalid Symbol Name")
