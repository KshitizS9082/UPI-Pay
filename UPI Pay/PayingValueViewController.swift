//
//  PayingValueViewController.swift
//  UPI Pay
//
//  Created by Kshitiz Sharma on 24/01/21.
//

import UIKit
//import OSLog
protocol payingValueProtocol {
    func dismissMyself()
}

@available(iOS 14.0, *)
class PayingValueViewController: UIViewController, payingValueProtocol {
    
    enum BankChoosingStyle{
        case default_hide
        case default_show
        case choose_before
        case choose_after
    }
//    let logger = Logger(subsystem: "blindPolaroid.Page.UPI-Pay.PersonVC", category: "BTP")
    var choosingStyle = BankChoosingStyle.default_show
    var hideVerifiedImageTag = true
    var person = PersonInfo()
    var bankName: String? = "ABC National Bank"
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
    
    @IBOutlet weak var verifiedImageView: UIImageView!{
        didSet{
            verifiedImageView.isUserInteractionEnabled=true
            verifiedImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(verificationIVTap)))
        }
    }
    @IBOutlet weak var verificationSymbolMeaning: UILabel!
    @IBOutlet weak var verMeanBackg: UIView!{
        didSet{
            verMeanBackg.layer.cornerRadius = 3
        }
    }
    
    @objc func verificationIVTap(){
            if verificationSymbolMeaning.isHidden{
//                logger.notice("PersonVC verificationIVTap to unhide meaning in UPI-Pay")
                
                addLog(logStr: "PersonVC verificationIVTap to unhide meaning in UPI-Pay")
            }else{
//                logger.notice("PersonVC verificationIVTap to hide meaning in UPI-Pay")
                
                addLog(logStr: "PersonVC verificationIVTap to hide meaning in UPI-Pay")
            }
            verificationSymbolMeaning.isHidden = !verificationSymbolMeaning.isHidden
            verMeanBackg.isHidden = verificationSymbolMeaning.isHidden
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
//        logger.notice("PayingValueVC first bank(\(self.bankName ?? "") selected in UPI-Pay")
        addLog(logStr: "PayingValueVC first bank(\(self.bankName ?? "") selected in UPI-Pay")
    }
    @objc func secondBankSelected(){
        firsBankTickIV.isHidden=true
        secondBankTickIV.isHidden=false
        self.bankName = "DEF Bank"
//        logger.notice("PayingValueVC second bank(\(self.bankName ?? "") selected in UPI-Pay")
        addLog(logStr: "PayingValueVC second bank(\(self.bankName ?? "") selected in UPI-Pay")
    }
    
    @objc func donePressed(){
//        logger.notice("PayingValueVC done pressed selected in UPI-Pay")
        addLog(logStr: "PayingValueVC done pressed selected in UPI-Pay")
        if bankName==nil{
//            logger.notice("PayingValueVC no bank selected, showing alert in UPI-Pay")
            addLog(logStr: "PayingValueVC no bank selected, showing alert in UPI-Pay")
            let alert = UIAlertController(title: "Alert", message: "No Bank Account Selected", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                  switch action.style{
                  case .default:
                        print("default")
//                        self.logger.notice("PayingValueVC alert ok pressed in UPI-Pay")
                      self.addLog(logStr: "PayingValueVC alert ok pressed in UPI-Pay")
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
//            self.logger.notice("PayingValueVC done pressed with paymentValue= \(self.paymentValue) in UPI-Pay")
            self.addLog(logStr: "PayingValueVC done pressed with paymentValue= \(self.paymentValue) in UPI-Pay")
        }else{
//            self.logger.notice("PayingValueVC done pressed at invalid value in UPI-Pay")
            self.addLog(logStr: "PayingValueVC done pressed at invalid value in UPI-Pay")
            let alert = UIAlertController(title: "Alert", message: "invalid value", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                  switch action.style{
                  case .default:
                      print("default")
//                      self.logger.notice("PayingValueVC alert ok pressed in UPI-Pay")
                      self.addLog(logStr: "PayingValueVC alert ok pressed in UPI-Pay")
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
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    func addLog(logStr: String) {
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        var str = format.string(from: Date()) + ": " +  logStr + "\n"
        let filename = self.getDocumentsDirectory().appendingPathComponent("outputLog.txt")
        do {
            let oldString = try String(contentsOf: filename, encoding: String.Encoding.utf8)
            str = oldString + str
            try str.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            print("ERROR in adding log string: \(str)")
        }
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
            self.bankName = "ABC National Bank"
            self.amountTextField.becomeFirstResponder()
        case .default_show:
            self.bankName = "ABC National Bank"
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
        
        switch person.verifications {
        case .verified:
            verifiedImageView.isHidden=false
            verifiedImageView.image = UIImage(systemName: "checkmark.seal.fill")
            verifiedImageView.tintColor = .systemGreen
            verificationSymbolMeaning.text = "Verified Seller"
            verificationSymbolMeaning.textColor = .systemGreen
        case .suspected:
            verifiedImageView.isHidden=false
            verifiedImageView.image = UIImage(systemName: "exclamationmark.circle.fill")
            verifiedImageView.tintColor = .systemRed
            verificationSymbolMeaning.text = "This account has been reported spam multiple times, procede with caution"
            verificationSymbolMeaning.textColor = .systemRed
        case .unknown:
            //            verifiedImageView.isHidden=true
            verifiedImageView.isHidden=false
            verifiedImageView.image = UIImage(systemName: "questionmark.circle.fill")
            verifiedImageView.tintColor = .systemYellow
            verificationSymbolMeaning.text = "Neither suspected nor verified"
            verificationSymbolMeaning.textColor = .yellow
        }
        
        verifiedImageView.isHidden=self.hideVerifiedImageTag
    }
    override func viewWillAppear(_ animated: Bool) {
//        logger.notice("PayingValueVC will appear logging instance in UPI-Pay")
        self.addLog(logStr: "PayingValueVC will appear logging instance in UPI-Pay")
    }
    @IBAction func cancelPressed(_ sender: Any) {
//        self.logger.notice("PayingValueVC cancel pressed in UPI-Pay")
        self.addLog(logStr: "PayingValueVC cancel pressed in UPI-Pay")
        self.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="givePasscode", let vc = segue.destination as? UPIPinViewController{
//            self.logger.notice("PayingValueVC segueing to UPIPinViewController in UPI-Pay")
            self.addLog(logStr: "PayingValueVC segueing to UPIPinViewController in UPI-Pay")
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
