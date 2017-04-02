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
    
    class func navigateTo(_ identifier: String, fromView: UIViewController) {
        let nextViewController = fromView.storyboard?.instantiateViewController(withIdentifier: identifier)
        nextViewController!.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        nextViewController!.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        fromView.present(nextViewController!, animated:true, completion:nil)
    }
    
}
