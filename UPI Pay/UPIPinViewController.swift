//
//  UPIPinViewController.swift
//  UPI Pay
//
//  Created by Kshitiz Sharma on 24/01/21.
//

import UIKit

class UPIPinViewController: UIViewController {
    var person = PersonInfo()
    var bankName = "STATE BANK OF INDIA"
    var paymentValue = 0
    var delegate: payingValueProtocol?
    @IBOutlet weak var bankNameLabel: UILabel!
    @IBOutlet weak var payeeNameLabel: UILabel!
    @IBOutlet weak var paymentValueLabel: UILabel!
    @IBOutlet weak var pinTextField: UITextField!
    @IBOutlet weak var expandPaymentInfoImageView: UIImageView!{
        didSet{
            expandPaymentInfoImageView.isUserInteractionEnabled=true
            expandPaymentInfoImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(expandPressed)))
        }
    }
    @IBOutlet weak var doneButton: UIImageView!{
        didSet{
            doneButton.isUserInteractionEnabled=true
            doneButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(donePressed)))
        }
    }
    
    @IBOutlet weak var infoPayeeLabel: UILabel!
    @IBOutlet weak var infoTxnLabel: UILabel!
    @IBOutlet weak var infoRefidLabel: UILabel!
    @IBOutlet weak var infoAcntLabel: UILabel!
    
    @IBOutlet weak var infoView: UIView!
    
    @IBAction func cancelPressed(_ sender: Any) {
        self.dismiss(animated: true) {
            self.delegate?.dismissMyself()
        }
    }
    
    @objc func donePressed() {
        if pinTextField.text=="0000"{
            let alert = UIAlertController(title: "Paymnet Succesfull", message: "Payment worth \(paymentValue) done to \(person.name)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                  switch action.style{
                  case .default:
                        print("default")
                    self.dismiss(animated: true) {
                        self.delegate?.dismissMyself()
                    }
                  case .cancel:
                        print("cancel")
                  case .destructive:
                        print("destructive")
                  @unknown default:
                    print("idk lol")
                  }}))
            self.present(alert, animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title: "Alert", message: "Invalid Password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                  switch action.style{
                  case .default:
                        print("default")
                  case .cancel:
                        print("cancel")
                  case .destructive:
                        print("destructive")
                  @unknown default:
                    print("idk lol")
                  }}))
            self.present(alert, animated: true, completion: nil)
        }
    }
    @objc func expandPressed(){
        infoView.isHidden = !infoView.isHidden
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        bankNameLabel.text = bankName
        payeeNameLabel.text = person.name
        paymentValueLabel.text = "Rs. " + String(paymentValue)
        
        infoPayeeLabel.text = person.name
        infoTxnLabel.text = "Rs. " + String(paymentValue)
        infoRefidLabel.text = "SJLnl230xS902aShNS8"
        infoAcntLabel.text = bankName + " XXXXXXXX1031"
        // Do any additional setup after loading the view.
    }
    @IBAction func pinEdittingDidEnd(_ sender: UITextField) {
        
    }
    


}
