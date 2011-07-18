//
//  Scope.h
//  ll
//
//  Created by Cameron Pulsford on 6/28/11.
//  Copyright 2011 SMD. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Symbol;

@interface Scope : NSObject

@property (readonly) NSMutableDictionary *localVars;
@property (readonly) Scope               *parentScope;

- (id)initWithParentScope:(Scope *)parentScope;

+ (id)scope;

+ (Scope *)scopeWithParentScope:(Scope *)parentScope;

+ (Scope *)scopeWithParentScope:(Scope *)parentScope
                      andValues:(NSArray *)values
                     forSymbols:(NSArray *)symbols;

+ (Scope *)rootScope;

- (Scope *)rootScope;

- (id)valueForSymbol:(Symbol *)symbol;

- (void)setValue:(id)value
       forSymbol:(Symbol *)symbol
allowOverwriting:(BOOL)allowOverwriting;

- (void)setValues:(NSArray *)values
       forSymbols:(NSArray *)symbols
 allowOverwriting:(BOOL)allowOverwriting;

@end
