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
#import "LispReader.h"
#import "NullAdditions.h"

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
    
    NSLog(@"CBP____ %@", [LispReader readString:@"((:hello (worldworld 1 2 3 4 '5)) world :hi '(mom))"]);
    
    NSLog(@"CBP____ %@", [LispReader readString:@"~'''`()"]);
    
    NSLog(@"CBP____ %@", [LispReader readString:@"(nil 1 1 2 3 4 5 6)"]);
    
    [pool release];

    return 0;
}
