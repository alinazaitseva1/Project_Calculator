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
    @IBAction func equalAction(_ sender: UIButton) {
        
    }
    
    //    @IBAction func equalAction(_ sender: UIButton) {
    //        guard let operation = operation else { return }
    //        isTypingNumber = false
    //        isDoingOperation = true
    //        result = returnMeaningAction(a: previousValue, displayValue, oper: operation)
    //        displayValue = result
    //    }
    
//     func returnMeaningAction(a: Double, _ b: Double, oper: String) -> Double {
//        var result = 0.0
//        switch oper {
//            case "+":
//                result = a + b
//            case "-":
//                result = a - b
//            case "*":
//                result = a * b
//            case "÷":
//                result = a / b
//                if b == 0.0 {
//                    result = a
//            }
//        default:
//           print("default1")
//        }
//    return result
// }
//    func returnHiddenMeaningAction(value: Double, operat: String ) -> Double {
//        var result = 0.0
//        switch operat {
//        case "x²":
//            result = pow(value, 2)
//        case "x³":
//            result = pow(value, 3)
//        case "xʸ":
//            result = pow(value, value)
//        case "eˣ":
//            result = exp(value)
//        case "sin":
//            result = sin(value*Double.pi/180)
//        case "cos":
//            result = cos(value*Double.pi*180)
//        case "tan":
//            result = tan(value*Double.pi*180)
//        case "ctg":
//            result = 1/tan(value)
//        default:
//            print("default2")
//        }
//        return result
//
//    }
    
}








