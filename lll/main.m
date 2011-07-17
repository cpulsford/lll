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

id <ISequence> cons(id x, id <ISequence> s);

id <ISequence> cons(id x, id <ISequence> s)
{
    if (!s) {
        return [PersistentList listWithValue:x];
    }
    else {
        return [s cons:x];
    }
}

int main(int argc, char *argv[])
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
//    NSMutableDictionary *d = [NSMutableDictionary dictionary];
    
    Runtime *rt = [[Runtime alloc] init];
    
    [rt evaluateString:@"(def cons (fn (x s) (instance s :cons: x)))"];
    
    PersistentList *pl = [LispReader readString:@"(cons -1 (cons 0 (cons 1 (cons 2 '()))))"];
    
    NSLog(@"CBP____ %@", [rt evaluateAtom:pl]);
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    [rt evaluateAtom:pl];
    NSLog(@"CBP____ %@", [rt evaluateAtom:pl]);
    

    
//    [d setObject:@"hello" forKey:[Symbol withName:@"what up"]];
//    
//    NSLog(@"%@", d);
//    
//    NSLog(@"%@", [d objectForKey:[Symbol withName:@"what up"]]);
//    
//    id <ISequence> pl1 = [PersistentList createFromArray:[NSArray arrayWithObjects:@"hello", @"world", nil]];
//    
//    pl1 = [pl1 cons:@"123"];
//    
//    NSLog(@"CBP____ %@", pl1);
//    
//    NSLog(@"CBP____ %@", [LispReader readString:@"((:hello (worldworld 1 2 3 4 '5)) world :hi '(mom))"]);
//    
//    NSLog(@"CBP____ %@", [LispReader readString:@"~'''`()"]);
//    
//    NSLog(@"CBP____ %@", [LispReader readString:@"(nil 1 1 2 3 4 5 6)"]);
//    
//    NSLog(@"CBP____ %@", [LispReader readString:@"(+ 1 2 3 4)"]);
//    
//    NSLog(@"%@ %@", cons(@"hello", nil), cons(@"hello", cons(@"world", nil)));
//    
////    NSLog(@"CBP____ %@", evaluateString(@"'()"));
//    
//    NSLog(@"CBP____ %@", evaluateString(@"((fn (a) (static :NSArray :arrayWithObject: a)) 100)"));
//    
//    NSLog(@"CBP____ %@", evaluateString(@"(def cons '(fn (x s) (instance s :cons: x)))"));
//    
//    NSLog(@"CBP____ %@", evaluateString(@"(cons 1 '())"));
//    
//    
//    PersistentList *pl = [LispReader readString:@"(static :NSArray :arrayWithObject: (instance (static :NSArray :arrayWithObject: 1) :indexOfObject: 1))"];
//    Scope *scope = [Scope scope];
//    NSLog(@"0");
//    evaluateAtom(pl, scope);
//    evaluateAtom(pl, scope);
//    NSLog(@"0");
    
    [pool release];

    return 0;
}
