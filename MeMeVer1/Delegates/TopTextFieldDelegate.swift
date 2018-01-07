//
//  TopTextFieldDelegate.swift
//  MeMeVer1
//
//  Created by Rajeev Ranganathan on 07/01/18.
//  Copyright © 2018 Rajeev Ranganathan. All rights reserved.
//

import Foundation
import UIKit

class TopTextFieldDelegate:NSObject,UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let text = textField.text
        if text == "TOP"{
            textField.text = ""
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        let text = textField.text! as NSString
        if text == ""{
            textField.text = "TOP"
        }
    }
}

