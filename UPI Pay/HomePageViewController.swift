//
//  HomePageViewController.swift
//  UPI Pay
//
//  Created by Kshitiz Sharma on 24/01/21.
//

import UIKit

class HomePageViewController: UIViewController, UITextFieldDelegate {
    var payeeList = [
        PersonInfo(number: 111, name: "Airtel", image: "Airtel.jpg", verifications: .verified),
        PersonInfo(number: 222, name: "Vodafone", image: "Vodafone.jpg"),
        PersonInfo(number: 333, name: "Jio", image: "Jio.jpg", verifications: .suspected),
        PersonInfo(number: 444, name: "Idea", image: "Idea.jpg", verifications: .unknown)
    ]

    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var qrImageView: UIImageView!{
        didSet{
            qrImageView.isUserInteractionEnabled=true
            qrImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(qrSegue)))
        }
    }
    @IBOutlet weak var mobileNumberTextField: UITextField!{
        didSet{
            mobileNumberTextField.delegate=self
            mobileNumberTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        }
    }
    @IBOutlet weak var hintUserView: UIView!{
        didSet{
            hintUserView.isUserInteractionEnabled=true
            hintUserView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(performUserSegue)))
//            hintUserView.layer.shadowColor = UIColor.systemGray.cgColor
//            hintUserView.layer.masksToBounds=false
//            hintUserView.layer.shadowRadius = 8.0
//            hintUserView.layer.cornerRadius = 6.0
        }
    }
    @IBOutlet weak var hintUserImageView: UIImageView!
    @IBOutlet weak var hintUserLabel: UILabel!
    @IBOutlet weak var hintUserNumberLabel: UILabel!
    @IBOutlet weak var personImageView: UIImageView!{
        didSet{
            personImageView.layer.cornerRadius = personImageView.layer.frame.width/2.0
        }
    }
    
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex==0{
            qrImageView.isHidden=false
            mobileNumberTextField.isHidden=true
            hintUserView.isHidden=true
        }else{
            qrImageView.isHidden=true
            mobileNumberTextField.isHidden=false
            hintUserView.isHidden=true
        }
    }
    var selectedUser = 0
    @objc func qrSegue(){
        
    }
    @objc func performUserSegue(){
        performSegue(withIdentifier: "personViewSegue", sender: self)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
//        print("mobileNumberValueChanged")
        for ind in payeeList.indices{
            if let query = textField.text{
                if String(payeeList[ind].number).hasPrefix(query){
                    selectedUser=ind
//                    print("selected user ind = \(ind)")
                    setHintUserView()
                    break
                }
            }
        }
    }
    func setHintUserView(){
        hintUserView.isHidden=false
        hintUserLabel.text = payeeList[selectedUser].name
        hintUserNumberLabel.text = String(payeeList[selectedUser].number)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        print("segue from home page")
        if segue.identifier == "personViewSegue"{
            if let vc = segue.destination as? PersonViewController{
//                print("person = \(self.payeeList[selectedUser])")
                vc.person = self.payeeList[selectedUser]
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default) //UIImage.init(named: "transparent.png")
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
}
