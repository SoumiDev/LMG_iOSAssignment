//
//  DealOnTimer.swift
//  LandMarkGroup
//
//  Created by Dutta, Soumitra on 16/05/19.
//  Copyright © 2019 Dutta, Soumitra. All rights reserved.
//
import Foundation

class DealOnTimer  {
    // Varibale and Constants
    private var timer = Timer()
    private var seconds : Double = 0
    var stringTimer = ""
    var updateTimerlabel : (() -> ())?
    
    
    func convertilisecondsToHhMmSs() {
        seconds  = ProductConstants.endTimeMilicseconds / 1000
        startTimer()
    }
    
    // MARK: - Start Timer
    private func startTimer() {
        DispatchQueue.main.async { [weak self] in
            // timer needs a runloop?
            self?.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self!,   selector: (#selector(DealOnTimer.updateTimer)), userInfo: nil, repeats: true)
        }
        
    }
    
    // MARK : - Timer Interval Action
    @objc func updateTimer() {
        //This will decrement(count down)the seconds.
        seconds = seconds - 1
        if seconds < 0 {
            timer.invalidate()
            convertilisecondsToHhMmSs()
        }
        stringTimer = timeString(time: TimeInterval(seconds)) //This will update the label.
        updateTimerlabel?()
    }
    
    // MARK: - Timestamp Conversion
    private func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
}
