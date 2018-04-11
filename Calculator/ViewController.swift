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
            if let displayText = display.text, let displayValue = Double(displayText) {
                return displayValue
            } else {
                return 0
            }
//            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }

    
    var isTypingNumber = false
    var result = 0.0
    var operation: String?

    func resetDisplay() {
        displayValue = 0.0
        isTypingNumber = false
        result = 0.0
        operation = nil
    }
    
    @IBAction func touchDigit(_ sender: UIButton) {
        if let digit = sender.currentTitle  {
//            let digitDouble = Double(digit)
            if isTypingNumber {
                if let textCurrentlyInDisplay = display.text, let _ = Double(textCurrentlyInDisplay + digit) {
                    display.text = textCurrentlyInDisplay +  digit
                }
            } else {
                display.text = digit
                isTypingNumber = true
            }
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
        if let mathematicalSymbol = sender.currentTitle, let operationValue = CalculatorBrain.OperationsName(rawValue: mathematicalSymbol) {
            makeCalculation.performOperation(operationValue)
        }
        if let result = makeCalculation.result {
            displayValue = result
            }
        }
}

