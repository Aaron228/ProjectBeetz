//
//  RegisterViewController.swift
//  ProjectBeetz
//
//  Created by Aaron Lee on 2/21/19.
//  Copyright © 2019 Aaron Lee. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD
import ChameleonFramework

class RegisterViewController: UIViewController {
    @IBOutlet weak var registerUserTextLabel: UILabel!
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func registerButtonPressed(_ sender: UIButton) {
        
        guard let emailAddress = emailAddressTextField.text, !emailAddress.isEmpty else {
            self.showMessage(messageToDisplay: "Email address is required.")
            return;
        }
        guard let password = passwordTextField.text, !password.isEmpty else {
            self.showMessage(messageToDisplay: "Password is required.")
            return;
        }
        
        print("Email address and password are entered into the appropriate fields")
        
        SVProgressHUD.show()
        
        Auth.auth().createUser(withEmail: emailAddressTextField.text!, password: passwordTextField.text!) { (user, error) in
            
            if error != nil {
                print(error!)
            }
            else {
                //success
                print("Registration successful!")
                
                SVProgressHUD.dismiss()
            
                
                self.performSegue(withIdentifier: "goToDistributionViewController", sender: self)
            }
        }
    }
        
         func showMessage(messageToDisplay: String) {
            let alertController = UIAlertController(title: "Alert title", message: messageToDisplay, preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "OK", style: .default) {
                (action:UIAlertAction!) in
                
                //Code in this block will trigger when OK button is tapped.
                
                print("OK button tapped")
            }
            
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
            
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
