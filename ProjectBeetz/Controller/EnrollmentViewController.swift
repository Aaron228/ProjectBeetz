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

class EnrollmentViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextViewDelegate {
    
    var currentTextField = UITextField()
    var pickerView = UIPickerView()
    
    var needIndicatorArray: [String] = []
    
    var languagePickerArray: [String] = []
    
    var marketPickerArray: [String] = []
    
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var customerIDTextField: UITextField!
    @IBOutlet weak var needIndicatorTextField: UITextField!
    @IBOutlet weak var marketNameTextField: UITextField!
    @IBOutlet weak var primaryLanguageTextField: UITextField!
    @IBOutlet weak var householdSizeTextField: UITextField!
    @IBOutlet weak var zipCodeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        needIndicatorArray = ["EBT", "WIC", "Veggie Rx"]
        
        languagePickerArray = ["English", "Chinese", "Japanese"]
        
        marketPickerArray = ["Sunnyvale", "Downtown Market", "Midvale"]
        
        //UI Picker constants
        
        //let languagePicker = UIPickerView()
        // let marketNamePicker = UIPickerView()
        // let needIndicatorPicker = UIPickerView()
        
        //        primaryLanguageTextField.inputView = languagePicker
        //
        //        languagePicker.delegate = self
        
    }
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if currentTextField == marketNameTextField {
            return marketPickerArray.count
        }
        else if currentTextField == primaryLanguageTextField {
            return languagePickerArray.count
        }
        else if currentTextField == needIndicatorTextField {
            return needIndicatorArray.count
        }
        else {
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if currentTextField == marketNameTextField {
            return marketPickerArray[row]
        }
        else if currentTextField == primaryLanguageTextField {
            return languagePickerArray[row]
        }
        else if currentTextField == needIndicatorTextField {
            return needIndicatorArray[row]
        }
        else {
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if currentTextField == marketNameTextField {
            marketNameTextField.text = marketPickerArray[row]
            self.view.endEditing(true)
        }
        else if currentTextField == primaryLanguageTextField {
            primaryLanguageTextField.text = languagePickerArray[row]
            self.view.endEditing(true)
        }
        else if currentTextField == needIndicatorTextField {
            needIndicatorTextField.text = needIndicatorArray[row]
            self.view.endEditing(true)
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
    currentTextField = textField
        if currentTextField == marketNameTextField {
            currentTextField.inputView = pickerView
        }
        else if currentTextField == primaryLanguageTextField {
            currentTextField.inputView = pickerView
        }
        else if currentTextField == needIndicatorTextField {
            currentTextField.inputView = pickerView
        }
    }
    
    //Outlets
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
