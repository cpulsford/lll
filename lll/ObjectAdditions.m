//
//  ObjectAdditions.m
//  lll
//
//  Created by Cameron Pulsford on 7/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ObjectAdditions.h"
#import "Constants.h"
#import "Exception.h"

@implementation NSObject (Additions)
- (id)performSelector:(SEL)selector withObjects:(NSArray *)arguments
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
    
    NSUInteger i, j;
    
    for (i = 0, j = 2; i < numberOfExpectedArguments; i++, j++) {
        id arg = [arguments objectAtIndex:i];
        
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
    
    char *buffer;    
    id retValue;
    const char *retType = [ms methodReturnType];
    
    switch (*retType) 
    {
        case '@':
            [inv getReturnValue:&retValue];
            break;
        case 'c':
            [inv getReturnValue:&buffer];
            retValue = [NSDecimalNumber decimalNumberWithDecimal:[[NSNumber numberWithChar:*(char *)buffer] decimalValue]];
            break;
        case 'C':
            [inv getReturnValue:&buffer];
            retValue = [NSDecimalNumber decimalNumberWithDecimal:[[NSNumber numberWithUnsignedChar:*(unsigned char *)buffer] decimalValue]];
            break;
        case 's':
            [inv getReturnValue:&buffer];
            retValue = [NSDecimalNumber decimalNumberWithDecimal:[[NSNumber numberWithShort:*(short *)buffer] decimalValue]];
            break;
        case 'S':
            [inv getReturnValue:&buffer];
            retValue = [NSDecimalNumber decimalNumberWithDecimal:[[NSNumber numberWithUnsignedShort:*(unsigned short *)buffer] decimalValue]];
            break;
        case 'i':
            [inv getReturnValue:&buffer];
            retValue = [NSDecimalNumber decimalNumberWithDecimal:[[NSNumber numberWithInt:*(int *)buffer] decimalValue]];
            break;
        case 'I':
            [inv getReturnValue:&buffer];
            retValue = [NSDecimalNumber decimalNumberWithDecimal:[[NSNumber numberWithUnsignedInt:*(unsigned *)buffer] decimalValue]];
            break;
        case 'l':
            [inv getReturnValue:&buffer];
            retValue = [NSDecimalNumber decimalNumberWithDecimal:[[NSNumber numberWithLong:*(long *)buffer] decimalValue]];
            break;
        case 'L':
            [inv getReturnValue:&buffer];
            retValue = [NSDecimalNumber decimalNumberWithDecimal:[[NSNumber numberWithUnsignedLong:*(unsigned long *)buffer] decimalValue]];
            break;
        case 'q':
            [inv getReturnValue:&buffer];
            retValue = [NSDecimalNumber decimalNumberWithDecimal:[[NSNumber numberWithLongLong:*(long long *)buffer] decimalValue]];
            break;
        case 'Q':
            [inv getReturnValue:&buffer];
            retValue = [NSDecimalNumber decimalNumberWithDecimal:[[NSNumber numberWithUnsignedLongLong:*(unsigned long long *)buffer] decimalValue]];
            break;
        case 'f':
            [inv getReturnValue:&buffer];
            retValue = [NSDecimalNumber decimalNumberWithDecimal:[[NSNumber numberWithFloat:*(float *)buffer] decimalValue]];
            break;
        case 'd':
            [inv getReturnValue:&buffer];
            retValue = [NSDecimalNumber decimalNumberWithDecimal:[[NSNumber numberWithDouble:*(double *)buffer] decimalValue]];
            break;
        case '^': // pointer, no string stuff supported right now
        case '{': // struct, only simple ones containing only basic types right now
        case '[': // array, of whatever, just gets the address
            retValue = [[[NSValue alloc] initWithBytes:buffer objCType:retType] autorelease];
    }
    
    return retValue;
}
@end
