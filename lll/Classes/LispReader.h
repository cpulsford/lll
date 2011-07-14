//
//  LispReader.h
//  lll
//
//  Created by Cameron Pulsford on 7/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LispReader : NSObject

+ (id)readString:(NSString *)s fromStartPosition:(NSUInteger)x;

@end
