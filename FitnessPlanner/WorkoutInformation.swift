//
//  WorkoutInformation.swift
//  FitnessPlanner
//
//  Created by Nicholas Zustak on 11/20/16.
//  Copyright © 2016 CSM. All rights reserved.
//

// this will be a singleton class used by nearly every other class to see what the current information is

import Foundation

class WorkoutInformation {
    
    static let WIInstance = WorkoutInformation()
    
    let daysOfWeek = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    
    var weeksWorkout = [String : [String: [String: [Int]]]]() // holds all current workout information for the week [Day : todaysWorkout]
    var todaysWorkout = [String: [String: [Int]]]()     // can change daily
                                                        // [MuscleGroup : [Exercise: [NumSets, NumReps]]]
                                                        // nested array MUST be of size 2!
    
    var day: String
    
    var setsCompleted: Int = 0
    var totalSets: Int = 1000
    
    let date = Date()
    let calendar = Calendar.current
    // when we need day, let day = calendar.component(.day, from: date)
    
    init() {
        print("Initializing WIInstance")
        day = ""
        print("trying to update day")
        updateDay()
        let path = Bundle.main.path(forResource: "workouts", ofType: "plist")
        weeksWorkout = NSDictionary(contentsOfFile: path!) as! [String : [String : [String : [Int]]]] // this better work
        todaysWorkout = weeksWorkout[day]!
        print("WIInstance initialized")
    }
    
    func updateDay() {
        print("trying to access day")
        print("Component is \(calendar.component(.weekday, from: date))")
        // Thank God I tested on Saturday! The components go from 1-7, not 0-6.
        day = daysOfWeek[(calendar.component(.weekday, from: date)) - 1]
        print(day)
    }
    
}
