//
//  FirstViewController.swift
//  FitnessPlanner
//
//  Created by Nicholas Zustak on 11/20/16.
//  Copyright © 2016 CSM. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var tblView: UITableView!
    
    var currentWorkout = [String: [String: [Int]]]() // [MuscleGroup : [Exercise : [NumSets, NumReps]]]
    var muscleGroups = [String]()
    
    var completions = [String: Int]() // [Exercise : setsCompleted]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ProgressBar.PBInstance.makeTimer()
        for (group, exercises) in currentWorkout {
            print(group)
            for (exercise, _) in exercises {
                print(exercise)
                completions[exercise] = 0
            }
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ProgressBar.PBInstance.setNeedsDisplay()
        
        let day = WorkoutInformation.WIInstance.day
        currentWorkout = WorkoutInformation.WIInstance.todaysWorkout
        dayLabel.text = day
        print(day)
        // Put all the muscle groups in an array.
        muscleGroups = Array(currentWorkout.keys)
        // Sort the array.
        muscleGroups.sort(by: {$0 < $1})
        var totalSets = 0
        for (_, exercises) in currentWorkout {
            for (_, numSetsNumReps) in exercises {
                totalSets += numSetsNumReps[0]
            }
        }
        ProgressBar.PBInstance.totalSets = totalSets
        print(totalSets)
    }
    
    @IBAction func myUnwindAction(unwindSegue: UIStoryboardSegue) {
        print("Unwound.")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let muscleGroup = muscleGroups[section]
        let exercises = currentWorkout[muscleGroup]!
        return exercises.count
    }
    
    // Called when a row is selected.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath:
        IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier:
            "workoutCell")
        
        if cell == nil {
            print("Need to create a new cell")
            cell = UITableViewCell(style: UITableViewCellStyle.default,
                                   reuseIdentifier: "workoutCell")
        }
        
        let muscleGroup = muscleGroups[indexPath.section]       // Ex. Chest
        let exercisesDict = currentWorkout[muscleGroup]!
        // Ex. ["Bench Press" : [3, 12], "Flys" : [3, 12]]
        var exercisesArr = Array(exercisesDict.keys)
        // Ex. ["Bench Press", "Flys"]
        exercisesArr.sort(by: {$0 < $1})
        let exercise = exercisesArr[indexPath.row]
        
        cell?.textLabel?.text = exercise
        cell?.detailTextLabel?.text = "\(exercisesDict[exercise]![0]) sets for \(exercisesDict[exercise]![1]) reps"
        ProgressBar.PBInstance.setNeedsDisplay()
        return cell!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return muscleGroups.count
    }
    
    // Set the header for each section.
    func tableView(_ tableView: UITableView, titleForHeaderInSection section:
        Int) -> String? {
        return muscleGroups[section]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "exerciseSegue" {
            let detailVC = segue.destination as! DetailExerciseControllerViewController
            let indexPath = tblView.indexPath(for: sender as! UITableViewCell)!
            let muscleGroup = muscleGroups[indexPath.section]       // Ex. Chest
            let exercisesDict = currentWorkout[muscleGroup]!
            // Ex. ["Bench Press" : [3, 12], "Flys" : [3, 12]]
            var exercisesArr = Array(exercisesDict.keys)
            // Ex. ["Bench Press", "Flys"]
            exercisesArr.sort(by: {$0 < $1})
            let exercise = exercisesArr[indexPath.row]
            detailVC.exercise = exercise
            print("Nothing in completions?")
            print(exercise)
            if let numCompletions = completions[exercise] {
                detailVC.completions = numCompletions
            }
            else {
                print("It doesn't exist")
            }
            print("Something in completions. Nothing in exercisesDict?")
            detailVC.numSets = exercisesDict[exercise]![0]
            detailVC.numReps = exercisesDict[exercise]![1]
            print("Something in exercisesDict")
            print(ProgressBar.PBInstance.setsCompleted)
        }
    }


}

