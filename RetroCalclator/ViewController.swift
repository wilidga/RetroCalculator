//
//  ViewController.swift
//  RetroCalclator
//
//  Created by Wilman Garcia De Leon on 9/3/17.
//  Copyright © 2017 vengapps. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var btnSound: AVAudioPlayer!
    var runningNumber = ""
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Emppty"
    }
    
    var currentOperation = Operation.Empty
    var leftValStr = ""
    var rightValStr = ""
    var result = ""
    
    
    @IBOutlet weak var outputLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let path = Bundle.main.path(forResource: "btn", ofType:"wav")
        let soundURL = URL(fileURLWithPath: path!)
        
        do{
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
        }catch let err as NSError{
            print(err.debugDescription)
        }
        
        outputLabel.text = "0"
    }
    
    
    @IBAction func numberPressed (sender: UIButton)
    {
      playSound()
        
        
        runningNumber += "\(sender.tag)"
        outputLabel.text = runningNumber
    }
    
    func playSound(){
        
        if btnSound.isPlaying{
            btnSound.stop()
        }
        btnSound.play()
    
    }
    
    
    @IBAction func OnDividePressed (sender : Any){
        processOperation(operation: .Divide)
    
    }
    @IBAction func OnMultiplyPressed (sender : Any){
        processOperation(operation: .Multiply)
        
    }
    
    @IBAction func OnSubstractPressed (sender : Any){
        processOperation(operation: .Subtract)
        
    }
    @IBAction func OnAddPressed (sender : Any){
        processOperation(operation: .Add)
        
    }
    
    @IBAction func OnEqualPressed (sender : Any){
       processOperation(operation: currentOperation)
        
    }
    
    
    @IBAction func OnClearPressed(_ sender: Any) {
        
        playSound()

        
        outputLabel.text = "0"
        rightValStr = ""
        leftValStr = ""
        result = ""
        runningNumber = ""
        currentOperation = Operation.Empty
        
    }
    
    func processOperation(operation: Operation) {
        playSound()
        if currentOperation != Operation.Empty {
            //A user selected an operator, but then selected another operator without first entering a number
            if (runningNumber != "" || leftValStr != "")  {
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                }
                
                leftValStr = result
                outputLabel.text = result
            }
            
            currentOperation = operation
        } else {
            //This is the first time an operator has been pressed
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    }
    
    
}
