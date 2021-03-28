//
//  HomePageViewController.swift
//  UPI Pay
//
//  Created by Kshitiz Sharma on 24/01/21.
//

import UIKit


class HomePageViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
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
    //QR Format: http://number/Value/debit
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
    @IBOutlet weak var qrGalleryButton: UIButton!
    var person: PersonInfo?
    var bankName: String? = "Punjab National Bank"
    var paymentValue = 0
    var imagePicker = UIImagePickerController()
    @IBAction func grGalleryButClicked(_ sender: Any) {
        qrImagePicker()
    }
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex==0{
            qrImageView.isHidden=false
            qrGalleryButton.isHidden=false
            mobileNumberTextField.isHidden=true
            hintUserView.isHidden=true
            mobileNumberTextField.resignFirstResponder()
        }else{
            qrImageView.isHidden=true
            qrGalleryButton.isHidden=true
            mobileNumberTextField.isHidden=false
            hintUserView.isHidden=true
        }
    }
    func qrImagePicker() {
        
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            print("Button capture")
            
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        }
    }
    func detectQRCode(_ image: UIImage?) -> [CIFeature]? {
        if let image = image, let ciImage = CIImage.init(image: image){
            var options: [String: Any]
            let context = CIContext()
            options = [CIDetectorAccuracy: CIDetectorAccuracyHigh]
            let qrDetector = CIDetector(ofType: CIDetectorTypeQRCode, context: context, options: options)
            if ciImage.properties.keys.contains((kCGImagePropertyOrientation as String)){
                options = [CIDetectorImageOrientation: ciImage.properties[(kCGImagePropertyOrientation as String)] ?? 1]
            } else {
                options = [CIDetectorImageOrientation: 1]
            }
            let features = qrDetector?.features(in: ciImage, options: options)
            return features

        }
        return nil
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var newImage: UIImage

        if let possibleImage = info[.editedImage] as? UIImage {
            newImage = possibleImage
        } else if let possibleImage = info[.originalImage] as? UIImage {
            newImage = possibleImage
        } else {
            return
        }

        // do something interesting here!
        print(newImage.size)
        qrImageView.image = newImage
        dismiss(animated: true)
        
        if let features = detectQRCode(newImage), !features.isEmpty{
            for case let row as CIQRCodeFeature in features{
                if var decode = row.messageString{
                    decode = String(decode.dropFirst(7))
                    let decodeArr = decode.split{$0 == "/"}.map(String.init)
                    for person in payeeList{
                        if person.number == Int(decodeArr[0])!{
                            self.person = person
                        }
                    }
                    self.paymentValue = Int(decodeArr[1])!
                    print("perform segue: givePasscodeHP")
                    performSegue(withIdentifier: "givePasscodeHP", sender: self)
                }
            }
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
        }else if segue.identifier=="givePasscodeHP", let vc = segue.destination as? UPIPinViewController{
//            vc.delegate=self
            vc.person=self.person!
            vc.bankName=self.bankName!
            vc.paymentValue=self.paymentValue
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default) //UIImage.init(named: "transparent.png")
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
}
