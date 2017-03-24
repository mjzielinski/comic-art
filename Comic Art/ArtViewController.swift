//
//  ArtViewController.swift
//  Comic Art
//
//  Created by Michael Zielinski on 3/23/17.
//  Copyright © 2017 Worldengine. All rights reserved.
//

import UIKit

//* update class for new delegates
class ArtViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //* outlet for image
    @IBOutlet weak var artImage: UIImageView!
    
    //* outlet for text field
    @IBOutlet weak var titleTextField: UITextField!
    
    //* set up imagePicker
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //* set up image picker delegate
        imagePicker.delegate = self
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
    }
    
    //* add button tapped
    @IBAction func addTapped(_ sender: Any) {
        //* set up context
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let art = Art(context: context)
        art.title = titleTextField.text
        art.image = UIImagePNGRepresentation(artImage.image!) as NSData!
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }

}
