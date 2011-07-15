//
//  Constants.m
//  ll
//
//  Created by Cameron Pulsford on 7/6/11.
//  Copyright 2011 SMD. All rights reserved.
//

#import "Constants.h"
#import "Equality.h"
#import "Symbol.h"

NSNull const *NIL;
Bool const *T;
Bool const *F;

Symbol const *QUOTE;
Symbol const *UNQUOTE;
Symbol const *QUASIQUOTE;
Symbol const *UNQUOTE_SPLICING;

Symbol const *FN;
Symbol const *MACRO;
Symbol const *IF;

Symbol const *STATIC;
Symbol const *INSTANCE;

Symbol const *DO_ASSIGN;

Symbol const *VARIADIC;

Class SYMBOL_CLASS;
Class KEYWORD_CLASS;
Class BOOL_CLASS;

@implementation Constants
#pragma mark I'm having a hard time finding out if this is the most idiomatic way to do this. Seems to work for now.
+ (void)load
{
    NIL              = [[NSNull alloc] init];
    T                = [[Bool alloc] initWithBool:YES];
    F                = [[Bool alloc] initWithBool:NO];
    QUOTE            = [[Symbol alloc] initWithName:@"quote"];
    UNQUOTE          = [[Symbol alloc] initWithName:@"unquote"];
    QUASIQUOTE       = [[Symbol alloc] initWithName:@"quasiquote"];
    UNQUOTE_SPLICING = [[Symbol alloc] initWithName:@"unquote-splicing"];
    FN               = [[Symbol alloc] initWithName:@"fn"];
    MACRO            = [[Symbol alloc] initWithName:@"macro"];
    IF               = [[Symbol alloc] initWithName:@"if"];
    STATIC           = [[Symbol alloc] initWithName:@"static"];
    INSTANCE         = [[Symbol alloc] initWithName:@"instance"];
    DO_ASSIGN        = [[Symbol alloc] initWithName:@"do-assign"];
    VARIADIC         = [[Symbol alloc] initWithName:@"&"];
    SYMBOL_CLASS     = [Symbol class];
    KEYWORD_CLASS    = [Keyword class];
    BOOL_CLASS       = [Bool class];
}
@end
