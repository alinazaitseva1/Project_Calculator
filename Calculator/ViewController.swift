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
    
    var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    func validateData(inputValue value: Double) -> Bool {
        let maxLimit = 1000.0
        let minLimit = -1000.0
        if value < maxLimit && value > minLimit {
            return true
        } else {
            return false
        }
    }
    
    var isTypingNumber = false
    var previousValue = 0.0
    var result = 0.0
    var operation: String?
    var isDoingOperation = false

    
    func resetDisplay() {
        displayValue = 0.0
        previousValue = 0.0
        isTypingNumber = false
        result = 0.0
        isDoingOperation = false
        operation = nil
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
        isDoingOperation = true
        if let matematicalSymbol = sender.currentTitle {
            if operation == nil {
                previousValue = displayValue
                operation = matematicalSymbol
            } else {
                operation = matematicalSymbol
                result = returnMeaningAction(a: previousValue, displayValue, oper: operation!)
                operation = nil
                displayValue = result
                previousValue = displayValue
                isTypingNumber = false
                
            }
        }
    }
    
    @IBAction func equalAction(_ sender: UIButton) {
        guard let operation = operation else { return }
        result = returnMeaningAction(a: previousValue, displayValue, oper: operation)
        isTypingNumber = false
        isDoingOperation = true
        displayValue = result
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
            case "÷":
                result = a / b
                if b == 0.0 {
                    result = a
            }
        default:
           print("default")
        }
        
    return result
 }
    
}








