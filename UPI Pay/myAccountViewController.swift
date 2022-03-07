//
//  myAccountViewController.swift
//  UPI Pay
//
//  Created by Kshitiz Sharma on 05/05/21.
//

import UIKit
import OSLog
//protocol myAccountValueProtocol {
//    func dismissMyself()
//}
@available(iOS 14.0, *)
class myAccountViewController: UIViewController {
    
    var bankName: String? = "ABC National Bank"
    
    let logger = Logger(subsystem: "blindPolaroid.Page.UPI-Pay.myAccountVC", category: "BTP")
    
    @IBOutlet weak var bankView: UIView!{
        didSet{
            bankView.layer.cornerRadius=15
            //Draw shaddow for layer
            bankView.layer.shadowColor = UIColor.gray.cgColor
            bankView.layer.shadowOffset = CGSize(width: 0, height: 5)
            bankView.layer.shadowRadius = 5.0
            bankView.layer.shadowOpacity = 0.6
        }
    }
    @IBAction func viewBalanceClicked(_ sender: UIButton) {
        logger.notice("view balance for bank: \(self.bankName ?? "") clicked in UPI-Pay")
        
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        var str = format.string(from: Date()) + ": " + "view balance for bank: \(self.bankName ?? "") clicked in UPI-Pay\n"
        let filename = getDocumentsDirectory().appendingPathComponent("outputLog.txt")
        do {
            let oldString = try String(contentsOf: filename, encoding: String.Encoding.utf8)
            str = oldString + str
            try str.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            print("ERROR in adding log string: \(str)")
        }
        
        self.performSegue(withIdentifier: "viewBlaPinSegue", sender: self)
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
        logger.notice("myAccountView first bank selected in UPI-Pay")
        
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        var str = format.string(from: Date()) + ": " + "myAccountView first bank selected in UPI-Pay\n"
        let filename = getDocumentsDirectory().appendingPathComponent("outputLog.txt")
        do {
            let oldString = try String(contentsOf: filename, encoding: String.Encoding.utf8)
            str = oldString + str
            try str.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            print("ERROR in adding log string: \(str)")
        }
        
        firsBankTickIV.isHidden=false
        secondBankTickIV.isHidden=true
        self.bankName = "ABC National Bank"
    }
    @objc func secondBankSelected(){
        logger.notice("myAccountView second bank selected in UPI-Pay")
        
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        var str = format.string(from: Date()) + ": " + "myAccountView second bank selected in UPI-Pay\n"
        let filename = getDocumentsDirectory().appendingPathComponent("outputLog.txt")
        do {
            let oldString = try String(contentsOf: filename, encoding: String.Encoding.utf8)
            str = oldString + str
            try str.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            print("ERROR in adding log string: \(str)")
        }
        
        firsBankTickIV.isHidden=true
        secondBankTickIV.isHidden=false
        self.bankName = "DEF Bank"
    }
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        logger.notice("myAccountView will appear logging instance in UPI-Pay")
        
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        var str = format.string(from: Date()) + ": " + "myAccountView will appear logging instance in UPI-Pay\n"
        let filename = getDocumentsDirectory().appendingPathComponent("outputLog.txt")
        do {
            let oldString = try String(contentsOf: filename, encoding: String.Encoding.utf8)
            str = oldString + str
            try str.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            print("ERROR in adding log string: \(str)")
        }
        
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier=="viewBlaPinSegue"{
            logger.notice("myAccountView view balance pin segue selected in UPI-Pay")
            
            let format = DateFormatter()
            format.dateFormat = "yyyy-MM-dd HH:mm:ss"
            var str = format.string(from: Date()) + ": " + "myAccountView view balance pin segue selected in UPI-Pay\n"
            let filename = getDocumentsDirectory().appendingPathComponent("outputLog.txt")
            do {
                let oldString = try String(contentsOf: filename, encoding: String.Encoding.utf8)
                str = oldString + str
                try str.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
            } catch {
                print("ERROR in adding log string: \(str)")
            }

            
            let vc = segue.destination as! ViewBalancePinViewController
//            vc.delegate=self
//            vc.person=self.person
            vc.bankName=self.bankName!
//            vc.paymentValue=self.paymentValue
        }

    }
    

}
//extension myAccountViewController: myAccountValueProtocol{
//    func dismissMyself() {
//        self.dismiss(animated: true, completion: nil)
//    }
//
//}
//
