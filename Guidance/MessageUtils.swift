//
//  MessageUtils.swift
//  Guidance
//
//  Created by Noel on 4/18/17.
//
//

import Foundation
import MessageUI

class MessageUtils {
    
    class func sendMessage(controller: UIViewController, recipient: String, text: String) -> Bool {
        if !MFMessageComposeViewController.canSendText() {
            return false
        }
        
        let smsController = MFMessageComposeViewController()
        smsController.recipients = [recipient]
        smsController.body = text
        controller.present(smsController, animated: true, completion: nil)
        return true
    }
    
}
