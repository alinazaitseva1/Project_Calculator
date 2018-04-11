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
        let digit = sender.currentTitle! // TODO: remove force unwrapped
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
    
    private var makeCalculation = CalculatorBrain()
    
    @IBAction func performOperator(_ sender: UIButton) {
        if isTypingNumber {
            makeCalculation.setOperand(displayValue)
            isTypingNumber = false
        }
        if let mathematicalSymbol = sender.currentTitle, let operationValue = CalculatorBrain.OperationsName(rawValue: mathematicalSymbol) {
            makeCalculation.performOperation(operationValue)
            // if let operation = OperationsName(rawValue: currentTitle) input it in performOperation
        }
        if let result = makeCalculation.result {
            displayValue = result
            }
        }
}

