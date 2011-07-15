//
//  LispReader.h
//  lll
//
//  Created by Cameron Pulsford on 7/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

// FIX ME, something is definitely broken. CLosing brackets aren't looked for properly I think...

@interface LispReader : NSObject

+ (id)readString:(NSString *)s;

+ (id)readString:(NSString *)s fromStartPosition:(NSUInteger)x;

@end
