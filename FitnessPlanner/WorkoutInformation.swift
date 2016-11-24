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
    
    let daysOfWeek = ["Saturday", "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
    
    var weeksWorkout = [String : [String: [String: [Int]]]]() // holds all current workout information for the week [Day : todaysWorkout]
    var todaysWorkout = [String: [String: [Int]]]()    // can change daily
                                                        // [MuscleGroup : [Exercise: [NumSets, NumReps]]]
                                                        // nested array MUST be of size 2!
    
    var day: String
    
    let date = Date()
    let calendar = Calendar.current
    // when we need day, let day = calendar.component(.day, from: date)
    
    init() {
        print("Initializing WIInstance")
        day = ""
        updateDay()
        let path = Bundle.main.path(forResource: "workouts", ofType: "plist")
        weeksWorkout = NSDictionary(contentsOfFile: path!) as! [String : [String : [String : [Int]]]] // this better work
        todaysWorkout = weeksWorkout[day]!
    }
    
    func updateDay() {
        day = daysOfWeek[(calendar.component(.weekday, from: date))]
        print(day)
    }
    
}
