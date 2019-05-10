//
//  ViewController.swift
//  copy
//
//  Created by Xavier on 2/6/18.
//  Copyright © 2018 Axus. All rights reserved.
//

import UIKit
import AVFoundation

class chinese: UIViewController {
    
    var numberOnScreen: Double = 0
    
    let speechSynthesizer = AVSpeechSynthesizer()
    
    
    //audio variables for the 3 icon
    var NOF = AVAudioPlayer()
    var PlsRetTray = AVAudioPlayer()
    var DingDong = AVAudioPlayer()
    
    //Connections
    
    @IBOutlet weak var label2: UITextField!
    
    @IBAction func NoOutsideFood(_ sender: UIButton) {
        NOF.play()
    }
    
    @IBAction func PRT(_ sender: UIButton) {
       PlsRetTray.play()
    }
    
    @IBAction func Bell(_ sender: UIButton) {
        
         DingDong.play()
    }
    
    @IBAction func Numbers(_ sender: UIButton) {
        label2.text = (label2.text! + String(sender.tag - 1))
        numberOnScreen = Double(label2.text!)!
    }
    
    @IBAction func Buttons(_ sender: UIButton) {
        if (sender.tag == 12 || sender.tag == 11) // clear and call
        {
            label2.text = nil
        }
        
        if(sender.tag == 13){ // +
            if(numberOnScreen <= 100 && numberOnScreen > 0){
                numberOnScreen += 1
            }
            else{
                numberOnScreen = 1;
            }
            label2.text = String(Int(numberOnScreen))
        }
        if(sender.tag == 14){  // -
            if(numberOnScreen <= 100 && numberOnScreen > 2){
                numberOnScreen -= 1
            }
            else{
                numberOnScreen = 1;
            }
            label2.text = String(Int(numberOnScreen))
        }
        
        if sender.tag == 12 {//play sound(call)
            
            label2.text = String(Int(numberOnScreen))
            let speechUtterance = AVSpeechUtterance(string: label2.text!)
            speechUtterance.voice = AVSpeechSynthesisVoice(language: "zh-CN")
            
            speechSynthesizer.speak(speechUtterance)
            label2.text = nil
        }
    
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        do{
            NOF = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "NOF", ofType: "m4a")!))
            PlsRetTray = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "PRT", ofType: "m4a")!))
            DingDong = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "Ding", ofType: "mp3")!))
            
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

