//
//  ViewBalancePinViewController.swift
//  UPI Pay
//
//  Created by Kshitiz Sharma on 05/05/21.
//

import UIKit

class ViewBalancePinViewController: UIViewController {

//    var person = PersonInfo()
    var bankName = "STATE BANK OF INDIA"
//    var paymentValue = 0
//    var delegate: payingValueProtocol?
    @IBOutlet weak var bankNameLabel: UILabel!
    @IBOutlet weak var refidLabel: UILabel!
//    @IBOutlet weak var paymentValueLabel: UILabel!
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
    
//    @IBOutlet weak var infoPayeeLabel: UILabel!
//    @IBOutlet weak var infoTxnLabel: UILabel!
    @IBOutlet weak var infoRefidLabel: UILabel!
    @IBOutlet weak var infoAcntLabel: UILabel!
    
    @IBOutlet weak var infoView: UIView!
    
    @IBAction func cancelPressed(_ sender: Any) {
//        self.dismiss(animated: true) {
//            self.delegate?.dismissMyself()
//        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func donePressed() {
        if pinTextField.text=="0000"{
            
            let alert = UIAlertController(title: "Account Balance", message: "Your account balance in \(bankName) is \("₹ 1111")", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                                            switch action.style{
                                            case .default:
                                                print("default")
                                                self.dismiss(animated: true) {
                                                    print("Succesfully got bank balance for \(self.bankName) to be \("₹ 1111")")
                                                    self.dismiss(animated: true, completion: nil)
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
//        payeeNameLabel.text = person.name
        refidLabel.text = "SJLnl230xS902aShNS8"
        infoRefidLabel.text = "SJLnl230xS902aShNS8"
        infoAcntLabel.text = bankName + " XXXXXXXX1031"
        
    }
    
    @IBAction func pinEdittingDidEnd(_ sender: UITextField) {
        
    }
    
}
