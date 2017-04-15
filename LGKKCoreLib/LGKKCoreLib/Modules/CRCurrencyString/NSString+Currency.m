// The MIT License (MIT)
//
// Copyright (c) 2016 Clément Raffenoux
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#import "NSString+Currency.h"

#define DEFAULT_DECIMAL_DIGITS 2
#define DEFAULT_DECIMAL_SEPARATOR @"."
#define DEFAULT_GROUPING_SEPARATOR @","
#define DEFAULT_USES_GROUPING_SEPARATOR YES
#define DEFAULT_SYMBOL_POSITION @"$#"
#define DEFAULT_CODE_POSITION @"$ #"
#define DEFAULT_NAME_POSITION @"# $"

@interface StringCurrency : NSString
@end

@implementation StringCurrency
@end

@implementation NSString (Currency)

+(NSString *)currencyStringWithCentsAmount:(int)cents
                              currencyCode:(NSString *)currencyCode
                                  andStyle:(kCurrencyStyle)style
{
    
    NSDictionary *currencyInfos = [self allCurrenciesDict][[currencyCode uppercaseString]];
    
    if (!currencyInfos) {
        NSLog(@"CRCurrencyString: Please pass a valid currency code");
        @throw NSInternalInconsistencyException;
    }
    
    NSString *placeholder = [self placeholderWithSymbolPosition:currencyInfos[@"symbol_position"]
                                                   codePosition:currencyInfos[@"code_position"]
                                                   namePosition:currencyInfos[@"name_position"]
                                                         symbol:currencyInfos[@"symbol"]
                                                   nativeSymbol:currencyInfos[@"symbol_native"]
                                                           code:currencyInfos[@"code"]
                                                           name:currencyInfos[@"name"]
                                                     pluralName:currencyInfos[@"name_plural"]
                                                        ammount:cents
                                                andCurrentStyle:style];
    
    NSString *formattedAmount = [self formattedStringAmountWithDecimalSeparator:currencyInfos[@"decimal_separator"]
                                                              groupingSeparator:currencyInfos[@"grouping_separator"]
                                                                  decimalDigits:currencyInfos[@"decimal_digits"]
                                                         usingGroupingSeparator:[currencyInfos[@"using_group_separator"] boolValue]
                                                                      andAmount:cents];
    
    NSString *string = [NSString stringWithFormat:placeholder, formattedAmount];
    return string;
}

+(NSString *)currencyStringWithCentsAmount:(int)cents currency:(kCurrency)currency andStyle:(kCurrencyStyle)style {
    return [self currencyStringWithCentsAmount:cents currencyCode:kCurrencyCode(currency) andStyle:style];
}


+(NSString *)placeholderWithSymbolPosition:(NSString *)symbolPosition
                              codePosition:(NSString *)codePosition
                              namePosition:(NSString *)namePosition
                                    symbol:(NSString *)symbol
                              nativeSymbol:(NSString *)nativeSymbol
                                      code:(NSString *)code
                                      name:(NSString *)name
                                pluralName:(NSString *)pluralName
                                   ammount:(int)cents
                           andCurrentStyle:(kCurrencyStyle)style {
    
    NSString *styleString;
    NSString *placeholder;
    
    switch (style) {
        case 0:
            styleString = symbol;
            placeholder = symbolPosition ? symbolPosition : DEFAULT_SYMBOL_POSITION;
            break;
        case 1:
            styleString = code;
            placeholder = codePosition ? codePosition : DEFAULT_CODE_POSITION;
            break;
        case 2:
            if (cents <= 100) {
                styleString = name;
            } else {
                styleString = pluralName;
            }
            placeholder = namePosition ? namePosition : DEFAULT_NAME_POSITION;
            break;
        case 3:
            styleString = nativeSymbol;
            placeholder = symbolPosition ? symbolPosition : DEFAULT_SYMBOL_POSITION;
        default:
            break;
    }
    
    placeholder = [placeholder stringByReplacingOccurrencesOfString:@"$" withString:styleString];
    placeholder = [placeholder stringByReplacingOccurrencesOfString:@"#" withString:@"%@"];
    return placeholder;
}


+(NSDictionary *)currencyDictForCurrency:(kCurrency)currency {
    NSString *key = [NSString stringWithFormat:@"%@", kCurrencyCode(currency)];
    return [self allCurrenciesDict][key];
}


+(NSDictionary *)allCurrenciesDict {
    
    NSString *jsonFilePath = [[NSBundle bundleForClass:[StringCurrency class]] pathForResource:@"currency" ofType:@"json"];
    NSError * error;
    NSString* fileContents = [NSString stringWithContentsOfFile:jsonFilePath encoding:NSUTF8StringEncoding error:&error];
    NSDictionary *currencies = [NSJSONSerialization
                                JSONObjectWithData:[fileContents dataUsingEncoding:NSUTF8StringEncoding]
                                options:0 error:NULL];
    return currencies;
}

+(NSString *)formattedStringAmountWithDecimalSeparator:(NSString *)decimalSeparator
                                     groupingSeparator:(NSString *)groupingSeparator
                                         decimalDigits:(NSNumber *)decimalDigits
                                usingGroupingSeparator:(BOOL)usingGroupingSeparator
                                             andAmount:(int)cents {
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    formatter.decimalSeparator = decimalSeparator ? decimalSeparator : DEFAULT_GROUPING_SEPARATOR;
    formatter.maximumFractionDigits = [decimalDigits integerValue] ? [decimalDigits integerValue] : DEFAULT_DECIMAL_DIGITS;
    formatter.minimumFractionDigits = [decimalDigits integerValue] ? [decimalDigits integerValue] : DEFAULT_DECIMAL_DIGITS;
    formatter.usesGroupingSeparator = usingGroupingSeparator ? usingGroupingSeparator : DEFAULT_USES_GROUPING_SEPARATOR;
    formatter.groupingSeparator = groupingSeparator ? groupingSeparator : DEFAULT_GROUPING_SEPARATOR;
    
    NSString *formattedAmmount = [formatter stringFromNumber:@((float)cents / 100)];
    return formattedAmmount;
}


@end
