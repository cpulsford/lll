//
//  ObjectAdditions.h
//  lll
//
//  Created by Cameron Pulsford on 7/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Additions)
- (id)performSelector:(SEL)selector withObjects:(NSArray *)objects;
@end
