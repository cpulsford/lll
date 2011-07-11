//
//  Symbol.h
//  lll
//
//  Created by Cameron Pulsford on 6/28/11.
//  Copyright 2011 SMD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Symbol : NSObject <NSCopying>
{
    NSString *name_;
}

@property (readonly) NSString *name;

- (id)initWithName:(NSString *)name;

+ (id)withName:(NSString *)name;

@end

@interface Keyword : Symbol
@end
