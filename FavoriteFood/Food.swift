//
//  Food.swift
//  FavoriteFood
//
//  Created by Thomas.Tay.sg on 22/2/16.
//  Copyright © 2016 Thomas.Tay.sg. All rights reserved.
//

import Foundation
import UIKit

class Food {
    
    // MARK: Type
    
    // MARK: ArchiveURL
    
    // MARK: Properties
    var foodName: String
    var foodPhoto: UIImage
    var foodRating: Int
    
    // MARK: Initialization
    init?(foodName: String, foodPhoto: UIImage, foodRating: Int) {
        
        self.foodName = foodName
        self.foodPhoto = foodPhoto
        self.foodRating = foodRating
        
        if foodName.isEmpty || foodRating < 0 {
            return nil
        }
        
        if foodRating > 5 {
            self.foodRating = 5
        }
    }
    
    // MARK: Encoding
    
}
