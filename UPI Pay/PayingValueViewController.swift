//
//  PayingValueViewController.swift
//  UPI Pay
//
//  Created by Kshitiz Sharma on 24/01/21.
//

import UIKit
import OSLog
protocol payingValueProtocol {
    func dismissMyself()
}

class PayingValueViewController: UIViewController, payingValueProtocol {
    
    enum BankChoosingStyle{
        case default_hide
        case default_show
        case choose_before
        case choose_after
    }
    let logger = Logger(subsystem: "blindPolaroid.Page.UPI-Pay.PersonVC", category: "BTP")
    var choosingStyle = BankChoosingStyle.choose_before
    var person = PersonInfo()
    var bankName: String? = "Punjab National Bank"
    var paymentValue = 0
    var delegate: RequestMoneyProtocol?
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var doneButton: UIImageView!{
        didSet{
            doneButton.isUserInteractionEnabled=true
            doneButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(donePressed)))
        }
    }
    
    
    @IBOutlet weak var bankView: UIView!{
        didSet{
            bankView.layer.cornerRadius = 13
//            bankView.layer.masksToBounds=true
            
//            bankView.layer.shadowColor = UIColor.black.cgColor
//            bankView.layer.shadowRadius = 10
//            bankView.layer.shadowOpacity=1
//            bankView.layer.shadowColor = UIColor.black.cgColor
//            bankView.layer.shadowOpacity = 0.4
//            bankView.layer.shadowOffset = .zero
//            bankView.layer.shadowRadius = 4
        }
    }
    
    @IBOutlet weak var firstBankView: UIView!{
        didSet{
            firstBankView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(firstBankSelected)))
        }
    }
    @IBOutlet weak var firsBankTickIV: UIView!
    
    @IBOutlet weak var secondBankView: UIView!{
        didSet{
            secondBankView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(secondBankSelected)))
        }
    }
    @IBOutlet weak var secondBankTickIV: UIImageView!
    @objc func firstBankSelected(){
        firsBankTickIV.isHidden=false
        secondBankTickIV.isHidden=true
        self.bankName = "ABC National Bank"
        logger.notice("PayingValueVC first bank(\(self.bankName ?? "") selected in UPI-Pay")
    }
    @objc func secondBankSelected(){
        firsBankTickIV.isHidden=true
        secondBankTickIV.isHidden=false
        self.bankName = "DEF Bank"
        logger.notice("PayingValueVC second bank(\(self.bankName ?? "") selected in UPI-Pay")
    }
    
    @objc func donePressed(){
        logger.notice("PayingValueVC done pressed selected in UPI-Pay")
        if bankName==nil{
            logger.notice("PayingValueVC no bank selected, showing alert in UPI-Pay")
            let alert = UIAlertController(title: "Alert", message: "No Bank Account Selected", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                  switch action.style{
                  case .default:
                        print("default")
                        self.logger.notice("PayingValueVC alert ok pressed in UPI-Pay")
                  case .cancel:
                        print("cancel")
                  case .destructive:
                        print("destructive")
                  @unknown default:
                    print("idk lol 2.0")
                  }}))
            self.present(alert, animated: true, completion: nil)
            return
        }
        if let intval = Int(amountTextField.text ?? "0"){
            paymentValue=intval
            self.logger.notice("PayingValueVC done pressed with paymentValue= \(self.paymentValue) in UPI-Pay")
        }else{
            self.logger.notice("PayingValueVC done pressed at invalid value in UPI-Pay")
            let alert = UIAlertController(title: "Alert", message: "invalid value", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                  switch action.style{
                  case .default:
                        print("default")
                    self.logger.notice("PayingValueVC alert ok pressed in UPI-Pay")
                  case .cancel:
                        print("cancel")
                  case .destructive:
                        print("destructive")
                  @unknown default:
                    print("idk lol")
                  }}))
            self.present(alert, animated: true, completion: nil)
        }
        performSegue(withIdentifier: "givePasscode", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addDoneButtonOnKeyboard()
        nameLabel.text = person.name
        numberLabel.text = String(person.number)
//        self.amountTextField.becomeFirstResponder()
        if paymentValue != 0{
            amountTextField.text = String(paymentValue)
            amountTextField.isUserInteractionEnabled=false
        }
        switch self.choosingStyle {
        case .default_hide:
            self.bankName = "Punjab National Bank"
            self.amountTextField.becomeFirstResponder()
        case .default_show:
            self.bankName = "Punjab National Bank"
            self.amountTextField.resignFirstResponder()
        case .choose_after:
            self.bankName = nil
            firsBankTickIV.isHidden=true
            secondBankTickIV.isHidden=true
            self.amountTextField.becomeFirstResponder()
        case .choose_before:
            self.bankName = nil
            firsBankTickIV.isHidden=true
            secondBankTickIV.isHidden=true
            self.amountTextField.resignFirstResponder()
        }
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        logger.notice("PayingValueVC will appear logging instance in UPI-Pay")
    }
    @IBAction func cancelPressed(_ sender: Any) {
        self.logger.notice("PayingValueVC cancel pressed in UPI-Pay")
        self.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="givePasscode", let vc = segue.destination as? UPIPinViewController{
            self.logger.notice("PayingValueVC segueing to UPIPinViewController in UPI-Pay")
            vc.delegate=self
            vc.person=self.person
            vc.bankName=self.bankName!
            vc.paymentValue=self.paymentValue
        }
    }
//    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
//        print("checkin segue")
//        if bankName==nil{
//            let alert = UIAlertController(title: "Alert", message: "No Bank Account Selected", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
//                  switch action.style{
//                  case .default:
//                        print("default")
//                  case .cancel:
//                        print("cancel")
//                  case .destructive:
//                        print("destructive")
//                  @unknown default:
//                    print("idk lol 2.0")
//                  }}))
//            self.present(alert, animated: true, completion: nil)
//            return false
//        }
//        return true;
//    }
    func dismissMyself() {
//        self.dismiss(animated: false, completion: nil)
        self.dismiss(animated: true) {
            self.delegate?.dismissMe()
        }
    }
    func addDoneButtonOnKeyboard(){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        amountTextField.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction(){
        amountTextField.resignFirstResponder()
    }
}
