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
        firsBankTickIV.isHidden=false
        secondBankTickIV.isHidden=true
        self.bankName = "ABC National Bank"
    }
    @objc func secondBankSelected(){
        logger.notice("myAccountView second bank selected in UPI-Pay")
        firsBankTickIV.isHidden=true
        secondBankTickIV.isHidden=false
        self.bankName = "DEF Bank"
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        logger.notice("myAccountView will appear logging instance in UPI-Pay")
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier=="viewBlaPinSegue"{
            logger.notice("myAccountView view balance pin segue selected in UPI-Pay")
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
