//
//  BottomTextFieldDelegate.swift
//  MeMeVer1
//
//  Created by Rajeev Ranganathan on 07/01/18.
//  Copyright © 2018 Rajeev Ranganathan. All rights reserved.
//

import Foundation
import UIKit
class BottomTextFieldDelegate:NSObject,UITextFieldDelegate{
    private let keyboardProtocolIdentifier:KeyboardProtocol?
    private var isKeyBoardShowing = false
    init(keyboardProtocolIdentifierInstance:KeyboardProtocol) {
        self.keyboardProtocolIdentifier = keyboardProtocolIdentifierInstance
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        subscribeToKBNotification()
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let text = textField.text
        if !(text?.isEmpty)! && text=="BOTTOM"{
            textField.text=""
        }
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        let text = textField.text! as NSString
        if text == ""{
            textField.text = "BOTTOM"
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func subscribeToKBNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name:.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide(_:)), name:.UIKeyboardDidHide, object: nil)
    }
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardDidHide, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
        if isKeyBoardShowing == false{
            keyboardProtocolIdentifier?.liftView(notification)
            isKeyBoardShowing = true
        }
    }
    
    @objc func keyBoardWillHide(_ notification:Notification){
        if isKeyBoardShowing == true{
            keyboardProtocolIdentifier?.deLiftView(notification)
            isKeyBoardShowing = false
        }
        unsubscribeFromKeyboardNotifications()
    }
}
