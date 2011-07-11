//
//  main.m
//  lll
//
//  Created by Cameron Pulsford on 7/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Symbol.h"
int main(int argc, char *argv[])
{
    @autoreleasepool {
        NSMutableDictionary *d = [NSMutableDictionary dictionary];
        
        [d setObject:@"hello" forKey:[Symbol withName:@"what up"]];
        
        NSLog(@"%@", d);
        
        NSLog(@"%@", [d objectForKey:[Keyword withName:@"what up"]]);
        
    }
    
    return 0;
}
