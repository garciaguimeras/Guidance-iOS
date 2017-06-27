//
//  TripDetailViewController.swift
//  Guidance
//
//  Created by Noel on 4/2/17.
//
//

import UIKit

class TripDetailViewController: UITableViewController {
    
    @IBOutlet weak var clientLabel: UILabel?
    @IBOutlet weak var tourLabel: UILabel?
    @IBOutlet weak var dateLabel: UILabel?
    @IBOutlet weak var guideLabel: UILabel?
    @IBOutlet weak var driverLabel: UILabel?
    @IBOutlet weak var priceLabel: UILabel?
    @IBOutlet weak var guideCommissionLabel: UILabel?
    @IBOutlet weak var driverCommissionLabel: UILabel?
    @IBOutlet weak var totalLabel: UILabel?
    @IBOutlet weak var payGuideButton: UIButton?
    @IBOutlet weak var payDriverButton: UIButton?

    var clientTour: ClientTour?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        if clientTour != nil {
        
            let client = ClientTable().getClientById(clientTour!.clientId)
            let tour = TourTable().getTourById(clientTour!.tourId)
            let guide = GuideTable().getGuideById(clientTour!.guideId)
            let driver = DriverTable().getDriverById(clientTour!.driverId)
            
            let df = DateFormatter()
            df.dateFormat = "dd/MM/yyyy"
            
            let total = clientTour!.price - clientTour!.guideCommission - clientTour!.driverCommission
        
            clientLabel!.text = client?.name
            tourLabel!.text = tour != nil ? tour!.name : "Sin actividad definida"
            dateLabel!.text = df.string(from: clientTour!.date!)
            guideLabel!.text = guide != nil ? guide!.name : "Sin guia"
            driverLabel!.text = driver != nil ? driver!.name : "Sin chofer"
            priceLabel!.text = String(format: "%.2f", clientTour!.price)
            guideCommissionLabel!.text = String(format: "%.2f", clientTour!.guideCommission)
            driverCommissionLabel!.text = String(format: "%.2f", clientTour!.driverCommission)
            totalLabel!.text = String(format: "%.2f", total)
            payGuideButton!.isEnabled = !clientTour!.payGuide
            payDriverButton!.isEnabled = !clientTour!.payDriver
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Methods
    
    @IBAction func payGuideCommission(sender: AnyObject) {
        let alert = UIAlertController(title: "Comisiones", message: "Efectuado el pago de comision al guia?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            self.clientTour!.payGuide = true
            ClientTourTable().updateClientTour(self.clientTour!)
            self.payGuideButton!.isEnabled = false
        }))
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func payDriverCommission(sender: AnyObject) {
        let alert = UIAlertController(title: "Comisiones", message: "Efectuado el pago de comision al chofer?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            self.clientTour!.payDriver = true
            ClientTourTable().updateClientTour(self.clientTour!)
            self.payDriverButton!.isEnabled = false
        }))
        present(alert, animated: true, completion: nil)
    }

}
