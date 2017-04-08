//
//  String+MTExtension.swift
//  MobileTrading
//
//  Created by Nguyen Minh on 4/8/17.
//  Copyright © 2017 AHDEnglish. All rights reserved.
//

import UIKit
import CryptoSwift

// MARK: - Crypto method
enum MTCryptoMethod {
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

//MARK: - String extension
extension String {
    
    func aesEncrypt(key: String, iv: String) throws -> String {
        let data = self.data(using: .utf8)!
        let encrypted = try! AES(key: key, iv: iv, blockMode: .CBC, padding: PKCS7()).encrypt([UInt8](data))
        let encryptedData = Data(encrypted)
        return encryptedData.base64EncodedString()
    }
    
    func aesDecrypt(key: String, iv: String) throws -> String {
        let data = Data(base64Encoded: self)!
        let decrypted = try! AES(key: key, iv: iv, blockMode: .CBC, padding: PKCS7()).decrypt([UInt8](data))
        let decryptedData = Data(decrypted)
        return String(bytes: decryptedData.bytes, encoding: .utf8) ?? "Could not decrypt"
    }

    func encrypt(method: MTCryptoMethod) -> String {
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
            return try! self.encrypt(cipher: cipher)
        default:
            return self
        }
    }
    
    func defaultEncrypt() -> String {
        return encrypt(method: .md5)
    }
}
