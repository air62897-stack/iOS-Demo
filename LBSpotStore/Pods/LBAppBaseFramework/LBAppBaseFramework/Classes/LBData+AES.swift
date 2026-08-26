//
//  LBData+AES.swift
//  LBAppBaseFramework
//
//  Created by ksnowlv on 2024/9/13.
//

import Foundation
import CommonCrypto

public extension Data {
    
    func aes256CBCEncrypt(_ key: Data, iv: Data) throws -> Data {
        let dataLength = self.count
        let keyLength = key.count
        let ivCount = kCCBlockSizeAES128
        let encryptedDataLength = dataLength + kCCBlockSizeAES128
        
        guard keyLength == kCCKeySizeAES256, iv.count == ivCount else {
            throw NSError(domain: "com.lbankdataextension_aes256Encrypt", code: -1, userInfo: [NSLocalizedDescriptionKey: "Key length must be 256 bits and IV must be 128 bits"])
        }
        
        var encryptedData = Data(count: encryptedDataLength)
        var numBytesEncrypted: size_t = 0
        
        let cryptStatus = encryptedData.withUnsafeMutableBytes { encryptedBytes in
            self.withUnsafeBytes { dataBytes in
                key.withUnsafeBytes { keyBytes in
                    iv.withUnsafeBytes { ivBytes in
                        CCCrypt(CCOperation(kCCEncrypt),
                                CCAlgorithm(kCCAlgorithmAES),
                                CCOptions(kCCOptionPKCS7Padding),
                                keyBytes.baseAddress, keyLength,
                                ivBytes.baseAddress,
                                dataBytes.baseAddress, dataLength,
                                encryptedBytes.baseAddress, encryptedDataLength,
                                &numBytesEncrypted)
                    }
                }
            }
        }
        
        guard cryptStatus == kCCSuccess else {
            throw NSError(domain: "com.lbankdataextension_aes256Encrypt", code: Int(cryptStatus))
        }
        
        encryptedData.count = numBytesEncrypted
        return encryptedData
    }
    
    func aes256CBCDecrypt(_ key: Data, iv: Data, encryptedData: Data) throws -> Data {
        let keyLength = key.count
        let ivCount = kCCBlockSizeAES128
        let decryptedDataLength = encryptedData.count
        
        guard keyLength == kCCKeySizeAES256, iv.count == ivCount else {
            throw NSError(domain: "com.lbankdataextension_aes256Decrypt", code: -1, userInfo: [NSLocalizedDescriptionKey: "Key length must be 256 bits and IV must be 128 bits"])
        }
        
        var decryptedData = Data(count: decryptedDataLength)
        var numBytesDecrypted: size_t = 0
        
        let cryptStatus = decryptedData.withUnsafeMutableBytes { decryptedBytes in
            encryptedData.withUnsafeBytes { encryptedDataBytes in
                key.withUnsafeBytes { keyBytes in
                    iv.withUnsafeBytes { ivBytes in
                        CCCrypt(CCOperation(kCCDecrypt),
                                CCAlgorithm(kCCAlgorithmAES),
                                CCOptions(kCCOptionPKCS7Padding),
                                keyBytes.baseAddress, keyLength,
                                ivBytes.baseAddress,
                                encryptedDataBytes.baseAddress, encryptedData.count,
                                decryptedBytes.baseAddress, decryptedDataLength,
                                &numBytesDecrypted)
                    }
                }
            }
        }
        
        guard cryptStatus == kCCSuccess else {
            throw NSError(domain: "com.lbankdataextension_aes256Decrypt", code: Int(cryptStatus))
        }
        
        decryptedData.count = numBytesDecrypted
        return decryptedData
    }
    
    
    func aes256ECBEncrypt(_ key:Data) throws -> Data {
        let dataLength = count
        let keyLength = key.count
        let encryptedDataLength = dataLength + kCCBlockSizeAES128
        
        var encryptedData = Data(count:encryptedDataLength)
        
        var numBytesEncrypted:size_t = 0
        try encryptedData.withUnsafeMutableBytes { encryptedBytes in
            try self.withUnsafeBytes { dataBytes in
                try key.withUnsafeBytes { keyBytes in
                    
                    let cryptStatus = CCCrypt(CCOperation(kCCEncrypt),
                                              CCAlgorithm(kCCAlgorithmAES),
                                              CCOptions(kCCOptionPKCS7Padding|kCCOptionECBMode),
                                              keyBytes.baseAddress,keyLength,
                                              nil,
                                              dataBytes.baseAddress,dataLength,
                                              encryptedBytes.baseAddress,encryptedDataLength,
                                              &numBytesEncrypted)
                    
                    guard cryptStatus == kCCSuccess else {
                        throw NSError(domain:"com.lbankdataextension_aes256Encrypt",code:Int(cryptStatus))
                    }
                    
                }
            }
        }
        encryptedData.count = numBytesEncrypted
        return encryptedData
    }
    
    
    func aes256ECBDecrypt(_ key:Data) throws -> Data {
        let dataLength = count
        let keyLength = key.count
        let decryptedDataLength = dataLength + kCCBlockSizeAES128
        
        var decryptedData = Data(count:decryptedDataLength)
        
        var numBytesDecrypted:size_t = 0
        try decryptedData.withUnsafeMutableBytes { decryptedBytes in
            try self.withUnsafeBytes { dataBytes in
                try key.withUnsafeBytes { keyBytes in
                    
                    let cryptStatus = CCCrypt(CCOperation(kCCDecrypt),
                                              CCAlgorithm(kCCAlgorithmAES),
                                              CCOptions(kCCOptionPKCS7Padding|kCCOptionECBMode),
                                              keyBytes.baseAddress,keyLength,
                                              nil,
                                              dataBytes.baseAddress,dataLength,
                                              decryptedBytes.baseAddress,decryptedDataLength,
                                              &numBytesDecrypted)
                    
                    guard cryptStatus == kCCSuccess else {
                        throw NSError(domain:"com.lbankdataextension_aes256Decrypt",code:Int(cryptStatus))
                    }
                    
                }
            }
        }
        
        decryptedData.count = numBytesDecrypted
        return decryptedData
    }
    
    
    
    static func generateRandomAESKey() -> Data?{
        var keyData = Data(count:32)
        let result = keyData.withUnsafeMutableBytes { keyBytes in
            SecRandomCopyBytes(kSecRandomDefault,32,keyBytes.baseAddress!)
        }
        guard result == errSecSuccess else {
            return nil
        }
        return keyData
    }
    
    static func generateIV() -> Data? {
        var iv = Data(count: kCCBlockSizeAES128)
        let result = iv.withUnsafeMutableBytes { ivBytes in
            SecRandomCopyBytes(kSecRandomDefault, kCCBlockSizeAES128, ivBytes.baseAddress!)
        }
        if result == errSecSuccess {
            return iv
        } else {
            print("Unable to generate random bytes")
            return nil
        }
    }
    
    
    static func testAES256() {
        
        guard let randomAESKey = generateRandomAESKey() else {
            print("Failed to generate random AES key")
            return
        }
        
        print("Random AES Key:\(randomAESKey.base64EncodedString())")
        
        guard let ivData = generateIV() else {
            print("Failed to generate AES256 IV")
            return
        }
        
        print("AES256 IV:\(ivData.base64EncodedString())")
        
        let string = "Hello你好"
        let helloData =  string.data(using: .utf8)!
        
        do {
            let encryptedData = try helloData.aes256ECBEncrypt(randomAESKey)
            print("ECB Encrypted data:\(encryptedData)")
            
            let decryptedData = try encryptedData.aes256ECBDecrypt(randomAESKey)
            let decryptedString = String(data:decryptedData,encoding:.utf8)
            print("ECB Decrypted string:\(decryptedString ?? "Decryption failed")")
        } catch {
            print("Error:\(error)")
        }
        
        do {
            
            let originalData = "CBC加解密：123“？》 Data to encrypt".data(using: .utf8)!
            
            let encryptedData = try  originalData.aes256CBCEncrypt(randomAESKey, iv: ivData)
            print("CBC Encrypted Data: \(encryptedData.base64EncodedString())")
            
            let decryptedData = try encryptedData.aes256CBCDecrypt(randomAESKey, iv: ivData, encryptedData: encryptedData)
            let decryptedString = String(data:decryptedData,encoding:.utf8)
            print("CBC Decrypted string:\(decryptedString ?? "Decryption failed")")
            
        } catch {
            print("Encryption error: \(error)")
        }
    }
}

@objc public extension NSData {
    
    func aes256CBCEncrypt(_ key: NSData, iv: NSData) -> NSData? {
        
        do {
            let result = try  (self as Data).aes256CBCEncrypt(key as Data, iv: iv as Data)
            
            return (result as NSData)
        
        } catch {
            print("aes256CBCEncrypt error:\(error)")
        }
        
        return  nil
    }
    
    func aes256CBCDecrypt(_ key: NSData, iv: NSData, encryptedData: NSData) -> NSData? {
        do {
            let result = try  (self as Data).aes256CBCDecrypt(key as Data, iv: iv as Data, encryptedData: encryptedData as Data)
            return (result as NSData)
        
        } catch {
            print("aes256CBCDecrypt error:\(error)")
        }
        
        return  nil
    }
    
    func aes256ECBEncrypt(_ key:NSData)  -> NSData? {
        do {
            return try  (self as Data).aes256ECBEncrypt(key as Data) as NSData
        
        } catch {
            print("aes256CBCDecrypt error:\(error)")
        }
        
        return  nil
    }
    
    func aes256ECBDecrypt(_ key: NSData) -> NSData? {
        
        return try? (self as Data).aes256ECBDecrypt(key as Data) as NSData
    }
    
    static func generateRandomAESKey() -> NSData?{
        
        return Data.generateIV() as? NSData
    }
    
    static func generateIV() -> NSData? {
        return Data.generateIV() as? NSData
    }
}
