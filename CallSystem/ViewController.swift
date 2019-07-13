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
    var number: Int = 0
    var numberString : String = ""
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
        numberString = numberString + String(sender.tag - 1)
        label.text = numberString
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
        // clear button, clear the textfield
        if (sender.tag == 11)
        {
            label.text = "0"
        }
        //+ button
        if(sender.tag == 13){
            if(label.text != nil){
                number = Int(label.text ?? "0")!
            }
            number = (number + 1)%100
            label.text = String(number)
        }
        //- button
        if(sender.tag == 14){
            if(label.text != nil){
                number = Int(label.text ?? "0")!
            }
            number = (number - 1)%100
            if(number < 0){
                number = 0;
            }
            label.text = String(number)
        }
        //Call button
        if sender.tag == 12{
            if(Int(label.text!)! > 100){
                var temp : String
                temp = label.text!
                temp = String(temp.prefix(2))
                label.text = temp
            }
            print("called")
            DingDong.play()
            //invalidate previous timer
            timer.invalidate()
            //call timer
            timer = Timer.scheduledTimer(timeInterval: TimeInterval(delay), target: self, selector: #selector(delayedAction), userInfo: nil, repeats: false)
            numberString = ""
        }
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        do{
            label.text = "0"
            //preload audio
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
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        switch UIDevice.current.orientation{
        case .landscapeLeft,
             .landscapeRight:
            label.font = UIFont.systemFont(ofSize: 200.0)
            break
        case .portrait:
            label.font = UIFont.systemFont(ofSize: 30.0)
            break
        default:
            print("Default")
        }
    }
    
    @objc func delayedAction() {
        let speechUtterance = AVSpeechUtterance(string:label.text!)
        speechUtterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        speechSynthesizer.speak(speechUtterance)
        number = 0;
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

