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
#import "Function.h"

id evaluateAtom(id atom, Scope *scope)
{
    Class atomClass = [atom class];
    
    if (SYMBOL_CLASS == atomClass) {
        return [scope valueForSymbol:atom];
    }
    else if (KEYWORD_CLASS == atomClass) {
        return atom;
    }
    else if (![atom conformsToProtocol:@protocol(IPersistentList)]) {
        return atom;
    }
    
    id <ISequence> s = (id <ISequence>)atom;
    
    id first = [s first];
    
    if ([first isEqual:STATIC]) {
        id <ISequence> c = [s more];
        
        Class target = NSClassFromString([evaluateAtom([c first], scope) name]);
        
        c = [c more];
        
        SEL selector = NSSelectorFromString([evaluateAtom([c first], scope) name]);
                
        return [target performSelector:selector withObjects:[c more] andScope:scope];
    }
    else if ([first isEqual:INSTANCE]) {
        id <ISequence> c = [s more];
        
        id target = evaluateAtom([c first], scope);
        
        c = [c more];
        
        SEL selector = NSSelectorFromString([evaluateAtom([c first], scope) name]);
                
        return [target performSelector:selector withObjects:[c more] andScope:scope];
    }
    else if ([first isEqual:QUOTE]) {
        return [[s more] first];
    }
    else if ([first isEqual:UNQUOTE]) {
        return evaluateAtom([[s more] first], scope);
    }
    else if ([first isEqual:FN]) {
        return [Function fnWithForm:[s more] shouldEvaluateArgs:YES];
    }
    else if ([first isEqual:MACRO]) {
        return [Function fnWithForm:[s more] shouldEvaluateArgs:NO];
    }
    else if ([first isEqual:DEF]) {
        NSArray *array = [[s more] reify];
        [scope setValue:evaluateAtom([array objectAtIndex:1], scope) forSymbol:[array objectAtIndex:0] allowOverwriting:YES];
        
        return NIL;
    }
    else {
        Function *f = evaluateAtom(first, scope);
        
        return [f invokeWithArgs:[s more] withinScope:scope];
    }
}
