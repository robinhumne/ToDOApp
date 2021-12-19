//
//  AddDetailsViewController.swift
//  ToDoApp
//
//  Created by pikateck on 20/12/21.
//

import UIKit

class AddDetailsViewController: UIViewController {

    // MARK: - IBOutlets
    //UITextField
    @IBOutlet var txt_title: UITextField!{
        didSet { txt_title?.addDoneToolbar() }}
    @IBOutlet var txt_desc: UITextView!{
        didSet { txt_desc?.addDoneToolbar() }}
    @IBOutlet var txt_time: UITextField!{
        didSet { txt_time?.addDoneToolbar() }}
    
    //UIButton
    @IBOutlet var btn_add: UIButton!
    
    let datePicker = UIDatePicker()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        txt_title.delegate = self
        txt_desc.delegate = self
        txt_time.delegate = self
        
        txt_desc.textColor = .darkGray
        
        showDatePicker()
    }
    
    
    // MARK: - Actions
    @IBAction func btn_add(_ sender: Any) {
        
        
        var parameters = [AnyHashable : Any]()
        
            
            parameters[EVENT_ID] = "101"
            parameters[EVENT_TITLE] = txt_title.text
            parameters[EVENT_DECS] = txt_desc.text == "Add Description" ? "" : txt_desc.text
            parameters[EVENT_TIME] = txt_time.text
            
            
            print(parameters)
        
        
            
            if let event = Event.add(event: parameters as [AnyHashable : Any]){
               print(event)
                CoreDataStack.shared.saveContext()
                
                goBack()
                
                NotificationCenter.default.post(name: Notification.Name("onDataInsertRefresh"), object: nil)
            }
           
        
        
        
    }
    
    
    // MARK: - Functions
    func showDatePicker() {
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        
        self.datePicker.datePickerMode = .dateAndTime
        self.datePicker.minimumDate = Date()
        
        if #available(iOS 13.4, *) {
            self.datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        
        
        let calendar = Calendar(identifier: .gregorian)
        var comps = DateComponents()
        comps.year = 1
        let maxDate = calendar.date(byAdding: comps, to: Date())
        
        self.datePicker.maximumDate = maxDate
        
        
        self.txt_time.inputAccessoryView = toolbar
        self.txt_time.inputView = self.datePicker
        self.txt_time.text = Date().edMMMyyyhmma
        self.txt_time.tintColor = .clear
    }
    
        @objc func donedatePicker() {
           
            self.txt_time.text = self.datePicker.date.edMMMyyyhmma
            self.view.endEditing(true)
        
       }
       
       @objc func cancelDatePicker(){
           self.view.endEditing(true)
       }
    
    // MARK: - Navigation
    /// Get ViewController screen instance from Storyboard
    ///
    /// - Returns: Instance of ViewController
    class func GetViewController()->AddDetailsViewController?{
        if let viewController = Storyboard.instantiateViewController(withIdentifier: "AddDetailsViewController") as? AddDetailsViewController{
            return viewController
        }
        return nil
    }
        
        
    /// Get refrence of Storyboard
    static var Storyboard: UIStoryboard {
        return UIStoryboard(name: STORYBOARD_MAIN, bundle: Bundle.main)
    }
    
    func goBack() -> Void {
        self.dismiss(animated: true, completion: nil)
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


extension AddDetailsViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == txt_title {
            
            
        }
        else if textField == txt_desc {
        
            
        } else if textField == txt_time {
            
            let currentDate = self.txt_time.text?.toDate(dateFormat: DATE_FORMATE_EEEDDMMMYYYY)
            datePicker.date = currentDate!
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
         
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        
        if textField == txt_time {
            return false
        }
        else
        {
            
        }
        
        

        return true
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


extension AddDetailsViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView == txt_desc {
           // textView.resignFirstResponder()
            
            
            if textView.textColor == .darkGray {
                textView.text = nil
                textView.textColor = UIColor.black
            }
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Add Description"
            textView.textColor = .darkGray
        }
        
        textView.resignFirstResponder()
        
    }
}
