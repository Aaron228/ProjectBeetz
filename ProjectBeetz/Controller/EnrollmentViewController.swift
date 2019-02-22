//
//  EnrollmentViewController.swift
//  ProjectBeetz
//
//  Created by Aaron Lee on 2/21/19.
//  Copyright © 2019 Aaron Lee. All rights reserved.
//

//Thanks to Peter Witham and "Start learn2Code" (on YouTube) for the guidance on setting up the pickers. //peterwitham.com/swift-archives/how-to-use-a-uipickerview-as-input-for-a-uitextfield/ 

import UIKit
import Firebase
import SVProgressHUD
import ChameleonFramework

class EnrollmentViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
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
    
    //Enroll button sends customer info to FireStore database and sets the state to the Distribute VC.
    
    
    @IBAction func enrollButtonPressed(_ sender: UIButton) {

        Firestore.firestore().collection(CUSTOMERS_REF).addDocument(data: [
            LAST_NAME : lastNameTextField.text!,
            NEED_INDICATOR : needIndicatorTextField.text!,
            CUSTOMER_ID : customerIDTextField.text!,
            PRIMARY_LANGUAGE : primaryLanguageTextField.text!,
            MARKET_NAME : marketNameTextField.text!,
            HOUSEHOLD_SIZE : householdSizeTextField.text!,
            //DATE_ENROLLED :  FieldValue.serverTimestamp(),
            ZIP_CODE : zipCodeTextField.text!

        ]) { (err) in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                let alert = UIAlertController(title: "Customer Created!!", message: "Would you like to make a DISTRIBUTION? Or, create another CUSTOMER?", preferredStyle: .alert)

                let distributeAction = UIAlertAction(title: "Distribute", style: .default, handler: { (UIAlertAction) in
                    self.goToDistributePage()
                })

                let enrollAgainAction = UIAlertAction(title: "Enrollment", style: .default
                    , handler: { (UIAlertAction) in
                        self.createAnotherCustomer()
                })

                alert.addAction(distributeAction)
                alert.addAction(enrollAgainAction)

                self.present(alert, animated: true, completion: nil)

                //self.performSegue(withIdentifier: "makeADistribution", sender: self)
            }
        }
    }

    func goToDistributePage() {

        self.performSegue(withIdentifier: "goToDistributionViewController", sender: self)

    }

    func createAnotherCustomer() {

        self.performSegue(withIdentifier: "doToDistributionViewController" , sender: self)
    }
    
    // Add items buttons along the right hand side of the Enrollment view controller. Thanks Angela Yu.
        
    @IBAction func needIndicatorAddButtonPressed(_ sender: UIButton) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add Need Indicator", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once the user hits the add item on the UIAlert
        self.needIndicatorArray.append(textField.text!)
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        }
        
        
    @IBAction func marketNameAddButtonPressed(_ sender: UIButton) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add Market Name", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once the user hits the add item on the UIAlert
            self.marketPickerArray.append(textField.text!)
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    
    @IBAction func primaryLanguageAddButtonPressed(_ sender: UIButton) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add Primary Language", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once the user hits the add item on the UIAlert
            self.languagePickerArray.append(textField.text!)
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
        
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
