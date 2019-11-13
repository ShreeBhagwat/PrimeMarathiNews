//
//  RegisterViewController.swift
//  PrimeMarathiNews
//
//  Created by Shree Bhagwat on 10/11/19.
//  Copyright © 2019 Shree Bhagwat. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import AFNetworking
import ProgressHUD

class RegisterViewController: UIViewController {
    
    
    @IBOutlet weak var nameLableOutlet: SkyFloatingLabelTextFieldWithIcon!
    
    @IBOutlet weak var registerButtonOutlet: UIButton!
    @IBOutlet weak var phoneLableOutlet: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var confirmLableOutlet: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var passwordLableOutlet: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var emailLableOutlet: SkyFloatingLabelTextFieldWithIcon!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func registerButtonPressed(_ sender: Any) {
    }
    
   

}
