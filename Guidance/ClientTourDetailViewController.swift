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
    var date: Date?
    var tour: Tour?
    var guide: Guide?
    var driver: Driver?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        date = Date()
        tour = nil
        guide = nil
        driver = nil
        
        if ct != nil {
            priceTextField.text = String(ct!.price)
            fromOutsiderCompanySwitch.isOn = ct!.fromOutsiderCompany
            commentsTextField.text = ct!.comments
            guideCommissionTextField.text = String(ct!.guideCommission)
            notifyGuideSwitch.isOn = ct!.notifyGuide
            driverCommissionTextField.text = String(ct!.driverCommission)
            notifyDriverSwitch.isOn = ct!.notifyDriver
            
            date = ct!.date as Date?
            tour = ct!.tourId != 0 ? TourTable().getTourById(ct!.tourId) : nil
            guide = ct!.guideId != 0 ? GuideTable().getGuideById(ct!.guideId) : nil
            driver = ct!.driverId != 0 ? DriverTable().getDriverById(ct!.driverId) : nil
        }
        
        let df = DateFormatter()
        df.dateFormat = "dd/MM/yyyy"
        dateLabel.text = df.string(from: date!)
        
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
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
            ct!.fromOutsiderCompany = fromOutsiderCompanySwitch.isOn
            ct!.comments = commentsTextField.text!
            ct!.guideCommission = Double(guideCommissionTextField.text!)!
            ct!.notifyGuide = notifyGuideSwitch.isOn
            ct!.driverCommission = Double(driverCommissionTextField.text!)!
            ct!.notifyDriver = notifyDriverSwitch.isOn
        }
        
        if segue.identifier == "setTripDate" {
            let navViewController = segue.destination as? UINavigationController
            let viewController = navViewController!.viewControllers[0] as? ClientTourDateViewController
            viewController!.date = date!
        }
        
        if segue.identifier == "setTripTour" {
            let navViewController = segue.destination as? UINavigationController
            let viewController = navViewController!.viewControllers[0] as? ClientTourTourViewController
            viewController!.selectedTour = tour
        }
        
        if segue.identifier == "setTripGuide" {
            let navViewController = segue.destination as? UINavigationController
            let viewController = navViewController!.viewControllers[0] as? ClientTourGuideViewController
            viewController!.selectedGuide = guide
        }
        
        if segue.identifier == "setTripDriver" {
            let navViewController = segue.destination as? UINavigationController
            let viewController = navViewController!.viewControllers[0] as? ClientTourDriverViewController
            viewController!.selectedDriver = driver
        }
    }
    
    // MARK: - Methods
    
    @IBAction func updateClientTourDate(_ segue: UIStoryboardSegue) {
        let viewController = segue.source as? ClientTourDateViewController
        date = viewController!.date as Date?
        let df = DateFormatter()
        df.dateFormat = "dd/MM/yyyy"
        dateLabel!.text = df.string(from: date!)
    }
    
    @IBAction func updateClientTour(_ segue: UIStoryboardSegue) {
        let viewController = segue.source as? ClientTourTourViewController
        tour = viewController?.selectedTour
        tourLabel!.text = tour != nil ? tour!.name : "No"
    }
    
    @IBAction func updateClientTourGuide(_ segue: UIStoryboardSegue) {
        let viewController = segue.source as? ClientTourGuideViewController
        guide = viewController?.selectedGuide
        guideLabel!.text = guide != nil ? guide!.name : "No"
    }
    
    @IBAction func updateClientTourDriver(_ segue: UIStoryboardSegue) {
        let viewController = segue.source as? ClientTourDriverViewController
        driver = viewController?.selectedDriver
        driverLabel!.text = driver != nil ? driver!.name : "No"
    }

}
