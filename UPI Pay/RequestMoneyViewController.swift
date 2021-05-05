//
//  RequestMoneyViewController.swift
//  UPI Pay
//
//  Created by Kshitiz Sharma on 05/05/21.
//

import UIKit
protocol RequestMoneyProtocol {
    func dismissMe()
}
class RequestMoneyViewController: UIViewController {
    var person: PersonInfo?
    var value = 0
    var message = ""
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var paymentValueLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
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
        nameLabel.text = person?.name
        numberLabel.text = String(person?.number ?? 404)
        
        paymentValueLabel.text = "₹"+String(value)
        
        messageLabel.text = message
        // Do any additional setup after loading the view.
    }
    
    @IBAction func payPressed(_ sender: Any) {
        performSegue(withIdentifier: "requestMoneyUPIStage", sender: self)
    }
    @IBAction func xPressed(_ sender: Any) {
        print("dismissed RequestMoneyViewController with cross")
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func declinePressed(_ sender: Any) {
        print("dismissed RequestMoneyViewController with decline press")
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
