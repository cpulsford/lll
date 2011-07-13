//
//  main.m
//  lll
//
//  Created by Cameron Pulsford on 7/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Symbol.h"
#import "PersistentList.h"

int main(int argc, char *argv[])
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    NSMutableDictionary *d = [NSMutableDictionary dictionary];
    
    [d setObject:@"hello" forKey:[Symbol withName:@"what up"]];
    
    NSLog(@"%@", d);
    
    NSLog(@"%@", [d objectForKey:[Symbol withName:@"what up"]]);
    
    id <ISequence> pl = [PersistentList createFromArray:[NSArray arrayWithObjects:@"hello", @"world", nil]];
    
    pl = [pl cons:@"yo yo!"];
    
    NSLog(@"CBP____ %@", pl);
    
    [pool release];

    return 0;
}
