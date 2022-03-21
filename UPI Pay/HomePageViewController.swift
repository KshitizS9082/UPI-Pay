//
//  HomePageViewController.swift
//  UPI Pay
//
//  Created by Kshitiz Sharma on 24/01/21.
//

import UIKit
import OSLog

var firstBalance = 250000
var secondBalance = 150000

@available(iOS 14.0, *)
class HomePageViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var payeeList = [
        PersonInfo(number: 111, name: "Raj", image: "Airtel.jpg", verifications: .verified),
        PersonInfo(number: 222, name: "Rohan", image: "Vodafone.jpg"),
        PersonInfo(number: 333, name: "Jio", image: "Jio.jpg", verifications: .suspected),
        PersonInfo(number: 444, name: "Idea", image: "Idea.jpg", verifications: .unknown)
    ]
    
    let logger = Logger(subsystem: "blindPolaroid.Page.UPI-Pay.homepage", category: "BTP")
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var qrImageView: UIImageView!{
        didSet{
            qrImageView.isUserInteractionEnabled=true
            qrImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(qrSegue)))
        }
    }
    //QR Format: http://number/Value/name/verificationNumber(0=unknown,1=verified,2=suspected)/debit
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
            personImageView.isUserInteractionEnabled=true
            personImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(personIVSelected)))
        }
    }
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    @objc func personIVSelected(){
        logger.notice("selected to go to My account page in homepage in UPI-Pay")
        
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        var str = format.string(from: Date()) + ": " + "selected to go to My account page in homepage in UPI-Pay \n"
        let filename = getDocumentsDirectory().appendingPathComponent("outputLog.txt")
        do {
            let oldString = try String(contentsOf: filename, encoding: String.Encoding.utf8)
            str = oldString + str
            try str.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            print("ERROR in adding log string: \(str)")
        }
        
        performSegue(withIdentifier: "myAcntSegue", sender: self)
    }
    @IBOutlet weak var qrGalleryButton: UIButton!
    var person: PersonInfo?
    var bankName: String? = "ABC National Bank"
    var paymentValue = 0
    var hideAlert = false
    var imagePicker = UIImagePickerController()
    @IBAction func grGalleryButClicked(_ sender: Any) {
        qrImagePicker()
    }
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex==0{
            logger.notice("selected QR Segment in UPI-Pay")
            
            let format = DateFormatter()
            format.dateFormat = "yyyy-MM-dd HH:mm:ss"
            var str = format.string(from: Date()) + ": " + "selected QR Segment in UPI-Pay \n"
            let filename = getDocumentsDirectory().appendingPathComponent("outputLog.txt")
            do {
                let oldString = try String(contentsOf: filename, encoding: String.Encoding.utf8)
                str = oldString + str
                try str.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
            } catch {
                print("ERROR in adding log string: \(str)")
            }

            
            qrImageView.isHidden=false
            qrGalleryButton.isHidden=false
            mobileNumberTextField.isHidden=true
            hintUserView.isHidden=true
            mobileNumberTextField.resignFirstResponder()
        }else{
            logger.notice("selected Pay via number Segment in UPI-Pay")
            
            let format = DateFormatter()
            format.dateFormat = "yyyy-MM-dd HH:mm:ss"
            var str = format.string(from: Date()) + ": " + "selected Pay via number Segment in UPI-Pay\n"
            let filename = getDocumentsDirectory().appendingPathComponent("outputLog.txt")
            do {
                let oldString = try String(contentsOf: filename, encoding: String.Encoding.utf8)
                str = oldString + str
                try str.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
            } catch {
                print("ERROR in adding log string: \(str)")
            }
            
            qrImageView.isHidden=true
            qrGalleryButton.isHidden=true
            mobileNumberTextField.isHidden=false
            hintUserView.isHidden=true
        }
    }
    
    var requestMessage = ""
    func handleReceiveMoneyRequest(person: PersonInfo, message: String, value: Int, tohide: Bool){
        self.person = person
        self.paymentValue = value
        self.requestMessage = message
        self.hideAlert = tohide
        logger.notice("showing request Money view in UPI-Pay")
        
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        var str = format.string(from: Date()) + ": " + "showing request Money view in UPI-Pay\n"
        let filename = getDocumentsDirectory().appendingPathComponent("outputLog.txt")
        do {
            let oldString = try String(contentsOf: filename, encoding: String.Encoding.utf8)
            str = oldString + str
            try str.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            print("ERROR in adding log string: \(str)")
        }
        
        self.performSegue(withIdentifier: "requestPaymentSegue", sender: self)
        
    }
    
    func qrImagePicker() {
        
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            print("Button capture")
            
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            logger.notice("preseting QR image picker in UPI-Pay")
            
            let format = DateFormatter()
            format.dateFormat = "yyyy-MM-dd HH:mm:ss"
            var str = format.string(from: Date()) + ": " + "preseting QR image picker in UPI-Pay\n"
            let filename = getDocumentsDirectory().appendingPathComponent("outputLog.txt")
            do {
                let oldString = try String(contentsOf: filename, encoding: String.Encoding.utf8)
                str = oldString + str
                try str.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
            } catch {
                print("ERROR in adding log string: \(str)")
            }
            
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
//                    for person in payeeList{
//                        if person.number == Int(decodeArr[0])!{
//                            self.person = person
//                        }
//                    }
                    paymentValue = Int(decodeArr[1])!
                    let payeeNumber = Int(decodeArr[0])!
                    let payeeName = decodeArr[2]
                    let verNum = Int(decodeArr[3])!
                    self.person = PersonInfo(number: payeeNumber, name: payeeName, image: "Image", verifications: .unknown)
                    if verNum == 0 {
                        self.person?.verifications = .unknown
                    }else if verNum == 1 {
                        self.person?.verifications = .verified
                    }else if verNum == 2{
                        self.person?.verifications = .suspected
                    }
                    print("perform segue: givePasscodeHP")
                    logger.notice("decoded QR and segueing to givePasscodeHP with person= \(self.person?.number ?? 0) and paymentvalue= \(self.paymentValue) in UPI-Pay")
                    
                    let format = DateFormatter()
                    format.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    var str = format.string(from: Date()) + ": " + "decoded QR and segueing to givePasscodeHP with person= \(self.person?.number ?? 0) and paymentvalue= \(self.paymentValue) in UPI-Pay\n"
                    let filename = getDocumentsDirectory().appendingPathComponent("outputLog.txt")
                    do {
                        let oldString = try String(contentsOf: filename, encoding: String.Encoding.utf8)
                        str = oldString + str
                        try str.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
                    } catch {
                        print("ERROR in adding log string: \(str)")
                    }
                    
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
        logger.notice("homepage searching mobile no. \(textField.text ?? "") instance in UPI-Pay")
        
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        var str = format.string(from: Date()) + ": " + "homepage searching mobile no. \(textField.text ?? "") instance in UPI-Pay\n"
        let filename = getDocumentsDirectory().appendingPathComponent("outputLog.txt")
        do {
            let oldString = try String(contentsOf: filename, encoding: String.Encoding.utf8)
            str = oldString + str
            try str.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            print("ERROR in adding log string: \(str)")
        }
        
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
                self.logger.notice("selected User with number: \(self.payeeList[self.selectedUser].number) in UPI-Pay")
                
                let format = DateFormatter()
                format.dateFormat = "yyyy-MM-dd HH:mm:ss"
                var str = format.string(from: Date()) + ": " + "selected User with number: \(self.payeeList[self.selectedUser].number) in UPI-Pay"
                let filename = getDocumentsDirectory().appendingPathComponent("outputLog.txt")
                do {
                    let oldString = try String(contentsOf: filename, encoding: String.Encoding.utf8)
                    str = oldString + str
                    try str.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
                } catch {
                    print("ERROR in adding log string: \(str)")
                }
                
            }
        }else if segue.identifier=="givePasscodeHP", let vc = segue.destination as? UPIPinViewController{
//            vc.delegate=self
            vc.person=self.person!
            vc.bankName=self.bankName!
            vc.paymentValue=self.paymentValue
        }else if segue.identifier == "requestPaymentSegue"{
            if let vc = segue.destination as? RequestMoneyViewController{
//                print("person = \(self.payeeList[selectedUser])")
                vc.person = self.person
                vc.value = self.paymentValue
                vc.message = self.requestMessage
                vc.hideAlert = self.hideAlert
            }
        }
            
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default) //UIImage.init(named: "transparent.png")
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        logger.notice("homepage will appear logging instance in UPI-Pay")
        
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        var str = format.string(from: Date()) + ": " + "homepage will appear logging instance in UPI-Pay \n"
        let filename = getDocumentsDirectory().appendingPathComponent("outputLog.txt")
        if FileManager.default.fileExists(atPath: filename.path){
            do {
                let oldString = try String(contentsOf: filename, encoding: String.Encoding.utf8)
                str = oldString + str
                try str.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
            } catch {
                print("ERROR in adding log string: \(str)")
            }
        }else{
            do {
                try str.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
            } catch {
                print("ERROR in adding log string: \(str)")
            }
        }
        

        
    }
    override func viewDidLoad() {
//        let url = URL(string: "deeplink-example://donnywals.com/")!
//        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
