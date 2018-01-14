//
//  MemeViewController.swift
//  MeMeVer1
//
//  Created by Rajeev Ranganathan on 06/01/18.
//  Copyright © 2018 Rajeev Ranganathan. All rights reserved.
//

import UIKit

class MemeViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,KeyboardProtocol {
    //MARK:Member Variables
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    private var topTextFieldDelegate:TopTextFieldDelegate!
    private var bottomTextFieldDelegate:BottomTextFieldDelegate!
    private var memeInstance:Meme?
    @IBOutlet weak var navBar: UIToolbar!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    let memeTextAttributes:[String:Any] = [
        NSAttributedStringKey.strokeColor.rawValue:UIColor.black,
        NSAttributedStringKey.foregroundColor.rawValue:UIColor.white,
        NSAttributedStringKey.font.rawValue: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedStringKey.strokeWidth.rawValue:-3.0]
    
    //MARK:Member functions
    fileprivate func prepareDefaultText(textField: UITextField, defaultText: String) {
        textField.text = defaultText
    }
    
    fileprivate func initTextFields() {
        prepareDefaultText(textField: topTextField,defaultText: "TOP")
        prepareDefaultText(textField: bottomTextField,defaultText: "BOTTOM")
        topTextField.backgroundColor = UIColor.clear
        bottomTextField.backgroundColor = UIColor.clear
        topTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.defaultTextAttributes = memeTextAttributes
        topTextField.textAlignment = .center
        bottomTextField.textAlignment = .center
        topTextField.delegate = topTextFieldDelegate
        bottomTextField.delegate = bottomTextFieldDelegate
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        topTextFieldDelegate = TopTextFieldDelegate()
        bottomTextFieldDelegate = BottomTextFieldDelegate(keyboardProtocolIdentifierInstance: self as KeyboardProtocol)
        initTextFields()
        self.shareButton.isEnabled = false
        self.cancelButton.isEnabled = false
    }
    
    @IBAction func onAlbumClicked(_ sender: Any) {
        pick(sourceType: .photoLibrary)
    }
    
    @IBAction func onCameraClicked(_ sender: Any) {
        pick(sourceType: .camera)
    }
    
    func pick(sourceType:UIImagePickerControllerSourceType){
        let uiImagePickerController = UIImagePickerController()
        uiImagePickerController.delegate = self
        uiImagePickerController.sourceType = sourceType
        present(uiImagePickerController, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage{
            imageView.image = image
            self.shareButton.isEnabled = true
            self.cancelButton.isEnabled = true
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
    
    func save(){
        memeInstance = Meme(topText:topTextField.text!,bottomText:bottomTextField.text!,originalImage:imageView.image!,memedImage:generateMemedImage())
    }
    
    func generateMemedImage()-> UIImage{
        setView(view: self.toolBar, hidden: true)
        setView(view: self.navBar, hidden: true)
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawHierarchy(in:self.imageView.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        setView(view: self.toolBar, hidden: false)
        setView(view: self.navBar, hidden: false)
        
        return memedImage
    }
    
    @IBAction func onShare(_ sender: Any) {
        let image:UIImage = generateMemedImage()
        let controller = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        controller.completionWithItemsHandler = {(activity, completed, items, error) in
            if(completed){
                self.save()
            }
        }
        self.present(controller, animated: true, completion: nil)
    }
    @IBAction func onCancel(_ sender: Any) {
        if self.imageView.image != nil{
            self.imageView.image = nil
            self.imageView.setNeedsDisplay()
            initTextFields()
            self.shareButton.isEnabled = false
            self.cancelButton.isEnabled = false
        }
    }
    
    func setView(view: UIView, hidden: Bool) {
        view.isHidden = hidden
        
    }
    
}

