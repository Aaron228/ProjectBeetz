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

class LoginViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       emailAddressTextField.delegate = self
       passwordTextField.delegate = self
    }
    
    //Dismisses the keyboards when clicking outside of the text fields
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        emailAddressTextField.resignFirstResponder();
        passwordTextField.resignFirstResponder();
    }
    
    //Dismisses the keyboards when hitting return on the keyboard
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailAddressTextField.resignFirstResponder();
        passwordTextField.resignFirstResponder();
        return true
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

