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
#import "Exception.h"
#import "Constants.h"

NS_INLINE BOOL isWhitespace(unichar c);
NS_INLINE BOOL isNumeric(unichar c);
NS_INLINE BOOL isInvalidSymbolChar(unichar c);
NS_INLINE BOOL isValidInitialNumberChar(unichar c);
NS_INLINE BOOL isValidEndDelimeter(unichar c);

NS_INLINE id readNextExpression();
NS_INLINE id readList();
NS_INLINE id readQuote();
NS_INLINE id readQuasiquote();
NS_INLINE id readUnquote();
NS_INLINE id readKeyword();
NS_INLINE id readSymbol();
NS_INLINE id readNumber();

static NSUInteger start, count;
static NSString *s;

id readString(NSString *str)
{
    s = str;
    
    NSMutableArray *a = [NSMutableArray array];
    
    for (start = 0, count = [s length]; start < count; ) {
        id expression = readNextExpression();
        
        if (expression) {
            [a addObject:expression];
        }
    }
    
    return [NSArray arrayWithArray:a];
}

NS_INLINE id readNextExpression()
{    
    for ( ; start < count; ) {
        unichar c = [s characterAtIndex:start];
        
        if (isWhitespace(c)) {
            start += 1;
            continue;
        }
        
        switch (c) {
            case '(':
                return readList(s, start, count);
            case '[':
                return nil;
            case '{':
                return nil;
            case ')':
            case ']':
            case '}':
                RAISE_ERROR(READER_EXCEPTION, @"Unexpected delimeter %c", c);
            case '\'':
                return readQuote();
            case '`':
                return readQuasiquote();
            case '~':
                return readUnquote();
            case '"':
                return nil;
            case ':':
                return readKeyword();
            default:
                if (isValidInitialNumberChar(c)) {
                    return readNumber();
                }
                else {
                    return readSymbol();
                }
        }
    }
    
    return nil;
}

NS_INLINE id readList()
{    
    NSMutableArray *a = [NSMutableArray array];
    
    for (start += 1; start < count; ) {
        unichar c = [s characterAtIndex:start];
        
        if (isWhitespace(c)) {
            start += 1;
            continue;
        }
        else if (c == ')') {
            start += 1;
            break;
        }
        
        [a addObject:readNextExpression()];
    }
    
    return [PersistentList createFromArray:a];
}

NS_INLINE id readQuote()
{
    start += 1;
    
    id value = readNextExpression();
    
    return [PersistentList createFromArray:[NSArray arrayWithObjects:QUOTE, value, nil]];
}

NS_INLINE id readQuasiquote()
{
    start += 1;
    
    id value = readNextExpression();
    
    return [PersistentList createFromArray:[NSArray arrayWithObjects:QUASIQUOTE, value, nil]];
}

NS_INLINE id readUnquote()
{
    start += 1;
    
    id value = readNextExpression();
    
    return [PersistentList createFromArray:[NSArray arrayWithObjects:UNQUOTE, value, nil]];
}

NS_INLINE id readKeyword()
{
    NSMutableString *a = [NSMutableString string];
    
    start += 1;
    
    for ( ; start < count; start += 1) {
        unichar c = [s characterAtIndex:start];
        
        if (isInvalidSymbolChar(c)) {
            break;
        }
        
        [a appendString:[NSString stringWithCharacters:&c length:1]];
    }
    
    return [Keyword withName:[NSString stringWithString:a]];
}

NS_INLINE id readSymbol()
{
    NSMutableString *a = [NSMutableString string];
    
    for ( ; start < count; start += 1) {
        unichar c = [s characterAtIndex:start];
        
        if (isInvalidSymbolChar(c)) {
            break;
        }
        
        [a appendString:[NSString stringWithCharacters:&c length:1]];
        
    }
    
    // check if this is a special symbol
    if ([a isEqualToString:@"true"])
        return T;
    else if ([a isEqualToString:@"false"])
        return F;
    else if ([a isEqualToString:@"nil"])
        return NIL;
    else
        return [Symbol withName:[NSString stringWithString:a]];
}

NS_INLINE id readNumber()
{
    NSMutableString *a = [NSMutableString string];
    
    unichar first = [s characterAtIndex:start];
    unichar second = [s characterAtIndex:start + 1];
    
    switch (first) {
        case '-':
            if (isWhitespace(second)) {
                start += 1;
                return [Symbol withName:@"-"];
            }
            else {
                if (!isNumeric(second)) {
                    @throw [NSException exceptionWithName:@"ILLEGAL NUMBER CHARACTERS" reason:@"" userInfo:nil];
                }
                start += 2;
                [a appendString:[NSString stringWithCharacters:&first length:1]];
                [a appendString:[NSString stringWithCharacters:&second length:1]];
                break;
            }
        case '+':
            if (isWhitespace(second)) {
                start += 1;
                return [Symbol withName:@"+"];
            }
            else {
                if (!isNumeric(second)) {
                    @throw [NSException exceptionWithName:@"ILLEGAL NUMBER CHARACTERS" reason:@"" userInfo:nil];
                }
                start += 2;
                [a appendString:[NSString stringWithCharacters:&second length:1]];
                break;
            }
    }
    
    for ( ; start < count; start += 1) {
        unichar c = [s characterAtIndex:start];
        
        if (isWhitespace(c) || isValidEndDelimeter(c)) {
            break;
        }
        else if (!isNumeric(c)) {
            @throw [NSException exceptionWithName:@"ILLEGAL NUMBER CHARACTERS" reason:@"" userInfo:nil];
        }
        
        [a appendString:[NSString stringWithCharacters:&c length:1]];
    }
    
    return [NSDecimalNumber decimalNumberWithString:a];
}

NS_INLINE BOOL isWhitespace(unichar c)
{
    return (c == ' ' || c == ',');
}

NS_INLINE BOOL isNumeric(unichar c)
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

NS_INLINE BOOL isInvalidSymbolChar(unichar c)
{
    switch (c) {
        case ' ':
        case ',':
        case '(':
        case ')':
        case '[':
        case ']':
        case '{':
        case '}':
        case '\'':
        case '`':
        case '~':
            return YES;
        default:
            return NO;
    }
}

NS_INLINE BOOL isValidInitialNumberChar(unichar c)
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
        case '-':
        case '+':
            return YES;
        default:
            return NO;
    }
}

NS_INLINE BOOL isValidEndDelimeter(unichar c)
{
    switch (c) {
        case ')':
        case ']':
        case '}':
            return YES;
        default:
            return NO;
    }
}
