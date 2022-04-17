//
//  ViewBalancePinViewController.swift
//  UPI Pay
//
//  Created by Kshitiz Sharma on 05/05/21.
//

import UIKit
//import OSLog

@available(iOS 14.0, *)
class ViewBalancePinViewController: UIViewController {

//    let logger = Logger(subsystem: "blindPolaroid.Page.UPI-Pay.viewBalancePinVC", category: "BTP")
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
//            logger.notice("viewBalancePinVC done pressed with correct ping in UPI-Pay")
            
            let format = DateFormatter()
            format.dateFormat = "yyyy-MM-dd HH:mm:ss"
            var str = format.string(from: Date()) + ": " + "viewBalancePinVC done pressed with correct ping in UPI-Pay\n"
            let filename = getDocumentsDirectory().appendingPathComponent("outputLog.txt")
            do {
                let oldString = try String(contentsOf: filename, encoding: String.Encoding.utf8)
                str = oldString + str
                try str.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
            } catch {
                print("ERROR in adding log string: \(str)")
            }
            
            let alert = UIAlertController(title: "Account Balance", message: "Your account balance in \(bankName) is ₹ \("-")", preferredStyle: .alert)
            if self.bankName == "ABC National Bank"{
                alert.message =  "Succesfully got bank balance for \(self.bankName) to be ₹\(firstBalance)"
            }else{
                alert.message = "Succesfully got bank balance for \(self.bankName) to be ₹\(secondBalance)"
            }
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                                            switch action.style{
                                            case .default:
                                                print("default")
//                                                self.logger.notice("viewBalancePinVC Alert OK pressed in UPI-Pay")
                                                
                                                let format = DateFormatter()
                                                format.dateFormat = "yyyy-MM-dd HH:mm:ss"
                                                var str = format.string(from: Date()) + ": " + "viewBalancePinVC Alert OK pressed in UPI-Pay\n"
                                                let filename = self.getDocumentsDirectory().appendingPathComponent("outputLog.txt")
                                                do {
                                                    let oldString = try String(contentsOf: filename, encoding: String.Encoding.utf8)
                                                    str = oldString + str
                                                    try str.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
                                                } catch {
                                                    print("ERROR in adding log string: \(str)")
                                                }
                                                
                                                self.dismiss(animated: true) {
                                                    if self.bankName == "ABC National Bank"{
                                                        print("Succesfully got bank balance for \(self.bankName) to be ₹\(firstBalance)")
                                                    }else{
                                                        print("Succesfully got bank balance for \(self.bankName) to be ₹\(secondBalance)")
                                                    }
                                                    
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
//            logger.notice("viewBalancePinVC done pressed with incorrect pin in UPI-Pay")
            
            let format = DateFormatter()
            format.dateFormat = "yyyy-MM-dd HH:mm:ss"
            var str = format.string(from: Date()) + ": " + "viewBalancePinVC done pressed with incorrect pin in UPI-Pay\n"
            let filename = self.getDocumentsDirectory().appendingPathComponent("outputLog.txt")
            do {
                let oldString = try String(contentsOf: filename, encoding: String.Encoding.utf8)
                str = oldString + str
                try str.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
            } catch {
                print("ERROR in adding log string: \(str)")
            }
            
            let alert = UIAlertController(title: "Alert", message: "Invalid Password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                                            switch action.style{
                                            case .default:
                                                print("default")
//                                                self.logger.notice("viewBalancePinVC Alert OK pressed in UPI-Pay")
                                                
                                                let format = DateFormatter()
                                                format.dateFormat = "yyyy-MM-dd HH:mm:ss"
                                                var str = format.string(from: Date()) + ": " + "viewBalancePinVC Alert OK pressed in UPI-Pay\n"
                                                let filename = self.getDocumentsDirectory().appendingPathComponent("outputLog.txt")
                                                do {
                                                    let oldString = try String(contentsOf: filename, encoding: String.Encoding.utf8)
                                                    str = oldString + str
                                                    try str.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
                                                } catch {
                                                    print("ERROR in adding log string: \(str)")
                                                }
                                                
                                            case .cancel:
                                                print("cancel")
//                                                self.logger.notice("viewBalancePinVC Alert cancel pressed in UPI-Pay")
                                                
                                                let format = DateFormatter()
                                                format.dateFormat = "yyyy-MM-dd HH:mm:ss"
                                                var str = format.string(from: Date()) + ": " + "viewBalancePinVC Alert cancel pressed in UPI-Pay\n"
                                                let filename = self.getDocumentsDirectory().appendingPathComponent("outputLog.txt")
                                                do {
                                                    let oldString = try String(contentsOf: filename, encoding: String.Encoding.utf8)
                                                    str = oldString + str
                                                    try str.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
                                                } catch {
                                                    print("ERROR in adding log string: \(str)")
                                                }
                                                
                                            case .destructive:
                                                print("destructive")
//                                                self.logger.notice("viewBalancePinVC Alert destructive pressed in UPI-Pay")
                                                
                                                let format = DateFormatter()
                                                format.dateFormat = "yyyy-MM-dd HH:mm:ss"
                                                var str = format.string(from: Date()) + ": " + "viewBalancePinVC Alert destructive pressed in UPI-Pay\n"
                                                let filename = self.getDocumentsDirectory().appendingPathComponent("outputLog.txt")
                                                do {
                                                    let oldString = try String(contentsOf: filename, encoding: String.Encoding.utf8)
                                                    str = oldString + str
                                                    try str.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
                                                } catch {
                                                    print("ERROR in adding log string: \(str)")
                                                }
                                                
                                            @unknown default:
                                                print("idk lol")
                                            }}))
            self.present(alert, animated: true, completion: nil)
        }
    }
    @objc func expandPressed(){
        infoView.isHidden = !infoView.isHidden
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        bankNameLabel.text = bankName
//        payeeNameLabel.text = person.name
        refidLabel.text = "SJLnl230xS902aShNS8"
        infoRefidLabel.text = "SJLnl230xS902aShNS8"
        infoAcntLabel.text = bankName + " XXXXXXXX1031"
        
    }
    override func viewWillAppear(_ animated: Bool) {
//        logger.notice("viewBalancePinVC will appear logging instance in UPI-Pay")
        
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        var str = format.string(from: Date()) + ": " + "viewBalancePinVC will appear logging instance in UPI-Pay\n"
        let filename = self.getDocumentsDirectory().appendingPathComponent("outputLog.txt")
        do {
            let oldString = try String(contentsOf: filename, encoding: String.Encoding.utf8)
            str = oldString + str
            try str.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            print("ERROR in adding log string: \(str)")
        }

        
    }
    
    @IBAction func pinEdittingDidEnd(_ sender: UITextField) {
//        self.logger.notice("viewBalancePinVC pinEdittingDidEnd in UPI-Pay")
        
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        var str = format.string(from: Date()) + ": " + "viewBalancePinVC pinEdittingDidEnd in UPI-Pay\n"
        let filename = self.getDocumentsDirectory().appendingPathComponent("outputLog.txt")
        do {
            let oldString = try String(contentsOf: filename, encoding: String.Encoding.utf8)
            str = oldString + str
            try str.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            print("ERROR in adding log string: \(str)")
        }
    }
    
    @IBAction func pinEdittingDidBegin(_ sender: Any) {
//        self.logger.notice("viewBalancePinVC pinEdittingDidBegin in UPI-Pay")
        
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        var str = format.string(from: Date()) + ": " + "viewBalancePinVC pinEdittingDidBegin in UPI-Pay\n"
        let filename = self.getDocumentsDirectory().appendingPathComponent("outputLog.txt")
        do {
            let oldString = try String(contentsOf: filename, encoding: String.Encoding.utf8)
            str = oldString + str
            try str.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            print("ERROR in adding log string: \(str)")
        }
    }
    
}
