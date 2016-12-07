//
//  DetailExerciseControllerViewController.swift
//  FitnessPlanner
//
//  Created by Nicholas Zustak on 11/20/16.
//  Copyright © 2016 CSM. All rights reserved.
//

import UIKit

class DetailExerciseControllerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var numSets = 0
    var numReps = 0
    var row = 0
    var section = 0
    var exercise : String = ""
    var completions : Int = 0
    var cellsSelected = [Bool]()
    @IBOutlet weak var tblView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        if (numSets > 0) {
            cellsSelected = Array(repeating: false, count: numSets)
            var count = completions
            for index in 0...(cellsSelected.count - 1) {
                // Populate the cellsSelected if they've been selected before
                if(count > 0) {
                    cellsSelected[index] = true
                    count -= 1
                }
            }
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numSets
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath:
        IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier:
            "setCell")
        
        if cell == nil {
            print("Need to create a new setCell")
            cell = UITableViewCell(style: UITableViewCellStyle.default,
                                   reuseIdentifier: "setCell")
        }
        
        if(cellsSelected[indexPath.row]) {
            cell?.accessoryType = .checkmark
        }
        
        cell?.textLabel?.text = "Set \(indexPath.row + 1): \(numReps) reps"
        return cell!
    }
    
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        if let cell = tableView.cellForRow(at: indexPath) {
//            cell.accessoryType = .none
//        }
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            if(!cellsSelected[indexPath.row]) {
                WorkoutInformation.WIInstance.setsCompleted += 1
            }
            cellsSelected[indexPath.row] = true
            cell.accessoryType = .checkmark
        }
    }
    
    func clearCheckMarks(_ tableView: UITableView) {
        for cell in tableView.visibleCells {
            if (cell.accessoryType == UITableViewCellAccessoryType.checkmark) {
                WorkoutInformation.WIInstance.setsCompleted -= 1
            }
            cell.accessoryType = .none
        }
        for index in 0...(cellsSelected.count - 1) {
            cellsSelected[index] = false
        }
    }
    
    @IBAction func resetTapped(_ sender: Any) {
        clearCheckMarks(tblView)
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("Rewinding")
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let masterVC = segue.destination as! FirstViewController
        masterVC.rowCompletions[row] = false
        print("Exercise is \(exercise)")
        if(exercise != "") {
            var count = 0
            for bool in cellsSelected {
                if(bool) {
                    count += 1
                }
            }
            if(count == numSets) {
                masterVC.rowCompletions[row] = true
                print("We completed the row")
                masterVC.tblView.cellForRow(at: IndexPath(row: row, section: section))?.backgroundColor = UIColor.green
            }
            masterVC.completions[exercise] = count
            print("Are we even here")
            print(masterVC.completions[exercise]!)
        }
        
    }
    

}
