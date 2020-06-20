//
//  Food.swift
//  FavoriteFood
//
//  Created by Thomas.Tay.sg on 22/2/16.
//  Copyright © 2016 Thomas.Tay.sg. All rights reserved.
//

import Foundation
import UIKit

class Food: NSObject, NSCoding {
    
    // MARK: Type
    struct PropertyKey {
        static let nameKey = "name"
        static let photoKey = "photo"
        static let ratingKey = "rating"
    }
    
    // MARK: ArchiveURL
    static let DocDir = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocDir.appendingPathComponent("Food15")
    
    // MARK: Properties
    var foodName: String
    var foodPhoto: UIImage
    var foodRating: Int
    
    // MARK: Initialization
    init?(foodName: String, foodPhoto: UIImage, foodRating: Int) {
        
        self.foodName = foodName
        self.foodPhoto = foodPhoto
        self.foodRating = foodRating
        
        super.init()
        
        if foodName.isEmpty || foodRating < 0 {
            return nil
        }
        
        if foodRating > 5 {
            self.foodRating = 5
        }
    }
    
    // MARK: Encoding
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(foodName, forKey: PropertyKey.nameKey)
        aCoder.encode(foodPhoto, forKey: PropertyKey.photoKey)
        aCoder.encode(foodRating, forKey: PropertyKey.ratingKey)
        
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        let myFoodName = aDecoder.decodeObject(forKey: PropertyKey.nameKey) as! String
        let myFoodPhoto = aDecoder.decodeObject(forKey: PropertyKey.photoKey) as! UIImage
        let myFoodRating = aDecoder.decodeInteger(forKey: PropertyKey.ratingKey)
        
        self.init(foodName: myFoodName, foodPhoto: myFoodPhoto, foodRating: myFoodRating)
        
    }
    
    
}
