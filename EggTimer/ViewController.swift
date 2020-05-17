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
    
    let eggTimes = ["Soft": 5, "Medium": 7, "Hard" : 12]
    
    var audioPlayer = AVAudioPlayer()
    var timer :Timer?
    var timePassed: Int = 1
    var time: Int?
    var progressSegment: Float = 0
    var progress: Double = 0
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    override func viewDidLoad() {
    }
    
    @IBAction func eggHardnessHandler(_ sender: UIButton) {
        progressBar.progress = 0
        statusLabel.text = "How do you like your eggs?"
        timer?.invalidate()
        audioPlayer.stop()
        self.timePassed = 0
        //getting the hardness of the button in text
        let hardness : String = sender.currentTitle!
        
        //getting times from
        time = eggTimes[hardness]
        //timer that reiterates after each second
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){timer in

            //stopping the timer when the time is reached
            if self.timePassed >= self.time!{
                timer.invalidate()
                self.statusLabel.text = "DONE!"
                self.timePassed = 0
                self.playSound()
            }else{
                self.timePassed+=1

                self.progressBar.progress = Float(self.timePassed)/Float(self.time!)
                
            }
        }
    }
    
    //method to play sound
    func playSound(){
        let path = Bundle.main.path(forResource: "alarm_sound", ofType: "mp3")!
        let url = URL(fileURLWithPath: path)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer.play()
        }catch{
            print("Error")
        }
    }
}
