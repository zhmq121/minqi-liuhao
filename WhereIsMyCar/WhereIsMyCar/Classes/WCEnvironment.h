//
//  WCEnvironment.h
//  WhereIsMyCar
//
//  Created by Hao Liu on 10/15/13.
//  Copyright (c) 2013 Hao Liu. All rights reserved.
//

#ifndef WhereIsMyCar_WCEnvironment_h
#define WhereIsMyCar_WCEnvironment_h

#ifndef NSFoundationVersionNumber_iOS_7_0
#define NSFoundationVersionNumber_iOS_7_0 1047.0
#define _iOS_7_0 NSFoundationVersionNumber_iOS_7_0
#endif

#define SYSTEM_VERSION_EQUAL_TO(_v)                     (floor(NSFoundationVersionNumber) == _v ? YES : NO)
#define SYSTEM_VERSION_GREATER_THAN(_v)                 (floor(NSFoundationVersionNumber) >  _v ? YES : NO)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(_v)     (floor(NSFoundationVersionNumber) >= _v ? YES : NO)
#define SYSTEM_VERSION_LESS_THAN(_v)                    (floor(NSFoundationVersionNumber) <  _v ? YES : NO)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(_v)        (floor(NSFoundationVersionNumber) <= _v ? YES : NO)

#endif