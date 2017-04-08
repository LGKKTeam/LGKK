//
//  String+MTExtensionTests.swift
//  MobileTrading
//
//  Created by Nguyen Minh on 4/8/17.
//  Copyright © 2017 AHDEnglish. All rights reserved.
//

import XCTest
import Nimble
import Quick
import CryptoSwift
@testable import MobileTrading

class String_MTExtensionTests: QuickSpec {
    
    override func spec() {
        
        it("test encrypt funcs") {
            let s1 = "12345678"
            expect(s1.encrypt(method: .md5)).to(equal("25d55ad283aa400af464c76d713c07ad"))
            expect(s1.encrypt(method: .sha1)).to(equal("7c222fb2927d828af22f592134e8932480637c0d"))
            expect(s1.encrypt(method: .sha224)).to(equal("7e6a4309ddf6e8866679f61ace4f621b0e3455ebac2e831a60f13cd1"))
            expect(s1.encrypt(method: .sha256)).to(equal("ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f"))
            expect(s1.encrypt(method: .sha384)).to(equal("8cafed2235386cc5855e75f0d34f103ccc183912e5f02446b77c66539f776e4bf2bf87339b4518a7cb1c2441c568b0f8"))
            expect(s1.encrypt(method: .sha512)).to(equal("fa585d89c851dd338a70dcf535aa2a92fee7836dd6aff1226583e88e0996293f16bc009c652826e0fc5c706695a03cddce372f139eff4d13959da6f1f5d3eabe"))
            expect(s1.encrypt(method: .sha3(SHA3.Variant.sha256))).to(equal("39d1da1f4f9fda75ac2c0b29b76c2149fe57256e3240ce35e1e74d6b6d898222"))
            expect(s1.encrypt(method: .crc32(seed: 0, reflect: false))).to(equal("df18865d"))
            expect(s1.encrypt(method: .crc16(seed: 0))).to(equal("3c9d"))
            
            do {
                let aes = try AES(key: "passwordpassword", iv: "drowssapdrowssap") // aes128
                let enCryptData = try s1.encrypt(cipher: aes)
                expect(enCryptData).notTo(beNil())
            } catch {}
            
            expect(s1.defaultEncrypt()).to(equal("25d55ad283aa400af464c76d713c07ad"))
        }
        
        it("test full encrypt") {
            let data  = Data(bytes: [0x01, 0x02, 0x03])
            let bytes = data.bytes
            let bytesHex    = Array<UInt8>(hex: "0x010203")
            let hexString   = bytesHex.toHexString()
            
            /*:
             # Digest
             */
            expect(data.md5()).notTo(beNil())
            expect(data.sha1()).notTo(beNil())
            expect(data.sha224()).notTo(beNil())
            expect(data.sha256()).notTo(beNil())
            expect(data.sha384()).notTo(beNil())
            expect(data.sha512()).notTo(beNil())
            
            expect(bytes.sha1()).notTo(beNil())
            expect("123".sha1()).notTo(beNil())
            expect(Digest.sha1(bytes)).notTo(beNil())
            
            //: Digest calculated incrementally
            do {
                var digest = MD5()
                let partial1 = try digest.update(withBytes: [0x31, 0x32])
                let partial2 = try digest.update(withBytes: [0x33])
                let result = try digest.finish()
            } catch { }
            
            /*:
             # CRC
             */
            expect(bytes.crc16()).notTo(beNil())
            expect(bytes.crc32()).notTo(beNil())
            
            /*:
             # HMAC
             */
            
            do {
                let key:Array<UInt8> = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,23,25,26,27,28,29,30,31,32]
                let poly1305 = try Poly1305(key: key).authenticate(bytes)
                expect(poly1305).notTo(beNil())
                let hmac = try HMAC(key: key, variant: .sha256).authenticate(bytes)
                expect(hmac).notTo(beNil())
            } catch {}
            
            /*:
             # PBKDF1, PBKDF2
             */
            
            do {
                let password: Array<UInt8> = Array("s33krit".utf8)
                let salt: Array<UInt8> = Array("nacllcan".utf8)
                
                let pkcs5 = try PKCS5.PBKDF1(password: password, salt: salt, variant: .sha1, iterations: 4096).calculate()
                expect(pkcs5).notTo(beNil())
                
                let value = try PKCS5.PBKDF2(password: password, salt: salt, iterations: 4096, variant: .sha256).calculate()
                expect(value).notTo(beNil())
                
            } catch {}
            
            /*:
             # Padding
             */
            let pkcs7 = PKCS7().add(to: bytes, blockSize: AES.blockSize)
            expect(pkcs7).notTo(beNil())
            
            /*:
             # ChaCha20
             */
            
            do {
                let key:Array<UInt8> = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32];
                let iv:Array<UInt8> =  [1, 2, 3, 4, 5, 6, 7, 8]
                let message = Array<UInt8>(repeating: 7, count: 10)
                
                let encrypted = try ChaCha20(key: key, iv: iv).encrypt(message)
                let decrypted = try ChaCha20(key: key, iv: iv).decrypt(encrypted)
                
                expect(encrypted).notTo(beNil())
                expect(decrypted).notTo(beNil())
                expect(decrypted).to(equal(message))
                
            } catch {
                print(error)
            }
            
            /*:
             # AES
             ### One-time shot.
             Encrypt all data at once.
             */
            do {
                let aes = try AES(key: "passwordpassword", iv: "drowssapdrowssap") // aes128
                let ciphertext = try aes.encrypt(Array("Nullam quis risus eget urna mollis ornare vel eu leo.".utf8))
                print(ciphertext.toHexString())
                
                expect(ciphertext).notTo(beNil())
                
            } catch {
                print(error)
            }
            
            /*:
             ### Incremental encryption
             Instantiate Encryptor for AES encryption (or decryptor for decryption) and process input data partially.
             */
            do {
                var encryptor = try AES(key: "passwordpassword", iv: "drowssapdrowssap").makeEncryptor()
                
                var ciphertext = Array<UInt8>()
                // aggregate partial results
                ciphertext += try encryptor.update(withBytes: Array("Nullam quis risus ".utf8))
                ciphertext += try encryptor.update(withBytes: Array("eget urna mollis ".utf8))
                ciphertext += try encryptor.update(withBytes: Array("ornare vel eu leo.".utf8))
                // finish at the end
                ciphertext += try encryptor.finish()
                
                print(ciphertext.toHexString())
                expect(ciphertext).notTo(beNil())
                
            } catch {
                print(error)
            }
            
            /*:
             ### Encrypt stream
             */
            do {
                // write until all is written
                func writeTo(stream: OutputStream, bytes: Array<UInt8>) {
                    var writtenCount = 0
                    while stream.hasSpaceAvailable && writtenCount < bytes.count {
                        writtenCount += stream.write(bytes, maxLength: bytes.count)
                    }
                }
                
                let aes = try AES(key: "passwordpassword", iv: "drowssapdrowssap")
                var encryptor = aes.makeEncryptor()
                
                // prepare streams
                let data = Data(bytes: (0..<100).map { $0 })
                let inputStream = InputStream(data: data)
                let outputStream = OutputStream(toMemory: ())
                inputStream.open()
                outputStream.open()
                
                var buffer = Array<UInt8>(repeating: 0, count: 2)
                
                // encrypt input stream data and write encrypted result to output stream
                while (inputStream.hasBytesAvailable) {
                    let readCount = inputStream.read(&buffer, maxLength: buffer.count)
                    if (readCount > 0) {
                        try encryptor.update(withBytes: buffer[0..<readCount]) { (bytes) in
                            writeTo(stream: outputStream, bytes: bytes)
                        }
                    }
                }
                
                // finalize encryption
                try encryptor.finish { (bytes) in
                    writeTo(stream: outputStream, bytes: bytes)
                }
                
                // print result
                if let ciphertext = outputStream.property(forKey: Stream.PropertyKey(rawValue: Stream.PropertyKey.dataWrittenToMemoryStreamKey.rawValue)) as? Data {
                    print("Encrypted stream data: \(ciphertext.toHexString())")
                }
                
            } catch {
                print(error)
            }
        }
    }
}
