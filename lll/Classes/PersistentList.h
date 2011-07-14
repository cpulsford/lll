//
//  PersistentList.h
//  lll
//
//  Created by Cameron Pulsford on 7/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AbstractSequence.h"
#import "IPersistentList.h"

@interface PersistentList : AbstractSequence <IPersistentList>

+ (id)listWithValue:(id)x;

@end
