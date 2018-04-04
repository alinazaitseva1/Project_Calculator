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
        
    }
    
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        
        if isTypingNumber {
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
            
        } else {
            display.text = digit
            isTypingNumber = true
        }
    }
    
    @IBAction func performOperator(_ sender: UIButton) {
        isTypingNumber = false
        previousValue = displayValue
       
        if let matematicAction = sender.currentTitle {
            switch matematicAction {
            case "+":
              result = displayValue
              operatort = matematicAction
            case "-":
                result = displayValue
                operatort = matematicAction
            case "*":
                result = displayValue
                operatort = matematicAction
            case "÷":
                result = displayValue
                operatort = matematicAction
            case "=":
                displayValue = equalAction(for: result, displayValue, by: operatort)
            case "√":
                 displayValue = sqrt(displayValue)
            default: break
                
            }
    
        }
    }
    
    func equalAction (for firstDigit: Double, _ secondDigit: Double, by operatort: String) -> Double {
        var result = 0.0
        switch operatort {
        case "+":
            result = firstDigit + secondDigit
        default:
            break
        
        }
        return result
    
    }
    
     func returnMeaningAction(a: Double, b: Double, oper: String) -> Double {
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








