//
//  ViewController.swift
//  FoodTracker
//
//  Created by Art Williamson on 2/25/19.
//  Copyright © 2019 Art Williamson. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate,
    UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var mealNameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //handle the text field's user input through deleagates
        nameTextField.delegate = self
    }

    //MARK: UITextField Delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //hide teh keyboard
        textField.resignFirstResponder()
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        mealNameLabel.text = textField.text
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //the user tapped cancel so dismiss the controller
        dismiss(animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image but was provided: \(info)")
        }

        //set the imageView to the selected photo
        photoImageView.image = selectedImage

        //now dismiss the picker view
        dismiss(animated: true, completion: nil)
    }

    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        //Hide the keyboard
        nameTextField.resignFirstResponder()

        //UIImagePicker is a view controller for allowing users to select media from their photo library
        let imagePickerController = UIImagePickerController()

        //only want to add phots from library at this point
        imagePickerController.sourceType = .photoLibrary

        //make sure the view controller knows when user picks an image
        imagePickerController.delegate = self

        //display the imagepicker controller
        present(imagePickerController, animated: true, completion: nil)
    }
}

