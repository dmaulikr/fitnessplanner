//
//  ThirdDetailVC.swift
//  FitnessPlanner
//
//  Created by Nicholas Zustak on 12/4/16.
//  Copyright © 2016 CSM. All rights reserved.
//

import UIKit

class ThirdDetailVC: UITableViewController {
    
    var day = ""
    var currentWorkout = [String: [String: [Int]]]() // [MuscleGroup : [Exercise : [NumSets, NumReps]]]
    var muscleGroups = [String]()
    var exercises = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        //self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
        // Put all the muscle groups in an array.
        muscleGroups = Array(currentWorkout.keys)
        // Sort the array.
        muscleGroups.sort(by: {$0 < $1})
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return muscleGroups.count
    }
    
    // Set the header for each section.
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section:
        Int) -> String? {
        return muscleGroups[section]
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return currentWorkout[muscleGroups[section]]!.keys.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath:
        IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier:
            "muscleCell")
        
        if cell == nil {
            print("Need to create a new cell")
            cell = UITableViewCell(style: UITableViewCellStyle.default,
                                   reuseIdentifier: "muscleCell")
        }
        print("trying to access muscle group")
        let group = muscleGroups[indexPath.section]
        print("trying to access currentWorkout with group \(group)")
        let exercisesDict = WorkoutInformation.WIInstance.weeksWorkout[day]?[group]!
        // Ex. ["Bench Press" : [3, 12], "Flys" : [3, 12]]
        var exercisesArr = Array(exercisesDict!.keys)
        print(exercisesArr)
        // Ex. ["Bench Press", "Flys"]
        exercisesArr.sort(by: {$0 < $1})
        print(exercisesArr)
        print("trying to access exercise at row \(indexPath.row)")
        let exercise = exercisesArr[indexPath.row]
        print("all accessed")
        cell?.textLabel?.text = exercise
        cell?.detailTextLabel?.text = "\(exercisesDict![exercise]![0]) sets for \(exercisesDict![exercise]![1]) reps"
        return cell!
    }


    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle:
        UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source.
            // We're deleting an exercise here. The header may remain.
            exercises.remove(at: indexPath.row)
            let group = muscleGroups[indexPath.section]
            print("trying to access currentWorkout with group \(group)")
            let exercisesDict = currentWorkout[group]!
            // Ex. ["Bench Press" : [3, 12], "Flys" : [3, 12]]
            var exercisesArr = Array(exercisesDict.keys)
            exercisesArr.sort(by: {$0 < $1})
            let chosenExercise = exercisesArr[indexPath.row]// should finally get the exercise
            WorkoutInformation.WIInstance.weeksWorkout[day]![muscleGroups[indexPath.section]]?[chosenExercise]?.remove(at: indexPath.row)
            
            // Delete the row from the table.
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            
        }
    }

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

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "setsRepsSegue" {
            let detailVC = segue.destination as! ThirdSubDetailVC
            let indexPath = tableView.indexPath(for: sender as! UITableViewCell)!
            detailVC.day = day      // Ex. Monday
            let group = muscleGroups[indexPath.section]
            detailVC.group = group
            let exercisesDict = currentWorkout[muscleGroups[indexPath.section]]!
            // Ex. ["Bench Press" : [3, 12], "Flys" : [3, 12]]
            var exercisesArr = Array(exercisesDict.keys)
            exercisesArr.sort(by: {$0 < $1})
            let exercise = exercisesArr[indexPath.row]// should finally get the exercise
            detailVC.exercise = exercise
            print("attempting to set ThirdSubDetailVC workout on exercise \(exercise)")
            detailVC.numSets = (WorkoutInformation.WIInstance.weeksWorkout[day]?[group]?[exercise]?[0])!
            detailVC.numSets = (WorkoutInformation.WIInstance.weeksWorkout[day]?[group]?[exercise]?[1])!
            print("Done, segueing")
            // Ex. ["Bench Press" : [3, 12], "Flys" : [3, 12]]
        }
    }
    

}
