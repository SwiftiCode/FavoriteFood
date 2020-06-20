//
//  RatingControl.swift
//  FavoriteFood
//
//  Created by Thomas.Tay.sg on 22/2/16.
//  Copyright © 2016 Thomas.Tay.sg. All rights reserved.
//

import UIKit

class RatingControl: UIView {

    // MARK: Properties
    var foodRating = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    var starCollection = [UIButton]()
    let totalStars = 5
    let spacing = 5
    
    // MARK: Initialization
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        let emptyStarPic = UIImage(named: "emptyStar")
        let filledStarPic = UIImage(named: "filledStar")
        
        for _ in 0..<totalStars {
            
            let starButton = UIButton()
            
            starButton.setImage(emptyStarPic, for: UIControl.State())
            starButton.setImage(filledStarPic, for: .selected)
            starButton.setImage(filledStarPic, for: [.highlighted, .selected])
            
            starButton.adjustsImageWhenHighlighted = false
            
            starButton.addTarget(self, action: #selector(RatingControl.starTapped(_:)), for: .touchDown)
            
            starCollection += [starButton]
            
            addSubview(starButton)
        }
    }
    
    override var intrinsicContentSize : CGSize {
        
        let starSize = Int(frame.size.height)
        let totalWidth = totalStars * (starSize + spacing)
        
        return CGSize(width: totalWidth, height: starSize)
    }
    
    override func layoutSubviews() {
        
        let starSize = Int(frame.size.height)
        var starFrame = CGRect(x: 0, y: 0, width: starSize, height: starSize)
        
        for (index, star) in starCollection.enumerated() {
            starFrame.origin.x = CGFloat(index * (starSize + spacing))
            star.frame = starFrame
        }
        
        updateStarState()
    }
    
    // MARK: IBAction
    @objc func starTapped(_ star: UIButton) {
        
        foodRating = starCollection.firstIndex(of: star)! + 1
        //print(foodRating)
        
        updateStarState()
    }
    
    func updateStarState(){
        
        for (index, star) in starCollection.enumerated() {
            star.isSelected = index < foodRating
        }
        
    }
    
}
