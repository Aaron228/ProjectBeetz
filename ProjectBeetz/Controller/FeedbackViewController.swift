//
//  FeedbackViewController.swift
//  ProjectBeetz
//
//  Created by Aaron Lee on 3/19/19.
//  Copyright © 2019 Aaron Lee. All rights reserved.
//

import UIKit
import MessageUI

class FeedbackViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var commentTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


    @IBAction func sendButtonPressed(_ sender: AnyObject) {
        
        let toRecipients = ["intp81@gmail.com"]
        
        let mc: MFMailComposeViewController = MFMailComposeViewController()
        
        mc.mailComposeDelegate = self
        
        mc.setToRecipients(toRecipients)
        mc.setSubject(nameTextField.text!)
        
        mc.setMessageBody("Name: \(nameTextField.text!) \n\nEmail: \(emailTextField.text!) \n\nMessage: \(commentTextField.text!)", isHTML: false)
        
        self.present(mc, animated: true, completion: nil)
        
    }

    
    
}
