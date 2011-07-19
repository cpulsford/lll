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
#import "Evaluator.h"
#import "Runtime.h"
#import "Scope.h"
#import "RT.h"

int main(int argc, char *argv[])
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    Runtime *rt = [[[Runtime alloc] init] autorelease];
    
    PersistentList *p = readString(@"```''`'`'`'(:hello ''''''(world))");
    
    NSLog(@"%@", [rt evaluateAtom:p]);
        
    NSLog(@"%@", [rt evaluateString:@"(cons 1 '())"]);
    
    NSLog(@"%@", [rt evaluateString:@"(? (count '()))"]);
    NSLog(@"%@", [rt evaluateString:@"(? (seq '()))"]);
    
    NSLog(@"%@", [rt evaluateString:@"(let (a 1 b '(2 3 4 5)) (cons a b))"]);
    
    NSLog(@"%@", [rt evaluateString:@"(defmacro when-let (binding form) `(let ~binding (if (first ~'binding) ~form)))"]);
    
    NSLog(@"%@", [rt evaluateString:@"(when-let (a (seq '())) a)"]);
    
    NSLog(@"%@", [rt evaluateString:@"(when-let (a (count '())) a)"]);
    
    NSLog(@"%@", [rt evaluateString:@"(filter seq '((1 2 3) (4 5 6) () (7 8 9)))"]);
    
    PersistentList *pl = [readString(@"(map (fn (x) (cons x '())) '(1 2 3))") objectAtIndex:0];
    
    NSLog(@"%@", [rt evaluateString:@"(map (fn (x) (cons x '())) '(1 2 3))"]);
    
    [pool release];

    return 0;
}
