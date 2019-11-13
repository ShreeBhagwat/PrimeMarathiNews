//
//  ForgotPasswordViewController.swift
//  PrimeMarathiNews
//
//  Created by Shree Bhagwat on 02/11/19.
//  Copyright © 2019 Shree Bhagwat. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import ProgressHUD
import SDLoader
import AFNetworking
import ChameleonFramework
import Toast_Swift

class ForgotPasswordViewController: UIViewController {
    @IBOutlet weak var centerViewOutlet: UIView!
    @IBOutlet weak var emailTextFieldOutlet: SkyFloatingLabelTextFieldWithIcon!
    var centerViewPosition : CGRect?
    let spinner = SDLoader()
    var forgotArray = NSMutableArray()
    
    @IBOutlet weak var sendButtonOutlet: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
     NotificationCenter.default.addObserver(self, selector: #selector(self.receivePackageName(_:)), name: NSNotification.Name("PackageNameNotification"), object: nil)
        

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
        self.view.frame.origin.y = 0
//             registerKeyboardNotification()
        }
        
        override func viewDidDisappear(_ animated: Bool) {
            super.viewDidDisappear(animated)
//           unregisterKeyboardNotification()
        }
        
        func registerKeyboardNotification(){
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
            
        }
        func unregisterKeyboardNotification(){
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object:     nil)
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        }
        
        @objc private func keyboardWillShow(notification: NSNotification){
            print("Keyboard Shown")
            
            guard let keyboardFrameValue = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
            let keyboardFrame = view.convert(keyboardFrameValue.cgRectValue, to: nil)

            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y = -50
            }
            
        }
        
        @objc private func keyboardWillHide(notification: NSNotification){
            print("Keyboard Hidden")
   
            
            self.view.frame.origin.y = 0

            
        }

    @IBAction func sendButtonPressed(_ sender: Any) {
        if(emailTextFieldOutlet.text == ""){
            ProgressHUD.showError(CommonMessage.Enter_email_address())
        }else if !Methods.validateEmail(with: self.emailTextFieldOutlet.text) {
            ProgressHUD.showError(CommonMessage.Enter_Valid_email_address())
        }else{
            emailTextFieldOutlet.resignFirstResponder()
            getForget()
        }
    }
    
    func getForget() {
        if (Reachability.shared.isConnectedToNetwork()) {
           self.startSpinner()
           let str = String(format: "%@api.php",Methods.getBaseUrl())
           let encodedString = str.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            self.getForgotData(encodedString!)
       } else {
            self.internetConnectionNotAvailable()
       }
    }
    
    func getForgotData(_ requestUrl: String){
        let salt = Methods.getSalt() as String
        let sign = Methods.getSign(salt)
        let email = emailTextFieldOutlet.text
        let dict = ["salt":salt, "sign":sign, "method_name":"forgot_pass", "email":email]
        let data = Methods.getBase64EncodedString(dict as [AnyHashable: Any])
        let strDict = ["data": data]
        let manager = AFHTTPSessionManager()
        manager.post(requestUrl, parameters: strDict, progress: nil, success: { (task, responseObject) in
            if let responseObject = responseObject {
                self.forgotArray.removeAllObjects()
                let response = responseObject as AnyObject?
                let storeArr = response?.object(forKey: "ALL_IN_ONE_NEWS") as!NSArray
                for i in 0..<storeArr.count {
                    let storeDict = storeArr[i] as? [AnyHashable: Any]
                    if storeDict != nil {
                        self.forgotArray.add(storeArr as Any)
                    }
                }
                DispatchQueue.main.async {
            let success = (self.forgotArray.value(forKey: "success") as! NSArray).componentsJoined(by: "")
                    if (success == "0"){
                let msg = (self.forgotArray.value(forKey: "msg") as! NSArray).componentsJoined(by: "")
                        var style = ToastStyle()
                        self.view.makeToast(msg, duration: 3.0, position: .bottom, style: style)
                    }else{
                        let msg = (self.forgotArray.value(forKey: "msg") as! NSArray).componentsJoined(by: "")
                        var style = ToastStyle()
                        self.view.makeToast(msg, duration: 3.0, position: .bottom, style: style)
                    }
                    
                }
                self.stopSpinner()
            }
            
        }) { (opreation, error) in
            self.networkFailure()
            self.stopSpinner()
        }
        
    }
    
    // Start Stop Spinner
     func startSpinner() {
         self.spinner.spinner?.lineWidth = 15
         self.spinner.spinner?.spacing = 0.2
         self.spinner.spinner?.sectorColor = UIColor.cyan.cgColor
         self.spinner.spinner?.textColor = UIColor.cyan
         self.spinner.spinner?.animationType = AnimationType.anticlockwise
         self.spinner.startAnimating(atView: self.view)
     }
     
     func stopSpinner(){
         self.spinner.stopAnimation()

     }
    
    @objc func receivePackageName(_ notification: Notification){
           if ((notification.name).rawValue == "PackageNotification") {
               let isPackageNameSame = UserDefaults.standard.bool(forKey: "PAKAGENAME")
               if (!isPackageNameSame) {
                  let msg = "You are using invalid License or Pakage name, Kindly contack developer to resolve this issue at shreebhagwat94@gmail.com"
                   let uiAlert = UIAlertController(title: nil, message: msg, preferredStyle: UIAlertController.Style.alert)
                   self.present(uiAlert, animated: true, completion: nil)
               }
           }
       }
    
    func internetConnectionNotAvailable(){
            ProgressHUD.showError(CommonMessage.InternetConnectionNotAvailable())
    }
    
    func networkFailure(){
        ProgressHUD.showError(CommonMessage.CouldNotConnectToServer())
    }
       
}
