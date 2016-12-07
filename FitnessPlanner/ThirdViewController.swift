//
//  ThirdViewController.swift
//  FitnessPlanner
//
//  Created by Nicholas Zustak on 12/3/16.
//  Copyright © 2016 CSM. All rights reserved.
//

import UIKit

class ThirdViewController: UITableViewController {
    
    var theWeek = WorkoutInformation.WIInstance.weeksWorkout
    var days = [String]()
    @IBOutlet var tblView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        days = WorkoutInformation.WIInstance.daysOfWeek
        self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
        print("Loaded ThirdVC")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return days.count
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return days.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath:
        IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier:
            "dayCell")
        
        if cell == nil {
            print("Need to create a new cell")
            cell = UITableViewCell(style: UITableViewCellStyle.default,
                                   reuseIdentifier: "dayCell")
        }
        
        let day = days[indexPath.row]
//        // Ex. Chest
//        let muscleGroupsDict = theWeek[day]!
//        // Ex. ["Chest" : ["Bench Press: [3, 12]]]
//        var groupsArr = Array(muscleGroupsDict.keys)
//        let group = groupsArr[indexPath.row]
        cell?.textLabel?.text = day
        return cell!
    }
    
    @IBAction func myUnwindAction(unwindSegue: UIStoryboardSegue) {
        print("Unwound.")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editSegue" {
            let detailVC = segue.destination as! ThirdDetailVC
            let indexPath = tblView.indexPath(for: sender as! UITableViewCell)!
            let day = days[indexPath.row]       // Ex. Monday
            detailVC.day = day
            print("attempting to set ThirdDetailVC workout on day \(day)")
            detailVC.currentWorkout = theWeek[day]! // this also better work
            print("Done, segueing")
            // Ex. ["Bench Press" : [3, 12], "Flys" : [3, 12]]
        }
    }
    
    // Set the header for each section.
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section:
//        Int) -> String? {
//        return days[section]
//    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
