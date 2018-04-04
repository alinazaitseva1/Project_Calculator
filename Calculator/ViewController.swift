//
//  ViewController.swift
//  Calculator
//
//  Created by Alina Zaitseva on 4/4/18.
//  Copyright © 2018 Alina Zaitseva. All rights reserved.
//

import UIKit

enum Operators {
    case plus
    case minus
    case multiply
    case separate
}

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    var isTypingNumber = false
    var previousValue = 0.0
    var result = 0.0
    var operatort = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    func resetDisplay() {
        display.text = "0"
        previousValue = 0.0
        isTypingNumber = false
        
    }
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        
        if isTypingNumber, display.text != "0" {
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
            
        } else if digit != "0" {
            display.text = digit
            isTypingNumber = true
        }
    }
    
    @IBAction func resetActions(_ sender: UIButton) {
        resetDisplay()
    }
    
    @IBAction func performOperator(_ sender: UIButton) {
        isTypingNumber = false
        previousValue = displayValue
       
        if let matematicAction = sender.currentTitle {
            switch matematicAction {
            case "=":
                isTypingNumber = false
                displayValue = returnMeaningAction(a: result, displayValue, oper: operatort)
            case "√":
                 displayValue = sqrt(displayValue)
            default: break
                
            }
        }
    }

     func returnMeaningAction(a: Double, _ b: Double, oper: String) -> Double {
        var result = 0.0
        switch oper {
            case "+":
                result = a + b
            case "-":
                result = a - b
            case "*":
                result = a * b
            case "/":
                result = a / b
    
        default:
           break
        }
        
    return result
 }
    
}








