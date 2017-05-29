//
//  SPBaseUtils.swift
//  drivethrough
//
//  Created by Duc iOS on 3/22/17.
//  Copyright © 2017 SP. All rights reserved.
//

import Foundation
import Stripe

public struct Platform {
    public static var isSimulator: Bool {
        return TARGET_OS_SIMULATOR != 0
    }
}

public enum CreditCardType: String {
    case none // pay at pickup
    case visa
    case master
    case jcb
    case discover
    case diners
    case applepay
    case amex
    case unknow
    
    public init(brand: String) {
        let brand = brand.lowercased()
        if brand.contains("visa") { self = .visa
        } else if brand.contains("master") { self = .master
        } else if brand.contains("jcb") { self = .jcb
        } else if brand.contains("discover") { self = .discover
        } else if brand.contains("diner") { self = .diners
        } else if brand.contains("apple") { self = .applepay
        } else if brand.contains("amex") { self = .amex
        } else { self = .unknow }
    }
}

public struct SPBaseUtils {
    public static func imageForCardType(creditCardType: CreditCardType) -> UIImage {
        var brand: STPCardBrand
        switch creditCardType {
        case .none: brand = .unknown
            break
        case .amex: brand = .amex
            break
        case .master: brand = .masterCard
            break
        case .discover: brand = .discover
            break
        case .jcb: brand = .JCB
            break
        case .diners: brand = .dinersClub
            break
        case .visa: brand = .visa
            break
        default: brand = .unknown
            break
        }
        if creditCardType == .applepay {
            return STPImageLibrary.applePayCardImage()
        }
        return STPImageLibrary.brandImage(for: brand)
    }
}
