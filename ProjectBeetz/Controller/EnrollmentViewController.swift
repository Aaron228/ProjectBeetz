//
//  EnrollmentViewController.swift
//  ProjectBeetz
//
//  Created by Aaron Lee on 2/21/19.
//  Copyright © 2019 Aaron Lee. All rights reserved.
//

//Thanks to Peter Witham for the guidance on setting up the pickers. //peterwitham.com/swift-archives/how-to-use-a-uipickerview-as-input-for-a-uitextfield/

import UIKit
import Firebase
import SVProgressHUD
import ChameleonFramework

class EnrollmentViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let needIndicatorArray = [String](arrayLiteral: "EBT", "WIC", "Veggie Rx")
    
    let languagePickerArray = [String](arrayLiteral: "English", "Chinese", "Japanese")
    
    let marketPickerArray = [String](arrayLiteral: "Sunnyvale", "Downtown Market", "Midvale")
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return languagePickerArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return languagePickerArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(row)
    }
    
    //Outlets
    
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var customerIDTextField: UITextField!
    @IBOutlet weak var needIndicatorTextField: UITextField!
    @IBOutlet weak var marketNameTextField: UITextField!
    @IBOutlet weak var primaryLanguageTextField: UITextField!
    @IBOutlet weak var householdSizeTextField: UITextField!
    @IBOutlet weak var zipCodeTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        //UI Picker constants
        
        let languagePicker = UIPickerView()
       // let marketNamePicker = UIPickerView()
       // let needIndicatorPicker = UIPickerView()
        
        primaryLanguageTextField.inputView = languagePicker
        
        languagePicker.delegate = self
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
