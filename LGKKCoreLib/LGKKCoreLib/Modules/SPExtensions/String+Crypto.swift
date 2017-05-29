//
//  String+Crypto.swift
//  spDirect
//
//  Created by Admin on 2/17/17.
//  Copyright © 2017 SiliconPrime. All rights reserved.
//

import Foundation
import CryptoSwift

// MARK: - Cryption
public enum SPCryptoMethod {
    case none
    case md5
    case sha1
    case sha224
    case sha256
    case sha384
    case sha512
    case sha3(SHA3.Variant)
    case crc32(seed: UInt32?, reflect: Bool)
    case crc16(seed: UInt16?)
    case encrypt(cipher: Cipher)
}

public extension String {
    public func encrypt(method: SPCryptoMethod) -> String {
        switch method {
        case .md5:
            return self.md5()
        case .sha1:
            return self.sha1()
        case .sha224:
            return self.sha224()
        case .sha256:
            return self.sha256()
        case .sha384:
            return self.sha384()
        case .sha512:
            return self.sha512()
        case .sha3(let variant):
            return self.sha3(variant)
        case .crc16(seed: let seed):
            return self.crc16(seed: seed)
        case .crc32(seed: let seed, reflect: let reflect):
            return self.crc32(seed: seed, reflect: reflect)
        case .encrypt(cipher: let cipher):
            do {
                return try self.encrypt(cipher: cipher)
            } catch {
                fatalError("encrypt failed with cipher: \(cipher)")
            }
            
        default:
            return self
        }
    }
    
    public func defaultEncrypt() -> String {
        return encrypt(method: SPCryptoMethod.sha256)
    }
}
