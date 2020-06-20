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
        
        //self.automaticallyAdjustsScrollViewInsets = false
        
        
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
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        saveButton.isEnabled = false
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        let nameChecked = textField.text ?? ""
        if !nameChecked.isEmpty {
            foodLabel.text = foodNameTextField.text
            saveButton.isEnabled = true
        } else {
            foodLabel.text = "Food Name"
            saveButton.isEnabled = false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    func checkValidName() {
        
        let nameToCheck = foodNameTextField.text ?? ""
        saveButton.isEnabled = !nameToCheck.isEmpty
    
    }
    
    // MARK: UIImagePickerControllerDelegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        foodPhotoView.image =  info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    // MARK: Navigation
    @IBAction func cancelFood(_ sender: UIBarButtonItem) {
        
        let isAddMode = presentingViewController is UINavigationController
        if isAddMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController!.popViewController(animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if sender as AnyObject? === saveButton {
            
            let myFoodName = foodLabel.text!
            let myFoodPhoto = foodPhotoView.image!
            let myFoodRating = foodRatingControl.foodRating
            
            currentFood = Food(foodName: myFoodName, foodPhoto: myFoodPhoto, foodRating: myFoodRating)
        }
    }
    
    // MARK: IBAction
    @IBAction func pickFoodPhoto(_ sender: UITapGestureRecognizer) {
        
        foodNameTextField.resignFirstResponder()
        
        let myPhotoPicker = UIImagePickerController()
        myPhotoPicker.sourceType = .photoLibrary
        myPhotoPicker.delegate = self
        
        present(myPhotoPicker, animated: true, completion: nil)
        
    }
    


}

