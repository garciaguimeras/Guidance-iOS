//
//  ClientTourDetailViewController.swift
//  Guidance
//
//  Created by Noel on 3/15/17.
//
//

import UIKit

class ClientTourDetailViewController: UITableViewController {
    
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var fromOutsiderCompanySwitch: UISwitch!
    @IBOutlet weak var commentsTextField: UITextField!
    @IBOutlet weak var guideCommissionTextField: UITextField!
    @IBOutlet weak var notifyGuideSwitch: UISwitch!
    @IBOutlet weak var driverCommissionTextField: UITextField!
    @IBOutlet weak var notifyDriverSwitch: UISwitch!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tourLabel: UILabel!
    @IBOutlet weak var guideLabel: UILabel!
    @IBOutlet weak var driverLabel: UILabel!
    
    var ct: ClientTour?
    var date: NSDate?
    var tour: Tour?
    var guide: Guide?
    var driver: Driver?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        date = NSDate()
        tour = nil
        guide = nil
        driver = nil
        
        if ct != nil {
            priceTextField.text = String(ct!.price)
            fromOutsiderCompanySwitch.on = ct!.fromOutsiderCompany
            commentsTextField.text = ct!.comments
            guideCommissionTextField.text = String(ct!.guideCommission)
            notifyGuideSwitch.on = ct!.notifyGuide
            driverCommissionTextField.text = String(ct!.driverCommission)
            notifyDriverSwitch.on = ct!.notifyDriver
            
            date = ct!.date
            tour = ct!.tourId != 0 ? TourTable().getTourById(ct!.tourId) : nil
            guide = ct!.guideId != 0 ? GuideTable().getGuideById(ct!.guideId) : nil
            driver = ct!.driverId != 0 ? DriverTable().getDriverById(ct!.driverId) : nil
        }
        
        let df = NSDateFormatter()
        df.dateFormat = "dd/MM/yyyy"
        dateLabel.text = df.stringFromDate(date!)
        
        tourLabel.text = tour != nil ? tour!.name : "No"
        guideLabel.text = guide != nil ? guide!.name : "No"
        driverLabel.text = driver != nil ? driver!.name : "No"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "saveClientTourDetail" {
            if ct == nil {
                ct = ClientTour()
            }
            
            priceTextField.text = priceTextField.text != "" ? priceTextField.text : "0"
            guideCommissionTextField.text = guideCommissionTextField.text != "" ? guideCommissionTextField.text : "0"
            driverCommissionTextField.text = driverCommissionTextField.text != "" ?
                driverCommissionTextField.text : "0"
            
            ct!.date = date
            ct!.tourId = tour != nil ? tour!.id : 0
            ct!.guideId = guide != nil ? guide!.id : 0
            ct!.driverId = driver != nil ? driver!.id : 0
            
            ct!.price = Double(priceTextField.text!)!
            ct!.fromOutsiderCompany = fromOutsiderCompanySwitch.on
            ct!.comments = commentsTextField.text!
            ct!.guideCommission = Double(guideCommissionTextField.text!)!
            ct!.notifyGuide = notifyGuideSwitch.on
            ct!.driverCommission = Double(driverCommissionTextField.text!)!
            ct!.notifyDriver = notifyDriverSwitch.on
        }
        
        if segue.identifier == "setTripDate" {
            let navViewController = segue.destinationViewController as? UINavigationController
            let viewController = navViewController!.viewControllers[0] as? ClientTourDateViewController
            viewController!.date = date!
        }
        
        if segue.identifier == "setTripTour" {
            let navViewController = segue.destinationViewController as? UINavigationController
            let viewController = navViewController!.viewControllers[0] as? ClientTourTourViewController
            viewController!.selectedTour = tour
        }
        
        if segue.identifier == "setTripGuide" {
            let navViewController = segue.destinationViewController as? UINavigationController
            let viewController = navViewController!.viewControllers[0] as? ClientTourGuideViewController
            viewController!.selectedGuide = guide
        }
        
        if segue.identifier == "setTripDriver" {
            let navViewController = segue.destinationViewController as? UINavigationController
            let viewController = navViewController!.viewControllers[0] as? ClientTourDriverViewController
            viewController!.selectedDriver = driver
        }
    }
    
    // MARK: - Methods
    
    @IBAction func updateClientTourDate(segue: UIStoryboardSegue) {
        let viewController = segue.sourceViewController as? ClientTourDateViewController
        date = viewController!.date
        let df = NSDateFormatter()
        df.dateFormat = "dd/MM/yyyy"
        dateLabel!.text = df.stringFromDate(date!)
    }
    
    @IBAction func updateClientTour(segue: UIStoryboardSegue) {
        let viewController = segue.sourceViewController as? ClientTourTourViewController
        tour = viewController?.selectedTour
        tourLabel!.text = tour != nil ? tour!.name : "No"
    }
    
    @IBAction func updateClientTourGuide(segue: UIStoryboardSegue) {
        let viewController = segue.sourceViewController as? ClientTourGuideViewController
        guide = viewController?.selectedGuide
        guideLabel!.text = guide != nil ? guide!.name : "No"
    }
    
    @IBAction func updateClientTourDriver(segue: UIStoryboardSegue) {
        let viewController = segue.sourceViewController as? ClientTourDriverViewController
        driver = viewController?.selectedDriver
        driverLabel!.text = driver != nil ? driver!.name : "No"
    }

}
