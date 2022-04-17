//
//  RequestMoneyViewController.swift
//  UPI Pay
//
//  Created by Kshitiz Sharma on 05/05/21.
//

import UIKit
//import OSLog
protocol RequestMoneyProtocol {
    func dismissMe()
}
@available(iOS 14.0, *)
class RequestMoneyViewController: UIViewController {
    var person: PersonInfo?
    var value = 0
    var message = ""
    var hideAlert = true
    var hideVerifiedImageTag = true
//    let logger = Logger(subsystem: "blindPolaroid.Page.UPI-Pay.RequestMoneyVC", category: "BTP")
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var paymentValueLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var personImageView: UIImageView!
    
    
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
        
        if let imgname = person?.image, let img = UIImage(named: imgname){
            personImageView.image = img
        }

        
        warningLabel.isHidden = self.hideAlert
        // Do any additional setup after loading the view.
        
        switch person!.verifications {
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
//        logger.notice("RequestMoneyVC will appear logging instance in UPI-Pay")
        
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        var str = format.string(from: Date()) + ": " + "RequestMoneyVC will appear logging instance in UPI-Pay\n"
        let filename = self.getDocumentsDirectory().appendingPathComponent("outputLog.txt")
        do {
            let oldString = try String(contentsOf: filename, encoding: String.Encoding.utf8)
            str = oldString + str
            try str.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            print("ERROR in adding log string: \(str)")
        }
    }
    @IBAction func payPressed(_ sender: Any) {
//        logger.notice("RequestMoneyVC Pay Pressed in UPI-Pay")
        
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        var str = format.string(from: Date()) + ": " + "RequestMoneyVC Pay Pressed in UPI-Pay\n"
        let filename = self.getDocumentsDirectory().appendingPathComponent("outputLog.txt")
        do {
            let oldString = try String(contentsOf: filename, encoding: String.Encoding.utf8)
            str = oldString + str
            try str.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            print("ERROR in adding log string: \(str)")
        }
        
        performSegue(withIdentifier: "requestMoneyUPIStage", sender: self)
    }
    @IBAction func xPressed(_ sender: Any) {
//        logger.notice("RequestMoneyVC X(Cancel) Pressed in UPI-Pay")
        
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        var str = format.string(from: Date()) + ": " + "RequestMoneyVC X(Cancel) Pressed in UPI-Pay\n"
        let filename = self.getDocumentsDirectory().appendingPathComponent("outputLog.txt")
        do {
            let oldString = try String(contentsOf: filename, encoding: String.Encoding.utf8)
            str = oldString + str
            try str.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            print("ERROR in adding log string: \(str)")
        }
        
//        print("dismissed RequestMoneyViewController with cross")
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func declinePressed(_ sender: Any) {
//        logger.notice("RequestMoneyVC Decline Pressed in UPI-Pay")
        
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        var str = format.string(from: Date()) + ": " + "RequestMoneyVC Decline Pressed in UPI-Pay\n"
        let filename = self.getDocumentsDirectory().appendingPathComponent("outputLog.txt")
        do {
            let oldString = try String(contentsOf: filename, encoding: String.Encoding.utf8)
            str = oldString + str
            try str.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            print("ERROR in adding log string: \(str)")
        }
        
//        print("dismissed RequestMoneyViewController with decline press")
        self.dismiss(animated: true, completion: nil)
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
                
                let format = DateFormatter()
                format.dateFormat = "yyyy-MM-dd HH:mm:ss"
                var str = format.string(from: Date()) + ": " + "PersonVC verificationIVTap to unhide meaning in UPI-Pay\n"
                let filename = self.getDocumentsDirectory().appendingPathComponent("outputLog.txt")
                do {
                    let oldString = try String(contentsOf: filename, encoding: String.Encoding.utf8)
                    str = oldString + str
                    try str.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
                } catch {
                    print("ERROR in adding log string: \(str)")
                }
                
            }else{
//                logger.notice("PersonVC verificationIVTap to hide meaning in UPI-Pay")
                
                let format = DateFormatter()
                format.dateFormat = "yyyy-MM-dd HH:mm:ss"
                var str = format.string(from: Date()) + ": " + "PersonVC verificationIVTap to hide meaning in UPI-Pay\n"
                let filename = self.getDocumentsDirectory().appendingPathComponent("outputLog.txt")
                do {
                    let oldString = try String(contentsOf: filename, encoding: String.Encoding.utf8)
                    str = oldString + str
                    try str.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
                } catch {
                    print("ERROR in adding log string: \(str)")
                }
                
            }
            verificationSymbolMeaning.isHidden = !verificationSymbolMeaning.isHidden
            verMeanBackg.isHidden = verificationSymbolMeaning.isHidden
        }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
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
@available(iOS 14.0, *)
extension RequestMoneyViewController: RequestMoneyProtocol{
    func dismissMe() {
        self.dismiss(animated: false, completion: nil)
    }
}
