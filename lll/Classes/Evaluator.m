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
#import "Equality.h"

id <ISequence> evaluateQuasiquotedSeq(id <ISequence> seq, Scope *scope);

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
    else if ([first isEqual:QUASIQUOTE]) {
        return evaluateQuasiquotedSeq([[s more] first], scope);
    }
    else if ([first isEqual:IF]) {
        NSArray *args = [[s more] reify];
        
        if ([Bool isTruthy:evaluateAtom([args objectAtIndex:0], scope)]) {
            return evaluateAtom([args objectAtIndex:1], scope);
        }
        else if ([args count] == 3){
            return evaluateAtom([args objectAtIndex:2], scope);
        }
        else {
            return NIL;
        }
    }
    else if ([first isEqual:[Symbol withName:@"let"]]) {
        NSArray *args = [[s more] reify];
        
        NSArray *letExprs = [[args objectAtIndex:0] reify];
        
        Scope *newScope = [Scope scopeWithParentScope:scope];
        
        NSUInteger i, count;
        
        for (i = 0, count = [letExprs count]; i < count; i += 2) {
            [newScope setValue:evaluateAtom([letExprs objectAtIndex:i + 1], newScope) forSymbol:[letExprs objectAtIndex:i] allowOverwriting:YES];
        }
        
        return evaluateAtom([args objectAtIndex:1], newScope);
    }
    else if ([first isEqual:FN]) {
        return [Function fnWithForm:[s more] shouldEvaluateArgs:YES];
    }
    else if ([first isEqual:MACRO]) {
        return [Function fnWithForm:[s more] shouldEvaluateArgs:NO];
    }
    else if ([first isEqual:DEF]) {
        NSArray *array = [[s more] reify];
        [[Scope rootScope] setValue:evaluateAtom([array objectAtIndex:1], scope) forSymbol:[array objectAtIndex:0] allowOverwriting:YES];
        
        return NIL;
    }
    else {
        Function *f = evaluateAtom(first, scope);
        
        return [f invokeWithArgs:[s more] withinScope:scope];
    }
}

id <ISequence> evaluateQuasiquotedSeq(id <ISequence> seq, Scope *scope)
{
    id <ISequence> current;
    
    NSMutableArray *retArray = [NSMutableArray arrayWithCapacity:[seq count]];
    
    for (current = seq ; [current seq]; current = [current more]) {
        id atom = [current first];
        
        if ([atom conformsToProtocol:@protocol(IPersistentList)]) {
            if ([[atom first] isEqual:UNQUOTE]) {
                [retArray addObject:evaluateAtom([[atom more] first], scope)];
            }
            else {
                [retArray addObject:evaluateQuasiquotedSeq(atom, scope)];
            }
        }
        else {
            [retArray addObject:atom];
        }
    }
    
    return [PersistentList createFromArray:retArray];
}
