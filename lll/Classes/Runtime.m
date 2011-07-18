//
//  Runtime.m
//  lll
//
//  Created by Cameron Pulsford on 7/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Runtime.h"
#import "Scope.h"
#import "Evaluator.h"
#import "LispReader.h"

@implementation Runtime
{
    Scope *globalScope_;
}

- (void)dealloc
{
    [globalScope_ release];
    
    [super dealloc];
}

- (void)bootstrap
{
    [self evaluateString:@"(def defn (macro (fname args body) `(def ~fname (fn ~args ~body))))"];
    [self evaluateString:@"(def defmacro (macro (fname args body) `(def ~fname (macro ~args ~body))))"];
    [self evaluateString:@"(defn cons (x s) (static :RT :cons:withSeq: x s))"];
    [self evaluateString:@"(defn conj (s x) (static :RT :conj:withSeq: x s))"];
    [self evaluateString:@"(defn conj (s x) (static :RT :conj:withSeq: x s))"];
    [self evaluateString:@"(defn seq (s) (instance s :seq))"];
    [self evaluateString:@"(defn count (s) (instance s :count))"];
    [self evaluateString:@"(defn first (s) (instance s :first))"];
    [self evaluateString:@"(defn next (s) (instance s :next))"];
    [self evaluateString:@"(defn rest (s) (instance s :more))"];
    [self evaluateString:@"(defn ? (expr) (if expr true false))"];
    [self evaluateString:@"(defmacro when-let (binding form) `(let ~binding (if (first ~'binding) ~form)))"];
    [self evaluateString:@"(defn map (f s)                                \
                             (if (seq s)                                  \
                               (cons (f (first s))                        \
                                     (map f (rest s)))))"];
    
    [self evaluateString:@"(defn filter                             \
                             (f s)                                  \
                             (if (seq s)                            \
                               (let (e (f (first s)))               \
                                 (if e                              \
                                   (cons e (filter f (rest s)))     \
                                   (filter f (rest s))))))"];
}

- (id)init
{
    if ((self = [super init])) {
        globalScope_ = [[Scope rootScope] retain];
        
        [self bootstrap];
    }
    
    return self;
}

- (id)evaluateString:(NSString *)s;
{
    return evaluateAtom([readString(s) objectAtIndex:0], globalScope_);
}

- (id)evaluateAtom:(id <ISequence>)s
{
    return evaluateAtom(s, globalScope_);
}

@end
