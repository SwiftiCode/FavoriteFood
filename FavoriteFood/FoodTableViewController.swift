//
//  FoodTableViewController.swift
//  FavoriteFood
//
//  Created by Thomas.Tay.sg on 22/2/16.
//  Copyright © 2016 Thomas.Tay.sg. All rights reserved.
//

import UIKit

class FoodTableViewController: UITableViewController {
    
    // MARK: Properties
    var foodCollection = [Food]()
    
    // MARK: Default Template
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        
        
        loadFoodSample()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return foodCollection.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "FoodTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! FoodTableViewCell

        // Configure the cell...
        let localFood = foodCollection[indexPath.row]
        
        cell.cellFoodLabel.text = localFood.foodName
        cell.cellFoodPhotoView.image = localFood.foodPhoto
        cell.cellFoodRatingControl.foodRating = localFood.foodRating

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            foodCollection.removeAtIndex(indexPath.row)
            saveFood()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "EditFood" {
            
            let editFoodViewController = segue.destinationViewController as! FoodViewController
            
            if let selectedCell = sender as? FoodTableViewCell {
                
                let selectedIndexPath = tableView.indexPathForCell(selectedCell)!
                let selectedFood = foodCollection[selectedIndexPath.row]
                editFoodViewController.currentFood = selectedFood
                
            }
        }
    }
    
    
    @IBAction func unwindToFoodList (unwindSegue: UIStoryboardSegue) {
        
        if let foodSourceViewController = unwindSegue.sourceViewController as? FoodViewController, let foodToSave = foodSourceViewController.currentFood {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                
                // Edit Food
                foodCollection[selectedIndexPath.row] = foodToSave
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            
            } else {
            
                // Add New Food
                let newIndexPath = NSIndexPath(forRow: foodCollection.count, inSection: 0)
                foodCollection.append(foodToSave)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            
            }
            
            saveFood()
        }
        
    }
    
    // MARK: Sample Photo
    
    func loadFoodSample() {
    
        let photo1 = UIImage(named: "meal1")!
        let meal1 = Food(foodName: "Caprese Salad", foodPhoto: photo1, foodRating: 4)!
    
        let photo2 = UIImage(named: "meal2")!
        let meal2 = Food(foodName: "Chicken and Potatoes", foodPhoto: photo2, foodRating: 5)!
    
        let photo3 = UIImage(named: "meal3")!
        let meal3 = Food(foodName: "Pasta with Meatballs", foodPhoto: photo3, foodRating: 3)!
    
        foodCollection += [meal1, meal2, meal3]
        
    }
    

    // MARK: NSCoding
    func saveFood() {
        
    }

}
