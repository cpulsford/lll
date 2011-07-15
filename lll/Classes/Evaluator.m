//
//  Evaluator.m
//  lll
//
//  Created by Cameron Pulsford on 7/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Evaluator.h"
#import "LispReader.h"
#import "PersistentList.h"
#import "Scope.h"
#import "Constants.h"
#import "Symbol.h"
#import "ObjectAdditions.h"

id evaluateAtom(id atom, Scope *scope);

id evaluateString(NSString *s)
{
    return evaluateAtom([LispReader readString:s], [Scope scope]);
}

id evaluateAtom(id atom, Scope *scope)
{
    Class atomClass = [atom class];
    
    if (SYMBOL_CLASS == atomClass) {
        return [scope valueForSymbol:atom];
    }
    else if (KEYWORD_CLASS == atomClass) {
        return atom;
    }
    else if (![atom conformsToProtocol:@protocol(ISequence)]) {
        return atom;
    }
    
    id <ISequence> s = atom;
    
    id first = [s first];
    
    if ([first isEqual:STATIC]) {
        NSArray *args = [[s more] reify];
        Class target = NSClassFromString([evaluateAtom([args objectAtIndex:0], scope) name]);
        SEL selector = NSSelectorFromString([evaluateAtom([args objectAtIndex:1], scope) name]);
        NSArray *params = [args subarrayWithRange:NSMakeRange(2, [args count] - 2)];
        
        return [target performSelector:selector withObjects:params];
    }
    if ([first isEqual:INSTANCE]) {
        NSArray *args = [[s more] reify];
        id target = evaluateAtom([args objectAtIndex:0], scope);
        SEL selector = NSSelectorFromString([evaluateAtom([args objectAtIndex:1], scope) name]);
        NSArray *params = [args subarrayWithRange:NSMakeRange(2, [args count] - 2)];
        
        return [target performSelector:selector withObjects:params];
    }
    else if ([first isEqual:QUOTE]) {
        return [[s more] first];
    }
    else if ([first isEqual:UNQUOTE]) {
        return evaluateAtom([[s more] first], scope);
    }
    else {
        return NIL;
    }
}
