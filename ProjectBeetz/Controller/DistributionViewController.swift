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
import ChameleonFramework

class DistributionViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var customerIDTextField: UITextField!
    @IBOutlet weak var customerMatchTextField: UITextField!
    
    
    //var titleView: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
     lastNameTextField.delegate = self
     customerIDTextField.delegate = self
    
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
        
        performSegue(withIdentifier: "goToEnrollmentViewController", sender: self)
    }
    
    @IBAction func logoutButtonPressed(_ sender: UIBarButtonItem) {
    }
    
    
    
}
