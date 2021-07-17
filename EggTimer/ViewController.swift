//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    let eggTimes = ["Soft": 120, "Medium": 240, "Hard": 360]
//    var timerSecondsRemaining: Int = 0
    var totalTimeSec = 0
    var passedTimeSec = 0
    var timer = Timer()
    var progressBarDelta: Float = 0
    var player: AVAudioPlayer!
    
    override func viewDidLoad() {
        progressBar.progress = 0
    }
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        let hardness = sender.currentTitle!
        totalTimeSec = eggTimes[hardness]!
        
        passedTimeSec = 0
        print(passedTimeSec)
        
        progressBar.progress = 0
        print(progressBar.progress)
        
        
        label.text = "Process.."
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
    }
    
    
    
    @objc func countDown(timer: Timer) {
        passedTimeSec += 1
        print(passedTimeSec)
        
        progressBar.progress = Float(passedTimeSec)/Float(totalTimeSec)
        print(progressBar.progress)
        
        
        if passedTimeSec == totalTimeSec {
            timer.invalidate()
            label.text = "Done"
            progressBar.progress = 1
            
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
        }
    }
}
