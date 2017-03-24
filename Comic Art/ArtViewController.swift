//
//  ArtViewController.swift
//  Comic Art
//
//  Created by Michael Zielinski on 3/23/17.
//  Copyright © 2017 Worldengine. All rights reserved.
//

import UIKit

//* update class for new delegates
class ArtViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    //* outlet for image
    @IBOutlet weak var artImage: UIImageView!
    
    //* outlet for text field
    @IBOutlet weak var titleTextField: UITextField!
    
    //* outlet to add update button
    @IBOutlet weak var addUpdateButton: UIButton!
    
    //* out let to delete button
    @IBOutlet weak var deleteButton: UIButton!
    
    //* set up imagePicker
    var imagePicker = UIImagePickerController()
    
    //* set up game object
    var art : Art? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //* set up image picker delegate
        imagePicker.delegate = self
        
        //* set up text field delegate
        titleTextField.delegate = self
        
        //* to dismiss keyboard
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ArtViewController.dismissKeyboard)))
        
        //* if navigating from game
        if art != nil {
            artImage.image = UIImage(data: art!.image as! Data)
            titleTextField.text = art!.title
            
            addUpdateButton.setTitle("Update", for: .normal)
        } else {
            deleteButton.isHidden = true
        }
    }
    
    //* disappear the keyboard when click anywhere
    func dismissKeyboard() {
        titleTextField.resignFirstResponder()
    }
    //* disappear the keyboard when done
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.titleTextField.resignFirstResponder()
        return true
    }
    
    //* action for photos button tapped
    @IBAction func photosTapped(_ sender: Any) {
        
        //* define the source for imagePicker
        imagePicker.sourceType = .photoLibrary
        
        //* present another view controller on the screen for photo library
        present(imagePicker, animated: true, completion: nil)
    }
    
    //* take the picked image and assign to artImage
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        artImage.image = image
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    
    //* action for camera icon tapped
    @IBAction func cameraTapped(_ sender: Any) {
        
        //* define the source for imagePicker
        imagePicker.sourceType = .camera
        
        //* present another view controller on the screen for photo library
        present(imagePicker, animated: true, completion: nil)
    }
    
    //* add/update button tapped
    @IBAction func addTapped(_ sender: Any) {
        
        //* if game is not nil, then save the info, else make new
        if art != nil {
            art!.title = titleTextField.text
            art!.image = UIImageJPEGRepresentation(artImage.image!, 1.0) as NSData!
        } else {
            
            
            //* set up context
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            let art = Art(context: context)
            art.title = titleTextField.text
            art.image = UIImageJPEGRepresentation(artImage.image!, 1.0) as NSData!
        }
        
        //* save the content
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        //* pop back the view
        navigationController!.popViewController(animated: true)
    }
    
    //* delete button tapped
    @IBAction func deleteTapped(_ sender: Any) {
        
        //* set up context and delete object
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(art!)
        
        //* save the content
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        //* pop back the view
        navigationController!.popViewController(animated: true)
    }
    
    
}
