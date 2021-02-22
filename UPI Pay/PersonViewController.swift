//
//  PersonViewController.swift
//  UPI Pay
//
//  Created by Kshitiz Sharma on 24/01/21.
//

import UIKit
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
//        print("int personvc person = \(person)")
        nameLabel.text = person.name
        numberLabel.text = String(person.number)
        switch person.verifications {
        case .verified:
            verifiedImageView.isHidden=false
            verifiedImageView.image = UIImage(systemName: "checkmark.seal.fill")
            verifiedImageView.tintColor = .systemBlue
            verificationSymbolMeaning.text = "Verified Seller"
            verificationSymbolMeaning.textColor = .systemBlue
        case .suspected:
            verifiedImageView.isHidden=false
            verifiedImageView.image = UIImage(systemName: "exclamationmark.circle.fill")
            verifiedImageView.tintColor = .systemYellow
            verificationSymbolMeaning.text = "This account has been reported spam multiple times, procede with caution"
            verificationSymbolMeaning.textColor = .systemYellow
        case .unknown:
            verifiedImageView.isHidden=true
        }
        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("segue from home page")
        if segue.identifier == "payingValueSegue"{
            if let vc = segue.destination as? PayingValueViewController{
//                print("person = \(self.payeeList[selectedUser])")
                vc.person = self.person
            }
        }
    }



}
