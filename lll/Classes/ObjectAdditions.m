//
//  ObjectAdditions.m
//  lll
//
//  Created by Cameron Pulsford on 7/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ObjectAdditions.h"
#import "Evaluator.h"
#import "PersistentList.h"
#import "Scope.h"
#import "Constants.h"
#import "Exception.h"

@implementation NSObject (Additions)
- (id)performSelector:(SEL)selector withObjects:(id <ISequence>)arguments andScope:(Scope *)scope
{
    if (self == nil || self == NIL) {
        RAISE_ERROR(UNSUPPORTEDOPERATION_EXCEPTION
                    ,@"nil does not respond to %@"
                    ,NSStringFromSelector(selector));
    }
    NSMethodSignature *ms = [self methodSignatureForSelector:selector];
    
    NSInvocation *inv = [NSInvocation invocationWithMethodSignature:ms];
    
    NSUInteger numberOfExpectedArguments = [ms numberOfArguments] - 2;
	
	if (numberOfExpectedArguments != [arguments count]) {
		RAISE_ERROR(ARITY_EXCEPTION
                    ,@"gave %ld args to %@ but expected %ld"
                    ,[arguments count]
                    ,NSStringFromSelector(selector)
                    ,numberOfExpectedArguments);
	}
    
    [inv setTarget:self];
    
    [inv setSelector:selector];
    
    // unbox the args and set them into the invocation
    
    id <ISequence> i;
    
    NSUInteger j;
    
    for (i = arguments, j = 2; [i seq]; i = [i more], j++) {
        id arg = evaluateAtom([i first], scope);
        
        const char *argType = [ms getArgumentTypeAtIndex:j];
        
        switch (*argType) {
            case '@':
            {
                [inv setArgument:&arg atIndex:j];
                break;
            }
            case 'c':
            {
                char a = [arg charValue];
                [inv setArgument:&a atIndex:j];
                break;
            }
            case 'C':
            {
                unsigned char a = [arg unsignedCharValue];
                [inv setArgument:&a atIndex:j];
                break;
            }
            case 'i':
            {
                int a = [arg intValue];
                [inv setArgument:&a atIndex:j];
                break;
            }
            case 'I':
            {
                unsigned int a = [arg unsignedIntValue];
                [inv setArgument:&a atIndex:j];
                break;
            }
            case 's': {
                short a = [arg shortValue];
                [inv setArgument:&a atIndex:j];
                break;
            }
            case 'S':
            {
                unsigned short a = [arg unsignedShortValue];
                [inv setArgument:&a atIndex:j];
                break;
            }
            case 'l': {
                long a = [arg longValue];
                [inv setArgument:&a atIndex:j];
                break;
            }
            case 'L':
            {
                unsigned long a = [arg unsignedLongValue];
                [inv setArgument:&a atIndex:j];
                break;
            }
            case 'q':
            {
                long long a = [arg longLongValue];
                [inv setArgument:&a atIndex:j];
                break;
            }
            case 'Q':
            {
                unsigned long long a = [arg unsignedLongLongValue];
                [inv setArgument:&a atIndex:j];
                break;
            }
            case 'f':
            {
                float a = [arg floatValue];
                [inv setArgument:&a atIndex:j];
                break;
            }
            case 'd':
            {
                double a = [arg doubleValue];
                [inv setArgument:&a atIndex:j];
                break;
            }
        }
    }
    
    [inv invoke];
    
    // box back up the return type
    
    id retValue;
    const char *retType = [ms methodReturnType];
    
    switch (*retType) 
    {
        case '@':
            [inv getReturnValue:&retValue];
            break;
        case 'c':
        {
            char buffer;
            [inv getReturnValue:&buffer];
            retValue = [NSDecimalNumber decimalNumberWithDecimal:[[NSNumber numberWithChar:buffer] decimalValue]];
            break;   
        }
        case 'C':
        {
            unsigned char buffer;
            [inv getReturnValue:&buffer];
            retValue = [NSDecimalNumber decimalNumberWithDecimal:[[NSNumber numberWithUnsignedChar:buffer] decimalValue]];
            break;   
        }
        case 's':
        {
            short buffer;
            [inv getReturnValue:&buffer];
            retValue = [NSDecimalNumber decimalNumberWithDecimal:[[NSNumber numberWithShort:buffer] decimalValue]];
            break;   
        }
        case 'S':
        {
            unsigned short buffer;
            [inv getReturnValue:&buffer];
            retValue = [NSDecimalNumber decimalNumberWithDecimal:[[NSNumber numberWithUnsignedShort:buffer] decimalValue]];
            break;   
        }
        case 'i':
        {
            int buffer;
            [inv getReturnValue:&buffer];
            retValue = [NSDecimalNumber decimalNumberWithDecimal:[[NSNumber numberWithInt:buffer] decimalValue]];
            break;
        }
        case 'I':
        {
            unsigned int buffer;
            [inv getReturnValue:&buffer];
            retValue = [NSDecimalNumber decimalNumberWithDecimal:[[NSNumber numberWithUnsignedInt:buffer] decimalValue]];
            break;
        }
        case 'l':
        {
            long buffer;
            [inv getReturnValue:&buffer];
            retValue = [NSDecimalNumber decimalNumberWithDecimal:[[NSNumber numberWithLong:buffer] decimalValue]];
            break;
        }
        case 'L':
        {
            unsigned long buffer;
            [inv getReturnValue:&buffer];
            retValue = [NSDecimalNumber decimalNumberWithDecimal:[[NSNumber numberWithUnsignedLong:buffer] decimalValue]];
            break;
        }
        case 'q':
        {
            unsigned long long buffer;
            [inv getReturnValue:&buffer];
            retValue = [NSDecimalNumber decimalNumberWithDecimal:[[NSNumber numberWithLongLong:buffer] decimalValue]];
            break;
        }
        case 'Q':
        {
            unsigned long long buffer;
            [inv getReturnValue:&buffer];
            retValue = [NSDecimalNumber decimalNumberWithDecimal:[[NSNumber numberWithUnsignedLongLong:buffer] decimalValue]];
            break;   
        }
        case 'f':
        {
            float buffer;
            [inv getReturnValue:&buffer];
            retValue = [NSDecimalNumber decimalNumberWithDecimal:[[NSNumber numberWithFloat:buffer] decimalValue]];
            break;
        }
        case 'd':
        {
            double buffer;
            [inv getReturnValue:&buffer];
            retValue = [NSDecimalNumber decimalNumberWithDecimal:[[NSNumber numberWithDouble:buffer] decimalValue]];
            break;
        }
// i'll figure this out later if necessary. selector literals might be nice
//        case '^': // pointer
//        case '{': // struct
//        case '[': // array
//            char *buffer;
//            retValue = [[[NSValue alloc] initWithBytes:buffer objCType:retType] autorelease];
    }
    
    return retValue;
}
@end
