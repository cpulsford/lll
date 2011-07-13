//
//  Utils.m
//  lll
//
//  Created by Cameron Pulsford on 7/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Utils.h"
#import "Exception.h"

void checkRange(NSInteger n, NSInteger count)
{    
    if (n >= count || n < 0) {
        RAISE_ERROR(INDEXOUTOFBOUNDS_EXCEPTION, @"%ld is out of range %ul", n, count);
    }   
}
