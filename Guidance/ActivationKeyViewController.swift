//
//  ActivationKeyViewController.swift
//  Guidance
//
//  Created by Noel on 3/25/17.
//
//

import UIKit

class ActivationKeyViewController: UIViewController {
    
    @IBOutlet weak var activationKeyTextField: UITextField?
    
    var guidanceTable = GuidanceTable()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    
    // MARK: - Methods
    
    func showInvalidKeyAlert() {
        let alert = UIAlertView()
        alert.message = "La clave de activacion no es valida"
        alert.addButtonWithTitle("Ok")
        alert.show()
    }
    
    func startGuidance() {
        NavigationUtils.navigateTo("MainTabBar", fromView: self)
    }
    
    @IBAction func onContinueButtonClick(sender: AnyObject) {
        let key = activationKeyTextField!.text!
        let result = guidanceTable.addActivationKey(key)
        if !result {
            showInvalidKeyAlert()
        }
        else {
            startGuidance()
        }
    }

}
