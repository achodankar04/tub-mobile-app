//
//  EnterCompetitionVC.swift
//  TheUltimateBuzz
//
//  Created by Sagar C on 09/08/20.
//  Copyright © 2020 Ticron. All rights reserved.
//

import UIKit

class EnterCompetitionVC: UIViewController, UITextFieldDelegate{
    
    @IBOutlet var navigationBarHeight: NSLayoutConstraint!
    @IBOutlet var backScrollView: UIScrollView!
    @IBOutlet var nameTextFieldObj: UITextField!
    @IBOutlet var emailTextFieldObj: UITextField!
    @IBOutlet var userNameTxtFieldObj: UITextField!
    @IBOutlet var phoneTxtFieldObj: UITextField!
    @IBOutlet var dobTxtFieldObj: UITextField!
    @IBOutlet var nationalityTxtFieldObj: UITextField!
    @IBOutlet var visaTxtFieldObj: UITextField!
    @IBOutlet var categoryTxtFieldObj: UITextField!
    @IBOutlet var competitionFormTbleViewObj: UITableView!
    @IBOutlet var topNavigationBar: BuzzNavigationBar!
    
    var birthdatePicker: UIDatePicker!
    var nationalityPicker: UIPickerView!
    var visaPicker: UIPickerView!
    var categoryPicker: UIPickerView!
    
    let visaArray = ["Authorized", "Not Authorized"]
    let categoryArray = ["Acting","Comedy","Dance","Magic","Music","Sport","Cooking","Crafting"]
    var nationalityArray : [String] = []
    
    var datePickerViewObj : UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initialiseTopBar()
        intialiseTextFields()
        initialiseBirthdayPicker()
        initialiseNationalityPicker()
        initialiseVisaPicker()
        initialiseCategoryPicker()
        addDoneButtonOnKeyboard()
        
        backScrollView.frame = CGRect(x: 0, y: 119, width: 375, height: 693)
        backScrollView.contentSize = CGSize(width: 400, height: 2300)
        

        for code in NSLocale.isoCountryCodes  {
            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
            let name = NSLocale(localeIdentifier: "en_UK").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found for code: \(code)"
            nationalityArray.append(name)
        }
    }

    // MARK: - User Defined methods
    
    fileprivate func initialiseTopBar(){
       topNavigationBar.titleLable.text = "Enter Competition"
       topNavigationBar.leftImgView.isHidden = true
        if self.topNavigationBar.hasTopNotch {
            self.navigationBarHeight.constant = 120
        }
        else {
            self.navigationBarHeight.constant = 90
        }
    }

    fileprivate func intialiseTextFields(){
        let paddingView: UIView = UIView(frame: CGRect(x: 10, y: 0, width: 10, height: 0))
        self.nameTextFieldObj.leftView = paddingView
        self.emailTextFieldObj.leftView = paddingView
        self.userNameTxtFieldObj.leftView = paddingView
        self.phoneTxtFieldObj.leftView = paddingView
    }
    
    fileprivate func initialiseBirthdayPicker(){
        let screen = UIScreen.main.applicationFrame
        
        birthdatePicker = UIDatePicker(frame: CGRect(x: 0, y: screen.size.height-300, width: screen.size.width, height: 300))
        birthdatePicker.datePickerMode = UIDatePicker.Mode.date
        birthdatePicker.backgroundColor = .white

        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black
        toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.doneClick))

        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.donePicker))

        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true

        dobTxtFieldObj.inputView = birthdatePicker
        dobTxtFieldObj.inputAccessoryView = toolBar
    }
    
    fileprivate func initialiseNationalityPicker(){
        let screen = UIScreen.main.applicationFrame
            
        nationalityPicker = UIPickerView(frame: CGRect(x: 0, y: screen.size.height-300, width: screen.size.width, height: 300))
        nationalityPicker.backgroundColor = .white

        nationalityPicker.delegate = self
        nationalityPicker.dataSource = self

        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black
        toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.donePicker))

        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        nationalityTxtFieldObj.inputView = nationalityPicker
        nationalityTxtFieldObj.inputAccessoryView = toolBar
    }
    
    fileprivate func initialiseVisaPicker(){
        let screen = UIScreen.main.applicationFrame
            
        visaPicker = UIPickerView(frame: CGRect(x: 0, y: screen.size.height-300, width: screen.size.width, height: 300))
        visaPicker.backgroundColor = .white

        visaPicker.delegate = self
        visaPicker.dataSource = self

        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black
        toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.donePicker))

        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        visaTxtFieldObj.inputView = visaPicker
        visaTxtFieldObj.inputAccessoryView = toolBar
    }
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()

        self.phoneTxtFieldObj.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction()
    {
        phoneTxtFieldObj.resignFirstResponder()
        self.resignFirstResponder()
    }
    
    fileprivate func initialiseCategoryPicker(){
        let screen = UIScreen.main.applicationFrame
            
        categoryPicker = UIPickerView(frame: CGRect(x: 0, y: screen.size.height-300, width: screen.size.width, height: 300))
        categoryPicker.backgroundColor = .white

        categoryPicker.delegate = self
        categoryPicker.dataSource = self

        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black
        toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.donePicker))

        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        categoryTxtFieldObj.inputView = categoryPicker
        categoryTxtFieldObj.inputAccessoryView = toolBar
    }
    
    @objc func doneClick() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dobTxtFieldObj.text = dateFormatter.string(from: birthdatePicker.date)
        dobTxtFieldObj.resignFirstResponder()
    }
    
    @objc func donePicker(){
        dobTxtFieldObj.resignFirstResponder()
        nationalityTxtFieldObj.resignFirstResponder()
        visaTxtFieldObj.resignFirstResponder()
        categoryTxtFieldObj.resignFirstResponder()
    }
    
    @IBAction func submitBtnClicked(_ sender: Any) {
        if(emailTextFieldObj.text == "" || nameTextFieldObj.text == "" || userNameTxtFieldObj.text == "" || phoneTxtFieldObj.text == "" || dobTxtFieldObj.text == "" || nationalityTxtFieldObj.text == "" || visaTxtFieldObj.text == "" || categoryTxtFieldObj.text == ""){
            //Enter email
            AlertControllerUtility.shared.showAlert(title: "", message: "Please enter all fields", cancelButtonTitle: "OK")
        }else{
            AlertControllerUtility.shared.showAlertSingleButton(title: "", message: "You Have successfully entered The Ultimate Buzz. We will reach out to you through emails with the next step.", actions: ([UIAlertAction(title: "OK", style: .default, handler:{ (action: UIAlertAction!) in
                self.saveForCompetition(email: self.emailTextFieldObj.text!)
                self.navigationController?.popViewController(animated: true)
            } )]))
        }
    }
    
    func saveForCompetition(email: String){
        print(email)
        UserDefaultsData.shared.saveIntoDefault(key: "isEnteredCompetition", value: email)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

extension EnterCompetitionVC : UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == visaPicker {
            return visaArray.count
        }else if pickerView == categoryPicker{
            return categoryArray.count
        }else if pickerView == nationalityPicker{
            return nationalityArray.count
        }else{
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == visaPicker {
            return visaArray[row]
        }else if pickerView == categoryPicker{
            return categoryArray[row]
        }else if pickerView == nationalityPicker{
            return nationalityArray[row]
        }else{
            return "demo"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if visaTxtFieldObj.isFirstResponder{
            let itemselected = visaArray[row]
            visaTxtFieldObj.text = itemselected
        }else if categoryTxtFieldObj.isFirstResponder{
            let itemselected = categoryArray[row]
            categoryTxtFieldObj.text = itemselected
        }else if nationalityTxtFieldObj.isFirstResponder{
            let itemselected = nationalityArray[row]
            nationalityTxtFieldObj.text = itemselected
        }
    }
}


