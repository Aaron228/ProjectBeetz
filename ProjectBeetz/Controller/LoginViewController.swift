//
//  LoginViewController.swift
//  ProjectBeetz
//
//  Created by Aaron Lee on 2/21/19.
//  Copyright © 2019 Aaron Lee. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD
import ChameleonFramework

class LoginViewController: UIViewController {
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var emailAddressTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        
        SVProgressHUD.show()
        
        Auth.auth().signIn(withEmail: emailAddressTextField.text!, password: passwordTextField.text!) { (user, error) in
            
            if error != nil {
                print(error!)
            } else {
                print("Login Successful")
                
                SVProgressHUD.dismiss()
                
                self.performSegue(withIdentifier: "goToDistributionViewController", sender: self)
            }
            
        }
        
    }
    
        
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        
        
    }
    
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

