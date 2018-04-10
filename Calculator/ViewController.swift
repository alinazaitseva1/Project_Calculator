//
//  ViewController.swift
//  Calculator
//
//  Created by Alina Zaitseva on 4/4/18.
//  Copyright © 2018 Alina Zaitseva. All rights reserved.
//

import UIKit

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
            let verificationValue = Double(textCurrentlyInDisplay + digit)
                if validateData(inputValue: verificationValue!) {
                    display.text = textCurrentlyInDisplay + digit
                }
        } else if digit != "0" {
            display.text = digit
            isTypingNumber = true
        }
    }
    
    @IBAction func resetActions(_ sender: UIButton) {
        resetDisplay()
    }
    
    private var makeCalculation = CalculatorBrain()
    
    @IBAction func performOperator(_ sender: UIButton) {
        if isTypingNumber {
            makeCalculation.setOperand(displayValue)
            isTypingNumber = false
        }
        if let matematicalSymbol = sender.currentTitle {
            makeCalculation.performOperation(matematicalSymbol)
        }
        if let result = makeCalculation.result {
            displayValue = result
        }
    }
    
}








