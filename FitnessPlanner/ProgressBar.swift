//
//  ProgressBar.swift
//  FitnessPlanner
//
//  Created by Nicholas Zustak on 11/20/16.
//  Copyright © 2016 CSM. All rights reserved.
//

import UIKit

class ProgressBar: UIView {
    
    static let PBInstance = ProgressBar()
    
    private var percentage: CGFloat = 0.0 // between 0.00 and 1.00
    var setsCompleted: Int = 0
    var totalSets: Int = 1000
    private var timer: Timer!
    
    func makeTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                     target: self,
                                     selector: #selector(draw(_:)),
                                     userInfo: nil, repeats: true)
        print("Created timer")

    }

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        print(rect.width)
        print(rect.height)
        // Drawing code
        percentage = CGFloat(setsCompleted)/CGFloat(totalSets)
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
        print(w)
        print(h)
        context?.setLineWidth(2.0)
        context?.setStrokeColor(UIColor.blue.cgColor)
        let border = CGRect(x: w/10 ,y: h/4, width: 8*w/10 ,height: 2*h/4)
        context?.addRect(border)
        context?.strokePath()
        let filler = CGRect(x: w/10, y: h/4, width: percentage*8*w*0.1, height: 2*h/4)
        context?.setFillColor(UIColor.blue.cgColor)
        context?.addRect(filler)
        context?.fill(filler)
        print(percentage)
    }

}
