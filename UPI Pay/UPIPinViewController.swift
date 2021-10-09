//
//  UPIPinViewController.swift
//  UPI Pay
//
//  Created by Kshitiz Sharma on 24/01/21.
//

import UIKit
//import OSLog

class UPIPinViewController: UIViewController {
    enum notificationStyleEnum {
        case vdl_notification
        case alertAfterPswd
        case actionSheetAfterPswd
        case nothing
    }
//    let logger = Logger(subsystem: "blindPolaroid.Page.UPI-Pay.PersonVC", category: "BTP")
    var notificationStyle = notificationStyleEnum.vdl_notification
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
//        logger.notice("UPIPinVC cancelPressed in UPI-Pay")
        self.dismiss(animated: true) {
            self.delegate?.dismissMyself()
        }
    }
    
    @objc func donePressed() {
//        logger.notice("UPIPinVC donePressed in UPI-Pay")
        if pinTextField.text=="0000"{
//            logger.notice("UPIPinVC correct password in UPI-Pay")
            if notificationStyle == .alertAfterPswd{
                let text = "payment worth " + "Rs. " + String(paymentValue) + " is sent to " + person.name + " from " + bankName
                let alert = UIAlertController(title: "Alert", message: text, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                                                switch action.style{
                                                case .default:
                                                    print("Payment Succesfull")
                                                    if self.bankName == "ABC National Bank"{
                                                        firstBalance -= self.paymentValue
                                                    }else{
                                                        secondBalance -= self.paymentValue
                                                    }
                                                    
//                                                    self.logger.notice("UPIPinVC alert ok pressed in UPI-Pay")
                                                    self.dismiss(animated: true, completion: nil)
                                                    self.delegate?.dismissMyself()
                                                case .cancel:
                                                    print("cancel 1")
                                                case .destructive:
                                                    print("destructive 1")
                                                @unknown default:
                                                    print("idk lol 2.0")
                                                }}))
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
                                                switch action.style{
                                                case .default:
                                                    print("default 2")
                                                case .cancel:
                                                    print("Payment Canceled")
//                                                    self.logger.notice("UPIPinVC alert payment cancel pressed in UPI-Pay")
                                                    self.dismiss(animated: true, completion: nil)
                                                    self.delegate?.dismissMyself()
                                                case .destructive:
                                                    print("destructive 2")
                                                @unknown default:
                                                    print("idk lol 2.0")
                                                }}))
                self.present(alert, animated: true, completion: nil)
            }
            else{
                let alert = UIAlertController(title: "Paymnet Succesfull", message: "Payment worth \(paymentValue) sent to \(person.name)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                                                switch action.style{
                                                case .default:
                                                    print("default")
//                                                    self.logger.notice("UPIPinVC alert ok pressed in UPI-Pay")
                                                    if self.bankName == "ABC National Bank"{
                                                        firstBalance -= self.paymentValue
                                                    }else{
                                                        secondBalance -= self.paymentValue
                                                    }
                                                    self.dismiss(animated: true) {
                                                        print("Succesfull Payment")
                                                        self.dismiss(animated: true, completion: nil)
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
            }
        }else{
//            logger.notice("UPIPinVC incorrect password showing alert in UPI-Pay")
            let alert = UIAlertController(title: "Alert", message: "Invalid Password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                                            switch action.style{
                                            case .default:
//                                                self.logger.notice("UPIPinVC alert ok pressed in UPI-Pay")
                                                if self.bankName == "ABC National Bank"{
                                                    firstBalance -= self.paymentValue
                                                }else{
                                                    secondBalance -= self.paymentValue
                                                }
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
        if infoView.isHidden{
//            self.logger.notice("UPIPinVC expand PaymentInfoImageView pressed in UPI-Pay")
        }else{
//            self.logger.notice("UPIPinVC hide PaymentInfoImageView pressed in UPI-Pay")
        }
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
        // Do any additional setup after loading the view.]
        if notificationStyle == .vdl_notification{
            setupNotification()
        }else if notificationStyle == .actionSheetAfterPswd{
            self.pinTextField.resignFirstResponder()
            let text = "payment worth " + "Rs. " + String(paymentValue) + " is being sent to " + person.name + " from " + bankName
            let confirmAction = UIAlertAction(title: "Confirm", style: .default){
                UIAlertAction in
                print("Payment Succesfull")
//                if self.bankName == "ABC National Bank"{
//                    firstBalance -= self.paymentValue
//                }else{
//                    secondBalance -= self.paymentValue
//                }
//                self.logger.notice("UPIPinVC actionsheet ok pressed in UPI-Pay")
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .destructive){
                UIAlertAction in
                print("Payment Canceled")
//                self.logger.notice("UPIPinVC actionsheet cancel pressed in UPI-Pay")
                self.dismiss(animated: true, completion: nil)
                self.delegate?.dismissMyself()
            }
            
            let boldAttribute = [
                NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 18.0)!
            ]
            let regularAttribute = [
                NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Light", size: 18.0)!
            ]
            let newString = NSMutableAttributedString()
            newString.append(NSAttributedString(string:  "payment worth Rs. "+String(paymentValue) , attributes: regularAttribute))
            newString.append(NSAttributedString(string: " is being sent to ", attributes: boldAttribute))
            newString.append(NSAttributedString(string:  person.name + " from " + bankName, attributes: regularAttribute))
            
            let alert = UIAlertController(title: "Confirm payment?", message: text, preferredStyle: .actionSheet)
            alert.setValue(newString, forKey: "attributedMessage")
            alert.addAction(confirmAction)
            alert.addAction(cancelAction)
            print("Presenting actionsheet in upi pin vc")
            DispatchQueue.main.async{
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
//        logger.notice("UPIPinVC will appear logging instance in UPI-Pay")
    }
    //TODO: not working setupNotification()
    func setupNotification(){
//        self.logger.notice("UPIPinVC notification being set in UPI-Pay")
        let text = "payment worth " + "Rs. " + String(paymentValue) + " is being sent to " + person.name + " from " + bankName
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = "UPI Paymnet Confirmation"
        content.body = text
        content.sound = .default
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second],from: Date().addingTimeInterval(5)), repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
        print("added notification")
    }
    @IBAction func pinEdittingDidEnd(_ sender: UITextField) {
        
    }
    
}
