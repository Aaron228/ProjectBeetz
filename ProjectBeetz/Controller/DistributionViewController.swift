//
//  DistributionViewController.swift
//  ProjectBeetz
//
//  Created by Aaron Lee on 2/21/19.
//  Copyright © 2019 Aaron Lee. All rights reserved.
//

// Thanks to MA Central for guidance on dismissing keyboards. //duckduckgo.com/?q=how+do+i+get+keyboard+to+disappear+xcode&atb=v92-1_f&iax=videos&ia=videos&iai=gUyaHCe3l7g

import UIKit
import Firebase
import SVProgressHUD

class DistributionViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var customerIDTextField: UITextField!
    @IBOutlet weak var availableMatchLabel: UILabel!
    @IBOutlet weak var matchAmountAvailableTextField: UITextField!
    @IBOutlet weak var customerRequestField: UITextField!
    @IBOutlet weak var customerOwesTextField: UITextField!
    
    
    //var titleView: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
     lastNameTextField.delegate = self
     customerIDTextField.delegate = self
     matchAmountAvailableTextField.text = "10"
    
    }
    
    //Thanks PhysicsFrac for the guidance. Youtube. //www.youtube.com/watch?v=bkjYqy-Inro
    
    @IBAction func makeDistributionButton(_ sender: UIButton){
        
        checkLengthCustomerID(id: customerIDTextField.text)

    }
    
    //Checks the length of the Customer ID to verify the entry is more than 0 characters and less than 4 characters.
    
    func checkLengthCustomerID(id: String?) {
        
        guard let tempID = customerIDTextField.text, tempID.count > 0 && tempID.count < 5 else {
            showMessage(messageToDisplay: "Enter a customer ID between 1 and 4 characters.")
            return
        }
    }
    
    func checkLengthLastInitial(lastInitial: String?) {
        
        guard let tempInit = lastNameTextField.text, tempInit.count == 1 else {
            showMessage(messageToDisplay: "The last initial field can only have one letter.")
            return
        }
    }
    
    
    func calculateWhatCustomerOwes(_ sender: Any) {
        
        if Int(matchAmountAvailableTextField.text!)! <= 10 && Int(matchAmountAvailableTextField.text!)! >= 0,
            Int(customerRequestField.text!)! > 0 && Int(customerRequestField.text!)! < 500
            {
            
            let a = Int(customerRequestField.text!)
            let b = Int(matchAmountAvailableTextField.text!)
            
            customerOwesTextField.text = "\(a! - b!)"
                
        }
        else {
            showMessage(messageToDisplay: "That number is broke. Need a better number.")
        }
    }
            
    
    //Dismisses the keyboards when clicking outside of the text fields
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        lastNameTextField.resignFirstResponder();
        customerIDTextField.resignFirstResponder()
    }
    
    //Dismisses the keyboards when hitting return on the keyboard
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        lastNameTextField.resignFirstResponder();
        customerIDTextField.resignFirstResponder()
        return true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func erollmentButtonPressed(_ sender: UIButton) {
        
       // DATE_DISTRIBUTED :  FieldValue.serverTimestamp()
        
        performSegue(withIdentifier: "EnrollmentViewController", sender: self)
    }
    
   
    @IBAction func logoutButtonPressed(_ sender: UIBarButtonItem) {
    
        do {
            try Auth.auth().signOut()
            
            let welcomePage = self.storyboard?.instantiateViewController(withIdentifier: "UINavigationController") as! UINavigationController
            
            let appDelegate = UIApplication.shared.delegate
            appDelegate?.window??.rootViewController = welcomePage
            
        }
        catch {
            self.showMessage(messageToDisplay: "Not able to sign out at this time.")
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
