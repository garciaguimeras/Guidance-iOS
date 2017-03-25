//
//  NavigationUtils.swift
//  Guidance
//
//  Created by Noel on 3/25/17.
//
//

import Foundation
import UIKit

class NavigationUtils {
    
    class func navigateTo(identifier: String, fromView: UIViewController) {
        let nextViewController = fromView.storyboard?.instantiateViewControllerWithIdentifier(identifier)
        nextViewController!.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
        nextViewController!.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        fromView.presentViewController(nextViewController!, animated:true, completion:nil)
    }
    
}