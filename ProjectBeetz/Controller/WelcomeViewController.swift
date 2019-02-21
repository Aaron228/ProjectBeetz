//
//  WelcomeViewController.swift
//  ProjectBeetz
//
//  Created by Aaron Lee on 2/21/19.
//  Copyright © 2019 Aaron Lee. All rights reserved.
//

import UIKit
import Firebase
import ChameleonFramework

class WelcomeViewController: UIViewController {

    @IBAction func loginButtonPressed(_ sender: UIButton) {
        
        performSegue(withIdentifier: "goToLoginViewController", sender: self)
    }
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "goToRegisterViewController", sender: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    


}

