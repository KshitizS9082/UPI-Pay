//
//  RequestMoneyViewController.swift
//  UPI Pay
//
//  Created by Kshitiz Sharma on 05/05/21.
//

import UIKit
import OSLog
protocol RequestMoneyProtocol {
    func dismissMe()
}
class RequestMoneyViewController: UIViewController {
    var person: PersonInfo?
    var value = 0
    var message = ""
    var hideAlert = false
    let logger = Logger(subsystem: "blindPolaroid.Page.UPI-Pay.RequestMoneyVC", category: "BTP")
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var paymentValueLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var warningLabel: UILabel!
    
    
    @IBOutlet weak var bgView: UIView!{
        didSet{
            bgView.layer.cornerRadius = 7
        }
    }
    @IBOutlet weak var payButton: UIButton!{
        didSet{
            payButton.layer.cornerRadius=5
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //To not allow swipe to dismiss
        self.isModalInPresentation=true
        
        nameLabel.text = person?.name
        numberLabel.text = String(person?.number ?? 404)
        
        paymentValueLabel.text = "₹"+String(value)
        
        messageLabel.text = message
        
        warningLabel.isHidden = self.hideAlert
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        logger.notice("RequestMoneyVC will appear logging instance in UPI-Pay")
    }
    @IBAction func payPressed(_ sender: Any) {
        logger.notice("RequestMoneyVC Pay Pressed in UPI-Pay")
        performSegue(withIdentifier: "requestMoneyUPIStage", sender: self)
    }
    @IBAction func xPressed(_ sender: Any) {
        logger.notice("RequestMoneyVC X(Cancel) Pressed in UPI-Pay")
//        print("dismissed RequestMoneyViewController with cross")
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func declinePressed(_ sender: Any) {
        logger.notice("RequestMoneyVC Decline Pressed in UPI-Pay")
//        print("dismissed RequestMoneyViewController with decline press")
        self.dismiss(animated: true, completion: nil)
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        requestPasscode
        if segue.identifier == "requestMoneyUPIStage"{
            if let vc = segue.destination as? PayingValueViewController{
//                vc.amountTextField.text = String(self.value)
//                vc.amountTextField.isUserInteractionEnabled=false
                vc.delegate=self
                vc.paymentValue = self.value
                vc.person=self.person!
            }
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
extension RequestMoneyViewController: RequestMoneyProtocol{
    func dismissMe() {
        self.dismiss(animated: false, completion: nil)
    }
}
