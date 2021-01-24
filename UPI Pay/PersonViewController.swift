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
}

class PersonViewController: UIViewController {
    var person = PersonInfo()
    var bankName = "STATE BANK OF INDIA"
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    
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
