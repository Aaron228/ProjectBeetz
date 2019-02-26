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
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
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
        guard let repeatPassword = repeatPasswordTextField.text, !repeatPassword.isEmpty else {
            self.showMessage(messageToDisplay: "Repeat password is required.")
            return;
        }
        
        if password != repeatPassword {
            self.showMessage(messageToDisplay: "Password and Repeat password don't match.")
            return;
        }
        
        
        print("Email address and password are entered into the appropriate fields")
        
        SVProgressHUD.show()
        
        // This registers the user and then send them an email to verify the account.
        
        Auth.auth().createUser(withEmail: emailAddressTextField.text!, password: passwordTextField.text!) { (user, error) in
            
            if error != nil {
                print(error!)
            }
            else {
                Auth.auth().currentUser?.sendEmailVerification(completion: { (error) in
                    print("We've just sent you an email.")
                    self.showMessage(messageToDisplay: "Please check your email for a link that will verify your account.")
                })
                
                //After sending verification email, the user is redirected to Login View Controller page. Thanks to Taiwosam on S.O. for the coherent explanation on using a soryboard ID.
                
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                self.present(vc, animated: true, completion: nil)
                
                //This dismisses the spinning icon that lets user know shit is being processed.
                
            SVProgressHUD.dismiss()
            
                //This action sends the user to the distribution view controller. You have to put the "self" in front of segue because the action is located in a "closure." The closure changes the scope of the action.
                
                //self.performSegue(withIdentifier: "goToDistributionViewController", sender: self)
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
