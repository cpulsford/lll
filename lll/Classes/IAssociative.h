//
//  IAssosciative.h
//  lll
//
//  Created by Cameron Pulsford on 7/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IAssociative <NSObject>

- (id)valueForKey:(id)key;

@optional

- (id)nth:(NSInteger)n;

@end
