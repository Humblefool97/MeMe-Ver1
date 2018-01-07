//
//  MemeViewController.swift
//  MeMeVer1
//
//  Created by Rajeev Ranganathan on 06/01/18.
//  Copyright © 2018 Rajeev Ranganathan. All rights reserved.
//

import UIKit

class MemeViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,KeyboardProtocol {
    
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    var topTextFieldDelegate:TopTextFieldDelegate!
    var bottomTextFieldDelegate:BottomTextFieldDelegate!
    
    let memeTextAttributes:[String:Any] = [
        NSAttributedStringKey.strokeColor.rawValue:UIColor.clear,
        NSAttributedStringKey.foregroundColor.rawValue:UIColor.white,
        NSAttributedStringKey.font.rawValue: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedStringKey.strokeWidth.rawValue:-3.0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        topTextFieldDelegate = TopTextFieldDelegate()
        bottomTextFieldDelegate = BottomTextFieldDelegate(keyboardProtocolIdentifierInstance: self as KeyboardProtocol)
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
        topTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.defaultTextAttributes = memeTextAttributes
        topTextField.textAlignment = .center
        bottomTextField.textAlignment = .center
        topTextField.delegate = topTextFieldDelegate
        bottomTextField.delegate = bottomTextFieldDelegate
    }
    
    @IBAction func onPickClicked(_ sender: Any) {
        let uiImagePickerController = UIImagePickerController()
        uiImagePickerController.delegate = self
        present(uiImagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage{
            imageView.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func liftView(_ notification:Notification) {
        view.frame.origin.y -= getKeyboardHeight(notification)
    }
    
    func deLiftView(_ notification:Notification) {
        view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    @IBAction func onCameraClick(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
}

