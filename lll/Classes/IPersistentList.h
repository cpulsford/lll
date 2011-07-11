//
//  IPersistentList.h
//  lll
//
//  Created by Cameron Pulsford on 7/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ISequence.h"
#import "ICounted.h"
#import "IAssociative.h"

@protocol IPersistentList <ISequence, ICounted, IAssociative>
@end
