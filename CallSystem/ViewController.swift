//
//  ViewController.swift
//  CallSystem
//
//  Created by Xavier on 20/5/18.
//  Copyright © 2018 Axus. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var timer = Timer()
    let delay = 0.7
    
    let speechSynthesizer = AVSpeechSynthesizer()
    //variables for label.text
    var numberOnScreen: Int = 0
    
    //audio variables for the 3 icon
    var NOF = AVAudioPlayer()
    var PlsRetTray = AVAudioPlayer()
    var DingDong = AVAudioPlayer()
    

    @IBOutlet weak var label: UITextField!
    
    @IBAction func NoOutSideFood(_ sender: UIButton) {
        NOF.play()
    }
    @IBAction func Bell(_ sender: UIButton) {

        DingDong.play()
    }
    
    @IBAction func PlsReturnTray(_ sender: UIButton) {
        PlsRetTray.play()
        print("returned")
    }
    
    @IBAction func numbers(_ sender: UIButton) {
        label.text = (label.text! + String(sender.tag - 1))
        numberOnScreen = Int(label.text!)!
    }
    
    @IBAction func Proceed(_ sender: UIButton) {
        if sender.tag == 15{ //play sound for proceed to counter
            let speech = AVSpeechUtterance(string: "Please proceed to food counter")
            speech.voice = AVSpeechSynthesisVoice(language: "en-US")
            speechSynthesizer.speak(speech)
            print("proceed")
        }
    }
    
    @IBAction func Buttons(_ sender: UIButton) {
        if (sender.tag == 12 || sender.tag == 11) // clear and call
        {
            label.text = nil
        }
        
        if(sender.tag == 13){ //+
            if(numberOnScreen <= 100 && numberOnScreen > 0){
                numberOnScreen += 1
            }
            else{
                numberOnScreen = 1;
            }
            label.text = String(Int(numberOnScreen))
        }
        if(sender.tag == 14){ //-
            if(numberOnScreen <= 100 && numberOnScreen > 2){
                numberOnScreen -= 1
            }
            else{
                numberOnScreen = 1;
            }
            label.text = String(Int(numberOnScreen))
        }
        
        if sender.tag == 12{//play sound(call)
            
            label.text = String(Int(numberOnScreen))
            DingDong.play()
            timer.invalidate()
            timer = Timer.scheduledTimer(timeInterval: TimeInterval(delay), target: self, selector: #selector(delayedAction), userInfo: nil, repeats: false)
            
        }
     
        
    }
    
    @objc func delayedAction() {
        print("action has started")
        let speechUtterance = AVSpeechUtterance(string:label.text!)
        speechUtterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        speechSynthesizer.speak(speechUtterance)
        label.text = nil
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        do{
            NOF = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "NOF", ofType: "m4a")!))
            PlsRetTray = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "PRT", ofType: "m4a")!))
            DingDong = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "Ding", ofType: "mp3")!))
            
            //DingDong.volume = 0.4f
            DingDong.enableRate = true //<--
             DingDong.prepareToPlay()
            //[player setNumberOfLoops:0];
            DingDong.rate = 2.0 //<-- Playback Speed
           
            NOF.prepareToPlay()
            PlsRetTray.prepareToPlay()
           
            
           
        
        }
        catch{
            print(error)
        }
        
       
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

