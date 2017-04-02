//
//  EncryptionUtils.swift
//  Guidance
//
//  Created by Noel on 3/24/17.
//
//

import Foundation

class EncryptionUtils {
    
    /*
    class func md5Digest(text: String) -> String {
        
        var digest = NSMutableData(length: Int(CC_MD5)
        let data: NSData = text.dataUsingEncoding(NSUTF8StringEncoding)
        
        
    }
    */
    
    class func dummy(_ text: String) -> String {
        var result = ""
        for chr in text.utf8 {
            let value = Int(chr) - 30 // dummy transformation
            let transformed = Character(UnicodeScalar(value)!)
            result = result + String(transformed)
        }
        return result
    }
    
}
