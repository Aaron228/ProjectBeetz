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

class EnrollmentViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    //Creates an instance of the database that customer info is sent to when the enrollment button is pressed.
    
    let db = Firestore.firestore()
    
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
        
        //Delegates allow calling keyboard dismissal functions.
        
        lastNameTextField.delegate = self
        customerIDTextField.delegate = self
        householdSizeTextField.delegate = self
        zipCodeTextField.delegate = self
        
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
    
    // Dismisses the keyboards when user clicks outside of the text fields.
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lastNameTextField.resignFirstResponder();
        customerIDTextField.resignFirstResponder();
        householdSizeTextField.resignFirstResponder();
        zipCodeTextField.resignFirstResponder()
    }
    
    //Dismisses the keyboards when user hits return on text field keyboard.
    
 
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        lastNameTextField.resignFirstResponder();
        customerIDTextField.resignFirstResponder();
        householdSizeTextField.resignFirstResponder();
        zipCodeTextField.resignFirstResponder()
        return true
    }
    
    // Creates the picker views.

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
        
        if lastNameTextField.text != nil && lastNameTextField.text != "",
           needIndicatorTextField.text != nil && needIndicatorTextField.text != "",
           customerIDTextField.text!.count < 7 && customerIDTextField.text != nil,
           marketNameTextField.text != nil && marketNameTextField.text != ""
        {
            
        var ref: DocumentReference? = nil
        
        ref = db.collection(CUSTOMERS_REF).addDocument(data: [
            LAST_NAME : lastNameTextField.text!,
            NEED_INDICATOR : needIndicatorTextField.text!,
            CUSTOMER_ID : customerIDTextField.text!,
            PRIMARY_LANGUAGE : primaryLanguageTextField.text!,
            MARKET_NAME : marketNameTextField.text!,
            HOUSEHOLD_SIZE : householdSizeTextField.text!,
            DATE_ENROLLED :  FieldValue.serverTimestamp(),
            ZIP_CODE : zipCodeTextField.text!
            ])
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
            
                            print("Document added with ID: \(ref!.documentID)")
        }
        else if lastNameTextField.text == nil || lastNameTextField.text! == "" {
                print("Last name field is required.")
        }
        else if needIndicatorTextField.text == nil || needIndicatorTextField.text! == "" {
                print("Please select a need indicator.")
            }
        else if customerIDTextField.text == nil || customerIDTextField.text!.count > 7 {
                print("Please provide a customer ID up to 6 digits long.")
        }
        else if marketNameTextField.text == nil || marketNameTextField.text! == "" {
                print("Please select a market name.")
        }
        else {
            print("Something has gone horribly wrong!")
        }
        }

//        ]) { (err) in
//            if let err = err {
//                print("Error adding document: \(err)")
//            } else {
//                let alert = UIAlertController(title: "Customer Created!!", message: "Would you like to make a DISTRIBUTION? Or, create another CUSTOMER?", preferredStyle: .alert)
//
//                let distributeAction = UIAlertAction(title: "Distribute", style: .default, handler: { (UIAlertAction) in
//                    self.goToDistributePage()
//                })
//
//                let enrollAgainAction = UIAlertAction(title: "Enrollment", style: .default
//                    , handler: { (UIAlertAction) in
//                        self.createAnotherCustomer()
//                })
//
//                alert.addAction(distributeAction)
//                alert.addAction(enrollAgainAction)
//
//                self.present(alert, animated: true, completion: nil)
//
//                print("Document added with ID: \(ref!.documentID)")
//            }
//        }
//    }
//    }
//
    func goToDistributePage() {

        self.performSegue(withIdentifier: "goToDistributionViewController", sender: self)

    }

    func createAnotherCustomer() {

        self.performSegue(withIdentifier: "goToDistributionViewController" , sender: self)
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
    
    //This button log the user out, or throws an error if it can't.
    
    @IBAction func logoutButtonPressed(_ sender: UIBarButtonItem) {
        
        do {
            try Auth.auth().signOut()
            
            let welcomePage = self.storyboard?.instantiateViewController(withIdentifier: "WelcomeViewController") as! WelcomeViewController
            
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
    
    func checkFirstName(name: String) {
        
        let name: String? = lastNameTextField.text
        guard let temp = name, temp.count < 2 else {
            showMessage(messageToDisplay: "That is too many letters.")
            return
        }
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
