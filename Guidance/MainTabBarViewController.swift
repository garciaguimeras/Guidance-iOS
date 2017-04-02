//
//  MainTabBarViewController.swift
//  Guidance
//
//  Created by Noel on 3/25/17.
//
//

import UIKit

class MainTabBarViewController: UITabBarController {

    var guidanceTable = GuidanceTable()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if !guidanceTable.isActivated() {
            //dismissViewControllerAnimated(true, completion: nil)
            NavigationUtils.navigateTo("ActivationKey", fromView: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
