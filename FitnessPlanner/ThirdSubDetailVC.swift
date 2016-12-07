//
//  ThirdSubDetailVC.swift
//  FitnessPlanner
//
//  Created by Nicholas Zustak on 12/4/16.
//  Copyright © 2016 CSM. All rights reserved.
//

import UIKit

class ThirdSubDetailVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var day = ""
    var group = ""
    var exercise = ""
    var numSets = 0
    var numReps = 0
    
    var sets = [1, 2, 3, 4, 5, 6, 7, 8]
    var reps = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int {
        if(pickerView.accessibilityIdentifier == "numSetsPicker") {
            return sets.count
        }
        else {
            return reps.count
        }
    }
    
    //Picker Delegate methods
    //Returns the title for a given row
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(pickerView.accessibilityIdentifier == "numSetsPicker") {
            return "\(sets[row])"
        }
        else {
            return "\(reps[row])"
        }
    }
    
    //Called when a row is selected
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int,
                    inComponent component: Int) {
        // This writes the string with the row's content to the label.
        if(pickerView.accessibilityIdentifier == "numSetsPicker") {
             WorkoutInformation.WIInstance.weeksWorkout[day]?[group]?[exercise]?[0] = sets[row]
            print("set reps")
        }
        else {
            WorkoutInformation.WIInstance.weeksWorkout[day]?[group]?[exercise]?[1] = reps[row]
            print("set sets")
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
