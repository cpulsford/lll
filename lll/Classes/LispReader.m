//
//  LispReader.m
//  lll
//
//  Created by Cameron Pulsford on 7/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LispReader.h"
#import "PersistentList.h"
#import "Symbol.h"

BOOL isWhitespace(unichar c);
BOOL isNumeric(unichar c);
id updateState(NSMutableArray *a, NSUInteger *x, NSDictionary *states);

@interface ListReader : LispReader
@end

@interface VectorReader : LispReader
@end

@interface MapReader : LispReader
@end

@interface QuoteReader : LispReader
@end

@interface QuasiquoteReader : LispReader
@end

@interface UnquoteReader : LispReader
@end

@interface StringReader : LispReader
@end

@interface NumberReader : LispReader
@end

@interface SymbolReader : LispReader
@end

@interface KeywordReader : LispReader
@end

@implementation LispReader
+ (id)readString:(NSString *)s fromStartPosition:(NSUInteger)x
{
    NSUInteger i, length;
    
    for (i = x, length = [s length]; i < length; i++) {
        unichar c = [s characterAtIndex:i];
        
        if (isWhitespace(c)) {
            continue;
        }
        
        switch (c) {
            case '(':
            {
                return [ListReader readString:s fromStartPosition:i];
            }
            case '[':
            {
                break;
            }
            case '{':
            {
                break;
            }
            case ')':
            {
                break;
            }
            case ']':
            {
                break;
            }
            case '}':
            {
                break;
            }
            case '\'':
            {
                return [QuoteReader readString:s fromStartPosition:i];
                break;
            }
            case '`':
            {
                // read quasiquoted symbol
                break;
            }
            case '~':
            {
                // read unquoted symbol
                break;
            }
            case '"':
            {
                // read string
                break;
            }
            case ':':
            {
                return [KeywordReader readString:s fromStartPosition:i];
                break;
            }
            default:
            {
                if (isNumeric(c)) {
                    return [NumberReader readString:s fromStartPosition:i];
                }
                else {
                    return [SymbolReader readString:s fromStartPosition:i];
                }
            }
        }
    }
    
    return nil;    
}
@end

@implementation ListReader
+ (id)readString:(NSString *)s fromStartPosition:(NSUInteger)x
{
    NSUInteger i, length;
    
    NSMutableArray *a = [NSMutableArray array];
    
    for (i = x + 1, length = [s length]; i < length;) {
        unichar c = [s characterAtIndex:i];
                
        if (isWhitespace(c)) {
            i++;
            continue;
        }
        else if (c == ')') {
            break;
        }
        
        updateState(a, &i, [LispReader readString:s fromStartPosition:i]);
    }
    
    return [NSDictionary dictionaryWithObjectsAndKeys:
            [PersistentList createFromArray:a], @"value",
            [NSNumber numberWithUnsignedInteger:i], @"index",
            nil];
}
@end

@implementation QuoteReader
+ (id)readString:(NSString *)s fromStartPosition:(NSUInteger)x
{
    NSUInteger i = x + 1;
    
    id value = updateState(nil, &i, [LispReader readString:s fromStartPosition:i]);
    
    return [NSDictionary dictionaryWithObjectsAndKeys:
            [PersistentList createFromArray:[NSArray arrayWithObjects:[Symbol withName:@"quote"], value, nil]], @"value",
            [NSNumber numberWithUnsignedInteger:i], @"index",
            nil];
}

@end

@implementation SymbolReader
+ (id)readString:(NSString *)s fromStartPosition:(NSUInteger)x
{
    NSMutableString *a = [NSMutableString string];
    
    NSUInteger i, length;
    
    for (i = x, length = [s length]; i < length; i++) {
        unichar c = [s characterAtIndex:i];
        
        if (isWhitespace(c)) {
            i--;
            break;
        }
        
        [a appendString:[NSString stringWithCharacters:&c length:1]];
        
    }
    
    return [NSDictionary dictionaryWithObjectsAndKeys:
            [Symbol withName:[NSString stringWithString:a]], @"value",
            [NSNumber numberWithUnsignedInteger:i], @"index",
            nil];
}
@end

@implementation KeywordReader
+ (id)readString:(NSString *)s fromStartPosition:(NSUInteger)x
{
    NSMutableString *a = [NSMutableString string];
    
    NSUInteger i, length;
    
    for (i = x + 1, length = [s length]; i < length; i++) {
        unichar c = [s characterAtIndex:i];
        
        if (isWhitespace(c)) {
            i--;
            break;
        }
        
        [a appendString:[NSString stringWithCharacters:&c length:1]];
        
    }
    
    return [NSDictionary dictionaryWithObjectsAndKeys:
            [Keyword withName:[NSString stringWithString:a]], @"value",
            [NSNumber numberWithUnsignedInteger:i], @"index",
            nil];
}
@end

@implementation NumberReader
+ (id)readString:(NSString *)s fromStartPosition:(NSUInteger)x
{
    NSMutableString *a = [NSMutableString string];
    
    NSUInteger i, length;
    
    for (i = x, length = [s length]; i < length; i++) {
        unichar c = [s characterAtIndex:i];
        
        if (isWhitespace(c) || !isNumeric(c)) {
            i--;
            break;
        }
        
        [a appendString:[NSString stringWithCharacters:&c length:1]];
    }
    
    return [NSDictionary dictionaryWithObjectsAndKeys:
            [NSDecimalNumber decimalNumberWithString:[NSString stringWithString:a]], @"value", // eventually I will do some custom parsing for specific obj-c types
            [NSNumber numberWithUnsignedInteger:i], @"index",
            nil];
}
@end


BOOL isWhitespace(unichar c)
{
    return (c == ' ' || c == ',');
}

BOOL isNumeric(unichar c)
{
    switch (c) {
        case '0':
        case '1':
        case '2':
        case '3':
        case '4':
        case '5':
        case '6':
        case '7':
        case '8':
        case '9':
        case '.':
        case '-':
        case '+':
        case 'e':
        case 'E':
            return YES;
        default:
            return NO;
    }
}

id updateState(NSMutableArray *a, NSUInteger *x, NSDictionary *states)
{
    id value = [states objectForKey:@"value"];
    
    [a addObject:value];
    
    *x = [[states objectForKey:@"index"] unsignedIntegerValue] + 1;
    
    return value;
}
