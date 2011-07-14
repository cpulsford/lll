//
//  Utils.h
//  lll
//
//  Created by Cameron Pulsford on 7/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Exception.h"

#define unsupportedOperation {RAISE_ERROR(UNSUPPORTEDOPERATION_EXCEPTION, @"%s is not supported on an abstract sequence", __FUNCTION__);}

void checkRange(NSInteger n, NSInteger count);
