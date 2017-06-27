//
//  UserNotificationUtils.swift
//  Guidance
//
//  Created by Noel on 4/6/17.
//
//

import Foundation
import UserNotifications

@available(iOS 10.0, *)
class UserNotificationUtils {
    
    class func register(delegate: UNUserNotificationCenterDelegate?) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {(accepted, error) in
            if !accepted {
                print("UserNotification access denied")
            }
            else {
                print("UserNotification authorized!!")
                UNUserNotificationCenter.current().delegate = delegate
            }
        })
    }
    
    class func createUserNotificationContent(title: String, message: String) -> UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = message
        content.sound = UNNotificationSound.default()
        return content
    }
    
    class func getPendingNotifications(handlerForRequest: @escaping (_ request: UNNotificationRequest) -> Void) {
        UNUserNotificationCenter.current().getPendingNotificationRequests(completionHandler: { (requests) in
            
            print("Total requests: \(requests.count)")
            for request in requests {
                handlerForRequest(request)
            }
            
        })
    }
    
    class func triggerUserNotification(withIdentifier identifier: String, content: UNMutableNotificationContent) {
        let dateComponents = DateComponents(hour: 8, minute: 0)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        //UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().add(request, withCompletionHandler: { (error) in
            if let err = error {
                print("UserNotification could not be added due to an error: \(err)")
            }
            else {
                print("UserNotification added")
            }
        })
    }
    
    class func removeUserNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
}
