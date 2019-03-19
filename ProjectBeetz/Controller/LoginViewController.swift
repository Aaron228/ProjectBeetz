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
        
        //Guard statements are what check the textfields to make sure they contain something.
        
        guard let userEmail = emailAddressTextField.text, !userEmail.isEmpty else {
            self.showMessage(messageToDisplay: "Not so fast. You're gonna need put in an email address.")
            return
        }
        
        guard let userPassword = passwordTextField.text, !userPassword.isEmpty else {
            self.showMessage(messageToDisplay: "Whoa Nellie! Somebody forgot to enter a password.")
            return
        }
        
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
    
    //Takes user to the Register VC using the Register VC's storyboard ID.
        
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        present(vc, animated: true, completion: nil)
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
    
    
    @IBAction func leaveCommentButtonPressed(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "FeedbackViewController") as! FeedbackViewController
        present(vc, animated: true, completion: nil)
        
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

