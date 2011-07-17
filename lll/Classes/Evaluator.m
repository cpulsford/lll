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
    else if (![atom conformsToProtocol:@protocol(IPersistentList)]) {
        return atom;
    }
    
    id <ISequence> s = atom;
    
    id first = [s first];
    
    if ([first isEqual:STATIC]) {
        id <ISequence> c = [s more];
        
        Class target = NSClassFromString([evaluateAtom([c first], scope) name]);
        
        c = [c more];
        
        SEL selector = NSSelectorFromString([evaluateAtom([c first], scope) name]);
                
        return [target performSelector:selector withObjects:[c more] andScope:scope];
    }
    if ([first isEqual:INSTANCE]) {
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
    else {
        return NIL;
    }
}
