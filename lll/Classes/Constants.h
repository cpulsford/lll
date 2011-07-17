//
//  Constants.h
//  ll
//
//  Created by Cameron Pulsford on 7/6/11.
//  Copyright 2011 SMD. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Bool, Symbol;

NSNull const *NIL;
Bool   const *T;
Bool   const *F;

Symbol const *QUOTE;
Symbol const *UNQUOTE;
Symbol const *QUASIQUOTE;
Symbol const *UNQUOTE_SPLICING;

Symbol const *FN;
Symbol const *MACRO;
Symbol const *IF;
Symbol const *DEF;

Symbol const *STATIC;
Symbol const *INSTANCE;

Symbol const *DO_ASSIGN;

Symbol const *VARIADIC;

Class SYMBOL_CLASS;
Class KEYWORD_CLASS;
Class BOOL_CLASS;

@interface Constants : NSObject
@end
