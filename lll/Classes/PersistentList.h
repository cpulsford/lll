//
//  PersistentList.h
//  lll
//
//  Created by Cameron Pulsford on 7/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "IPersistentList.h"
#import "AbstractSequence.h"

@interface EmptyList : AbstractSequence <IPersistentList>
@end

@interface PersistentList : AbstractSequence <IPersistentList>
@end
