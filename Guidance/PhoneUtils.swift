//
//  PhoneUtils.swift
//  Guidance
//
//  Created by Noel on 4/18/17.
//
//

import Foundation
import UIKit

class PhoneUtils {
    
    class func callPhone(_ phone: String) -> Bool {
        let url = URL(string: "tel://\(phone)")
        let application = UIApplication.shared
        if !application.canOpenURL(url!) {
            return false
        }
        
        application.openURL(url!)
        return true
    }
    
}
