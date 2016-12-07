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
    
    // File name for our saved data.
    let savedDataFileName = "workouts.plist"
    
    var currentWorkout = [String: [String: [Int]]]() // [MuscleGroup : [Exercise : [NumSets, NumReps]]]
    var muscleGroups = [String]()
    
    var completions = [String: Int]() // [Exercise : setsCompleted]
    var rowCompletions = [Bool]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Before the loop")
        print("Current workout is \(currentWorkout)")
        for (group, exercises) in currentWorkout {
            print("First level loop")
            print(group)
            for (exercise, _) in exercises {
                print("Second level loop")
                print(exercise)
                completions[exercise] = 0
            }
        }
        print("After the loop")
        // Do any additional setup after loading the view, typically from a nib.
        // If the data file exists, use it.
//        let path: String?
//        let filePath = docFilePath(filename: savedDataFileName)
//        print("Tryna unwrap path")
//        if(filePath != nil) {
//            if FileManager.default.fileExists(atPath: filePath!) {
//                path = filePath
//                print("\n\n Reading in previously saved data from \(path!)\n\n")
//            } else {
//                path = Bundle.main.path(forResource: "continents", ofType: "plist")
//                print("\n\n Reading in initial data from \(path!)\n\n")
//            }
//        }
//        print("Unwrapped path")
//        let notificationCenter = NotificationCenter.default
//        notificationCenter.addObserver(self, selector:
//            #selector(applicationWillResignActive), name:
//            Notification.Name.UIApplicationWillResignActive, object: nil)
    }
    
//    func applicationWillResignActive(_ notification: Notification) {
//        let filePath = docFilePath(filename: savedDataFileName)
//        if(filePath != nil) {
//            let data = NSMutableDictionary()
//            data.addEntries(from: WorkoutInformation.WIInstance.weeksWorkout)
//            print("\n\n Writing to \(filePath), data: \(data)\n\n")
//            data.write(toFile: filePath!, atomically: true)
//        }
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Before will appear")
        let day = WorkoutInformation.WIInstance.day
        currentWorkout = WorkoutInformation.WIInstance.todaysWorkout
        dayLabel.text = day
        print(day)
        // Put all the muscle groups in an array.
        muscleGroups = Array(currentWorkout.keys)
        // Sort the array.
        muscleGroups.sort(by: {$0 < $1})
        var numCells = 0
        var totalSets = 0
        for (_, exercises) in currentWorkout {
            for (_, numSetsNumReps) in exercises {
                totalSets += numSetsNumReps[0]
                numCells += 1
            }
        }
        if(rowCompletions.count == 0) {
            rowCompletions = Array(repeating: false, count: numCells)
        }
        WorkoutInformation.WIInstance.totalSets = totalSets
        print(totalSets)
        print("Will appear'd")
    }
    
    // This method returns the path to a given file in the documents directory.
    func docFilePath(filename: String) -> String? {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .allDomainsMask, true)
        let dir = path[0] as NSString
        return dir.appendingPathComponent(filename)
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
        print("is this the problem?")
        cell?.textLabel?.text = exercise
        cell?.detailTextLabel?.text = "\(exercisesDict[exercise]![0]) sets for \(exercisesDict[exercise]![1]) reps"
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
            detailVC.row = indexPath.row
            detailVC.section = indexPath.section
            print("Something in completions. Nothing in exercisesDict?")
            detailVC.numSets = exercisesDict[exercise]![0]
            detailVC.numReps = exercisesDict[exercise]![1]
            print("Something in exercisesDict")
        }
    }


}

