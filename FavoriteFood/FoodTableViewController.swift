//
//  FoodTableViewController.swift
//  FavoriteFood
//
//  Created by Thomas.Tay.sg on 22/2/16.
//  Copyright © 2016 Thomas.Tay.sg. All rights reserved.
//

import UIKit
import os.log

class FoodTableViewController: UITableViewController {
    
    // MARK: Properties
    var foodCollection = [Food]()
    
    // MARK: Default Template
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        if let gotSavedFood = loadSavedFood() {
            foodCollection += gotSavedFood
        } else {
            loadFoodSample()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return foodCollection.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "FoodTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! FoodTableViewCell

        // Configure the cell...
        let localFood = foodCollection[indexPath.row]
        
        cell.cellFoodLabel.text = localFood.foodName
        cell.cellFoodPhotoView.image = localFood.foodPhoto
        cell.cellFoodRatingControl.foodRating = localFood.foodRating

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            foodCollection.remove(at: indexPath.row)
            saveFood()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "EditFood" {
            
            let editFoodViewController = segue.destination as! FoodViewController
            
            if let selectedCell = sender as? FoodTableViewCell {
                
                let selectedIndexPath = tableView.indexPath(for: selectedCell)!
                let selectedFood = foodCollection[selectedIndexPath.row]
                editFoodViewController.currentFood = selectedFood
                
            }
        }
    }
    
    
    @IBAction func unwindToFoodList (_ unwindSegue: UIStoryboardSegue) {
        
        if let foodSourceViewController = unwindSegue.source as? FoodViewController, let foodToSave = foodSourceViewController.currentFood {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                
                // Edit Food
                foodCollection[selectedIndexPath.row] = foodToSave
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            
            } else {
            
                // Add New Food
                let newIndexPath = IndexPath(row: foodCollection.count, section: 0)
                foodCollection.append(foodToSave)
                tableView.insertRows(at: [newIndexPath], with: .bottom)
            
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
    private func saveFood() {
        
        /*
        let isGoodSave = NSKeyedArchiver.archiveRootObject(foodCollection, toFile: Food.ArchiveURL.path)
        if isGoodSave {
            os_log("Meals successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save meals...", log: OSLog.default, type: .error)
        }*/
        
        //let fullPath = getDocumentsDirectory().appendingPathComponent("meals")

        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: foodCollection, requiringSecureCoding: false)
            try data.write(to: Food.ArchiveURL)
            os_log("Meals successfully saved.", log: OSLog.default, type: .debug)
        } catch {
            os_log("Failed to save meals...", log: OSLog.default, type: .error)
        }
        
    }
    
    private func loadSavedFood() -> [Food]? {
        
        // return NSKeyedUnarchiver.unarchiveObject(withFile: Food.ArchiveURL.path) as? [Food]
        
        if let myData = NSData(contentsOf: Food.ArchiveURL) {
            do {

                let data = Data(referencing:myData)

                if let gotFood = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [Food] {
                    return gotFood
                }
            } catch {
                os_log("Couldn't read file.", log: OSLog.default, type: .error)
                return nil
            }
        }
        return nil
        
    }

}
