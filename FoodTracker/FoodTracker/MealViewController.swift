//
//  MealViewController.swift
//  FoodTracker
//
//  Created by Art Williamson on 2/25/19.
//  Copyright © 2019 Art Williamson. All rights reserved.
//

import UIKit
import os.log

class MealViewController: UIViewController, UITextFieldDelegate,
    UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var saveButton: UIBarButtonItem!

    
    /*
     This value is either passed by MealTableViewController in
     prepare(fir: sender)
     or constructedas part of adding anew meal
     */
    var meal: Meal?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //handle the text field's user input through deleagates
        nameTextField.delegate = self

        // Set up views if editing an existing Meal.
        if let meal = meal {
            navigationItem.title = meal.name
            nameTextField.text = meal.name
            photoImageView.image = meal.photo
            ratingControl.rating = meal.rating
        }
        
        //enable thesave button only if there is text in the text field
        updateSaveButtonState()
    }

    //MARK: UITextField Delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //hide teh keyboard
        textField.resignFirstResponder()
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        //enable the save button
        updateSaveButtonState()
        navigationItem.title = textField.text
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        //disable the save button while editing
        saveButton.isEnabled = false
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

    //MARK: Private Methods
    private func updateSaveButtonState() {
        //disable the save button if the text fieldis empty
        let text = nameTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }

    //MARK: actions
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

    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        //configure thedestination view controller only when the savebutton is pressed
        guard let button = sender as? UIBarButtonItem, button == saveButton else {
            os_log("the savebutton was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }

        let name = nameTextField.text ?? ""
        let photo = photoImageView.image
        let rating = ratingControl.rating

        //set the meal to be passed to the MealTableViewController
        meal = Meal(name: name, photo: photo, rating: rating)
    }

    @IBAction func cancel(_ sender: UIBarButtonItem) {

        // Depending on style of presentation (modal or push presentation),
        //this view controller needs to be dismissed in two different ways.
        let isPresentingInAddMealMode = presentingViewController is UINavigationController

        if isPresentingInAddMealMode {
            dismiss(animated: true, completion: nil)
        }

        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }

        else {
            fatalError("The MealViewController is not inside a navigation controller.")
        }
    }
}

