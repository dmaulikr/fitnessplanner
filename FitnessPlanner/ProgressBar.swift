//
//  ProgressBar.swift
//  FitnessPlanner
//
//  Created by Nicholas Zustak on 11/20/16.
//  Copyright © 2016 CSM. All rights reserved.
//

import UIKit

class ProgressBar: UIView {
    
    private var percentage: CGFloat = 0.0 // between 0.00 and 1.00
    private var timer: Timer!
    
    func makeTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                     target: self,
                                     selector: #selector(draw(_:)),
                                     userInfo: nil, repeats: true)
        print("Created timer")

    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeTimer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        print("view width is \(rect.width)")
        print("view height is \(rect.height)")
        // Drawing code
        percentage = CGFloat(WorkoutInformation.WIInstance.setsCompleted)/CGFloat(WorkoutInformation.WIInstance.totalSets)
        if(percentage > 1.0) {
            percentage = 1.0
        }
        if(percentage < 0.0) {
            percentage = 0.0
        }
        let context = UIGraphicsGetCurrentContext()
        var w = self.bounds.width     // fix later
        var h = self.bounds.height   // fix later
        if (w < 100.0) {
            w = 288.0
        }
        if (h < 50.0) {
            h = 100
        }
        let bg = CGRect(x: w/10, y: h/4, width: 8*w*0.1, height: 2*h/4)
        context?.setFillColor(UIColor.gray.cgColor)
        context?.addRect(bg)
        context?.fill(bg)
        let filler = CGRect(x: w/10, y: h/4, width: percentage*8*w*0.1, height: 2*h/4)
        if(percentage > 0.99) {
            context?.setFillColor(UIColor.green.cgColor)
        }
        else {
            context?.setFillColor(UIColor.blue.cgColor)
        }
        context?.addRect(filler)
        context?.fill(filler)
        print(percentage)
    }

}
