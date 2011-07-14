//
//  Symbol.h
//  lll
//
//  Created by Cameron Pulsford on 6/28/11.
//  Copyright 2011 SMD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Symbol : NSObject <NSCopying>

+ (id)withName:(NSString *)name;

- (NSString *)name;

@end

@interface Keyword : Symbol
@end
