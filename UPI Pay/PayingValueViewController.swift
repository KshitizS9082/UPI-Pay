//
//  PayingValueViewController.swift
//  UPI Pay
//
//  Created by Kshitiz Sharma on 24/01/21.
//

import UIKit

class PayingValueViewController: UIViewController {
    var person = PersonInfo()
    var bankName = "STATE BANK OF INDIA"
    var paymentValue = 0
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
    
    @objc func donePressed(){
        if let intval = Int(amountTextField.text ?? "0"){
            paymentValue=intval
        }else{
            let alert = UIAlertController(title: "Alert", message: "invalid value", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                  switch action.style{
                  case .default:
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
        performSegue(withIdentifier: "givePasscode", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = person.name
        numberLabel.text = String(person.number)
        // Do any additional setup after loading the view.
    }
    @IBAction func cancelPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="givePasscode", let vc = segue.destination as? UPIPinViewController{
            vc.person=self.person
            vc.bankName=self.bankName
            vc.paymentValue=self.paymentValue
        }
    }

}
