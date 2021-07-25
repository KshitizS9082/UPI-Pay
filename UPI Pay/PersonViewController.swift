//
//  PersonViewController.swift
//  UPI Pay
//
//  Created by Kshitiz Sharma on 24/01/21.
//

import UIKit
import OSLog
struct PersonInfo{
    var number = 0
    var name = ""
    var image = ""
    var verifications = status.unknown
    enum status {
        case verified
        case suspected
        case unknown
    }
}

class PersonViewController: UIViewController {
    var person = PersonInfo()
    var bankName = "STATE BANK OF INDIA"
    let logger = Logger(subsystem: "blindPolaroid.Page.UPI-Pay.PersonVC", category: "BTP")
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
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
            logger.notice("PersonVC verificationIVTap to unhide meaning in UPI-Pay")
        }else{
            logger.notice("PersonVC verificationIVTap to hide meaning in UPI-Pay")
        }
        verificationSymbolMeaning.isHidden = !verificationSymbolMeaning.isHidden
        verMeanBackg.isHidden = verificationSymbolMeaning.isHidden
    }
    
    @IBOutlet weak var payButton: UIButton!{
        didSet{
            payButton.layer.cornerRadius = payButton.layer.frame.height/2.0
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        logger.notice("PersonVC did load with person mobile no.: \(self.person.number) in UPI-Pay")
//        print("int personvc person = \(person)")
        nameLabel.text = person.name
        numberLabel.text = String(person.number)
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
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        logger.notice("PersonVC will appear logging instance in UPI-Pay")
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("segue from home page")
        if segue.identifier == "payingValueSegue"{
            logger.notice("PersonVC segueing to payingValueVC in UPI-Pay")
            if let vc = segue.destination as? PayingValueViewController{
//                print("person = \(self.payeeList[selectedUser])")
                vc.person = self.person
            }
        }
    }



}
