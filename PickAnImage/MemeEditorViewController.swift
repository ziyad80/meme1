//
//  MemeEditorViewController.swift
//  PickAnImage
//
//  Created by Ziyad Alsaeed on 9/24/19.
//  Copyright © 2019 Ziyad Alsaeed. All rights reserved.
//


import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate,UITextFieldDelegate, UINavigationControllerDelegate {
    
//    struct Meme {
//        var topText : String
//        var bottomText: String
//        var originalImage: UIImage
//        var memedImage : UIImage
//
//    }
    func save (){
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: imagePickerView.image!, memedImage: generateMemedImage())
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
        
    }
    
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor.black,
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key.strokeWidth: -2.0]
    
    
   
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    
    @IBOutlet weak var imagePickerView: UIImageView!
    
    @IBOutlet weak var topToolbar: UIToolbar!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var camera: UIBarButtonItem!
    
    func configureTextField(textField: UITextField, defaultText: String)
    {
        textField.delegate = self
        
        textField.defaultTextAttributes = memeTextAttributes
        
        textField.textAlignment = NSTextAlignment.center
        
        textField.text = defaultText
    }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextField(textField: topTextField, defaultText: "TOP")
        configureTextField(textField: bottomTextField, defaultText: "BOTTOM")
       
        
        
        
        // Do any additional setup after loading the view.
        self.shareButton.isEnabled = false
        self.camera.isEnabled = false
    }
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }

   // Pick an Image from Photo Library
    
    func openImagePicker(type: UIImagePickerController.SourceType){
       
        
            
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            pickerController.allowsEditing = true
            pickerController.sourceType = type
            present(pickerController, animated: true, completion: nil)
        
       
    }
    
    @IBAction func pickAnImage(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
        openImagePicker(type: .photoLibrary)
        }

    }
    
    // Take an Image from the camera
    @IBAction func takeAnImage(_ sender: Any) {
       
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            self.camera.isEnabled = true
            
        openImagePicker(type: .camera)
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            imagePickerView.image = editedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            imagePickerView.image = originalImage
        }
        dismiss(animated: true, completion: nil)
        self.shareButton.isEnabled = true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    // Get the Keyboard Height
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    @objc func keyboardWillShow(_ notification:Notification)
    {
        if bottomTextField.isEditing
        {
             view.frame.origin.y -= getKeyboardHeight(notification)
        }
       
    }
    @objc func keyboardWillHide(_ notification:Notification) {
        
        view.frame.origin.y = 0
    }
    
    
   
    // Create the meme
    func generateMemedImage() -> UIImage {
        self.bottomToolbar.isHidden = true
        self.topToolbar.isHidden = true
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        self.bottomToolbar.isHidden = false
        self.topToolbar.isHidden = false
        
        return memedImage
    }
        
   
    
    
    @IBAction func share(_ sender: Any) {

        print("share bottom press")
        let activityViewControlle = UIActivityViewController(activityItems: [generateMemedImage()], applicationActivities: nil)
        self.present(activityViewControlle, animated: true, completion: nil)
        activityViewControlle.completionWithItemsHandler = {(activity, completed, items, error) in
            if (completed){
              
                self.save()
            }
            
            //Dismiss the shareActivityViewController
            self.dismiss(animated: true, completion: nil)
        }
    }
    @IBAction func cancelion(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        

    }
    

    
}

