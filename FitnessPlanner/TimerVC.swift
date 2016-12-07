//
//  TimerVC.swift
//  FitnessPlanner
//
//  Created by Nicholas Zustak on 12/6/16.
//  Copyright © 2016 CSM. All rights reserved.
//

import UIKit

class TimerVC: UIViewController {
    
    var counter = 0.0
    var timer = Timer()
    var isPlaying = false
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    

    @IBAction func startPressed(_ sender: Any) {
        if(isPlaying) {
            return
        }
        startButton.isEnabled = false
        pauseButton.isEnabled = true
        
        timer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        isPlaying = true
    }
    
    @IBAction func pausePressed(_ sender: Any) {
        startButton.isEnabled = true
        pauseButton.isEnabled = false
        
        timer.invalidate()
        isPlaying = false
    }
    
    @IBAction func resetPressed(_ sender: Any) {
        startButton.isEnabled = true
        pauseButton.isEnabled = false
        
        timer.invalidate()
        isPlaying = false
        counter = 0.0
        timeLabel.text = String(counter)
        self.view.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    func update() {
        if(counter > 30.0) {
            self.view.backgroundColor = UIColor(red: 1, green: 250/255, blue: CGFloat((255 - counter)/255), alpha: 1)
        }
        counter = counter + 0.05
        timeLabel.text = String(format: "%.2f", counter)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timeLabel.text = String(counter)
        pauseButton.isEnabled = false
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
