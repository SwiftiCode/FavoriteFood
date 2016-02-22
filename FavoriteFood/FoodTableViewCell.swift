//
//  FoodTableViewCell.swift
//  FavoriteFood
//
//  Created by Thomas.Tay.sg on 22/2/16.
//  Copyright © 2016 Thomas.Tay.sg. All rights reserved.
//

import UIKit

class FoodTableViewCell: UITableViewCell {
    
    // MARK: Properties
    @IBOutlet weak var cellFoodLabel: UILabel!
    @IBOutlet weak var cellFoodPhotoView: UIImageView!
    @IBOutlet weak var cellFoodRatingControl: RatingControl!
    
    
    
    // MARK: Default Template
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
