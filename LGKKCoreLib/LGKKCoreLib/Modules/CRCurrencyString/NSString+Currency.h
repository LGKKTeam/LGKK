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

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, kCurrency) {
    kUSDollar = 0,
    kCanadianDollar,
    kEuro,
    kUnitedArabEmiratesDirham,
    kAfghanAfghani,
    kAlbanianLek,
    kArmenianDram,
    kArgentinePeso,
    kAustralianDollar,
    kAzerbaijaniManat,
    kBosniaHerzegovinaConvertibleMark,
    kBangladeshiTaka,
    kBulgarianLev,
    kBahrainiDinar,
    kBurundianFranc,
    kBruneiDollar,
    kBolivianBoliviano,
    kBrazilianReal,
    kBotswananPula,
    kBelarusianRuble,
    kBelizeDollar,
    kCongoleseFranc,
    kSwissFranc,
    kChileanPeso,
    kChineseYuan,
    kColombianPeso,
    kCostaRicanColón,
    kCapeVerdeanEscudo,
    kCzechRepublicKoruna,
    kDjiboutianFranc,
    kDanishKrone,
    kDominicanPeso,
    kAlgerianDinar,
    kEstonianKroon,
    kEgyptianPound,
    kEritreanNakfa,
    kEthiopianBirr,
    kBritishPoundSterling,
    kGeorgianLari,
    kGhanaianCedi,
    kGuineanFranc,
    kGuatemalanQuetzal,
    kHongKongDollar,
    kHonduranLempira,
    kCroatianKuna,
    kHungarianForint,
    kIndonesianRupiah,
    kIsraeliNewSheqel,
    kIndianRupee,
    kIraqiDinar,
    kIranianRial,
    kIcelandicKróna,
    kJamaicanDollar,
    kJordanianDinar,
    kJapaneseYen,
    kKenyanShilling,
    kCambodianRiel,
    kComorianFranc,
    kSouthKoreanWon,
    kKuwaitiDinar,
    kKazakhstaniTenge,
    kLebanesePound,
    kSriLankanRupee,
    kLithuanianLitas,
    kLatvianLats,
    kLibyanDinar,
    kMoroccanDirham,
    kMoldovanLeu,
    kMalagasyAriary,
    kMacedonianDenar,
    kMyanmaKyat,
    kMacanesePataca,
    kMauritianRupee,
    kMexicanPeso,
    kMalaysianRinggit,
    kMozambicanMetical,
    kNamibianDollar,
    kNigerianNaira,
    kNicaraguanCórdoba,
    kNorwegianKrone,
    kNepaleseRupee,
    kNewZealandDollar,
    kOmaniRial,
    kPanamanianBalboa,
    kPeruvianNuevoSol,
    kPhilippinePeso,
    kPakistaniRupee,
    kPolishZloty,
    kParaguayanGuarani,
    kQatariRial,
    kRomanianLeu,
    kSerbianDinar,
    kRussianRuble,
    kRwandanFranc,
    kSaudiRiyal,
    kSudanesePound,
    kSwedishKrona,
    kSingaporeDollar,
    kSomaliShilling,
    kSyrianPound,
    kThaiBaht,
    kTunisianDinar,
    kTonganPaanga,
    kTurkishLira,
    kTrinidadandTobagoDollar,
    kNewTaiwanDollar,
    kTanzanianShilling,
    kUkrainianHryvnia,
    kUgandanShilling,
    kUruguayanPeso,
    kUzbekistanSom,
    kVenezuelanBolívar,
    kVietnameseDong,
    kCFAFrancBEAC,
    kCFAFrancBCEAO,
    kYemeniRial,
    kSouthAfricanRand,
    kZambianKwacha
};

#define kCurrencyCode(currency) [@[@"USD",@"CAD",@"EUR",@"AED",@"AFN",@"ALL",@"AMD",@"ARS",@"AUD",@"AZN",@"BAM",@"BDT",@"BGN",@"BHD",@"BIF",@"BND",@"BOB",@"BRL",@"BWP",@"BYR",@"BZD",@"CDF",@"CHF",@"CLP",@"CNY",@"COP",@"CRC",@"CVE",@"CZK",@"DJF",@"DKK",@"DOP",@"DZD",@"EEK",@"EGP",@"ERN",@"ETB",@"GBP",@"GEL",@"GHS",@"GNF",@"GTQ",@"HKD",@"HNL",@"HRK",@"HUF",@"IDR",@"ILS",@"INR",@"IQD",@"IRR",@"ISK",@"JMD",@"JOD",@"JPY",@"KES",@"KHR",@"KMF",@"KRW",@"KWD",@"KZT",@"LBP",@"LKR",@"LTL",@"LVL",@"LYD",@"MAD",@"MDL",@"MGA",@"MKD",@"MMK",@"MOP",@"MUR",@"MXN",@"MYR",@"MZN",@"NAD",@"NGN",@"NIO",@"NOK",@"NPR",@"NZD",@"OMR",@"PAB",@"PEN",@"PHP",@"PKR",@"PLN",@"PYG",@"QAR",@"RON",@"RSD",@"RUB",@"RWF",@"SAR",@"SDG",@"SEK",@"SGD",@"SOS",@"SYP",@"THB",@"TND",@"TOP",@"TRY",@"TTD",@"TWD",@"TZS",@"UAH",@"UGX",@"UYU",@"UZS",@"VEF",@"VND",@"XAF",@"XOF",@"YER",@"ZAR",@"ZMK"] objectAtIndex:currency]


typedef enum {
    kCurrencyStyleSymbol,
    kCurrencyStyleCode,
    kCurrencyStyleName,
    kCurrencyStyleNativeSymbol,
} kCurrencyStyle;


@interface NSString (Currency)
+(NSDictionary *)allCurrenciesDict ;
+(NSString *)currencyStringWithCentsAmount:(int)cents
                                  currency:(kCurrency)currency
                                  andStyle:(kCurrencyStyle)style;

+(NSString *)currencyStringWithCentsAmount:(int)cents
                              currencyCode:(NSString *)currencyCode
                                  andStyle:(kCurrencyStyle)style;

@end
