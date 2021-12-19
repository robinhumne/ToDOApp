//
//  Extension.swift
//  ToDoApp
//
//  Created by pikateck on 20/12/21.
//

import Foundation
import UIKit

extension UITextField {

    
    func addDoneToolbar(onDone: (target: Any, action: Selector)? = nil, onCancel: (target: Any, action: Selector)? = nil) {
        let onDone = onDone ?? (target: self, action: #selector(doneButtonTapped))
        
        let toolbar: UIToolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Done", style: .done, target: onDone.target, action: onDone.action)
        ]
        toolbar.sizeToFit()
        
        self.inputAccessoryView = toolbar
    }
    
    @objc func doneButtonTapped() {
         DispatchQueue.main.async(execute: {
            self.resignFirstResponder()
        })
    }
        
    //MARK:- Set Image on the right of text fields

      func setupRightImage(imageName:String){
        let imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 20, height: 20))
        imageView.image = UIImage(named: imageName)
        let imageContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageContainerView.addSubview(imageView)
        rightView = imageContainerView
        rightViewMode = .always
        self.tintColor = .lightGray
    }

  }

extension UITextView {


func addDoneToolbar(onDone: (target: Any, action: Selector)? = nil, onCancel: (target: Any, action: Selector)? = nil) {
    let onDone = onDone ?? (target: self, action: #selector(doneButtonTapped))
    
    let toolbar: UIToolbar = UIToolbar()
    toolbar.barStyle = .default
    toolbar.items = [
        UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
        UIBarButtonItem(title: "Done", style: .done, target: onDone.target, action: onDone.action)
    ]
    toolbar.sizeToFit()
    
    self.inputAccessoryView = toolbar
}

@objc func doneButtonTapped() {
    self.resignFirstResponder()
}
}

extension String
{
    func toDate( dateFormat format  : String) -> Date?
       {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = format
           dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
           
           return dateFormatter.date(from: self)
       }
}

extension Date
{
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        //dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        return dateFormatter.string(from: self)
    }
      
    var edMMMyyyhmma:String {
        get{
            let dateFormater = DateFormatter()
            dateFormater.dateFormat = DATE_FORMATE_EEEDDMMMYYYY
            return dateFormater.string(from: self)
        }
    }
    
}
