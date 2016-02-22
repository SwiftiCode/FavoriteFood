//
//  FoodViewController.swift
//  FavoriteFood
//
//  Created by Thomas.Tay.sg on 22/2/16.
//  Copyright © 2016 Thomas.Tay.sg. All rights reserved.
//

import UIKit

class FoodViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: Properties
    @IBOutlet weak var foodLabel: UILabel!
    @IBOutlet weak var foodNameTextField: UITextField!
    @IBOutlet weak var foodPhotoView: UIImageView!
    @IBOutlet weak var foodRatingControl: RatingControl!

    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var currentFood: Food?
    
    
    // MARK: Default Template
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        foodNameTextField.delegate = self
        
        if let gotEditFood = currentFood {
            
            foodLabel.text = gotEditFood.foodName
            foodNameTextField.text = gotEditFood.foodName
            foodPhotoView.image = gotEditFood.foodPhoto
            foodRatingControl.foodRating = gotEditFood.foodRating
            
            self.navigationItem.title = "Edit Food"
            
        }
        
        checkValidName()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UITextFieldDelegate
    func textFieldDidBeginEditing(textField: UITextField) {
        
        saveButton.enabled = false
        
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        
        let nameChecked = textField.text ?? ""
        if !nameChecked.isEmpty {
            foodLabel.text = foodNameTextField.text
            saveButton.enabled = true
        } else {
            foodLabel.text = "Food Name"
            saveButton.enabled = false
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    func checkValidName() {
        
        let nameToCheck = foodNameTextField.text ?? ""
        saveButton.enabled = !nameToCheck.isEmpty
    
    }
    
    // MARK: UIImagePickerControllerDelegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        foodPhotoView.image = image
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    // MARK: Navigation
    @IBAction func cancelFood(sender: UIBarButtonItem) {
        
        let isAddMode = presentingViewController is UINavigationController
        if isAddMode {
            dismissViewControllerAnimated(true, completion: nil)
        } else {
            navigationController!.popViewControllerAnimated(true)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if sender === saveButton {
            
            let myFoodName = foodLabel.text!
            let myFoodPhoto = foodPhotoView.image!
            let myFoodRating = foodRatingControl.foodRating
            
            currentFood = Food(foodName: myFoodName, foodPhoto: myFoodPhoto, foodRating: myFoodRating)
        }
    }
    
    // MARK: IBAction
    @IBAction func pickFoodPhoto(sender: UITapGestureRecognizer) {
        
        foodNameTextField.resignFirstResponder()
        
        let myPhotoPicker = UIImagePickerController()
        myPhotoPicker.sourceType = .PhotoLibrary
        myPhotoPicker.delegate = self
        
        presentViewController(myPhotoPicker, animated: true, completion: nil)
        
    }
    


}

