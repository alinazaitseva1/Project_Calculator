//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Alina Zaitseva on 4/10/18.
//  Copyright © 2018 Alina Zaitseva. All rights reserved.
//

import Foundation

struct CalculatorBrain {
    
    private var displayValue: Double?
    
    private enum Operation {
        case unaryOperation( (Double) -> Double )
        case binaryOperation( (Double, Double) -> Double )
        case equalAction
    }
    
    private var operationActions: Dictionary <String,Operation> = [
//        "x²" : Operation.binaryOperation(<#T##(Double, Double) -> Double#>),
//        "x³" : Operation.binaryOperation(<#T##(Double, Double) -> Double#>),
//        "eˣ" : Operation.binaryOperation(<#T##(Double, Double) -> Double#>),
        "±" : Operation.unaryOperation({-$0}),
        "sin" : Operation.unaryOperation(sin),
        "cos" : Operation.unaryOperation(cos),
        "tan" : Operation.unaryOperation(tan),
        "ctg" : Operation.unaryOperation(tan),
//        "xʸ" : Operation.binaryOperation(<#T##(Double, Double) -> Double#>),
        "÷" : Operation.binaryOperation({$0 / $1}),
        "+" : Operation.binaryOperation({$0 + $1}),
        "-" : Operation.binaryOperation({$0 - $1}),
        "*" : Operation.binaryOperation({$0 * $1}),
        "=" : Operation.equalAction
    ]
    
    private struct PendingBinaryOperation {
        let action: (Double, Double) -> Double
        let firstValue: Double
        
        func performActions(with secondValue: Double) -> Double {
            return action(firstValue, secondValue)  // function that makes some manipulations with inputed values
        }
    }
    
    private var binaryOperationAction: PendingBinaryOperation? // create optional property in which we copy struct PendingBinaryOperation
    
    private mutating func performBinaryOperation() {
        if binaryOperationAction != nil && displayValue != nil {
            displayValue = binaryOperationAction!.performActions(with: displayValue!) //assign to displayValue result of action structure PendingBinaryOperation (with two inputed values)
            binaryOperationAction = nil
        }
    }
    
    mutating func performOperation(_ sender: String) { // function that switch enum actions and show result to display
        if let operation = operationActions[sender] {
            switch operation {
            case .unaryOperation(let action): // takes double and return double
                if displayValue != nil {
                    displayValue = action(displayValue!)
                }
            case .binaryOperation(let action): // takes two doubles and return double
                if displayValue != nil {
                    binaryOperationAction = PendingBinaryOperation(action: action, firstValue: displayValue! ) // assign to optional property result of actions wuth inputed values
                    // firstValue - is value that shown on display
                    displayValue = nil
                }
            case .equalAction:
                performBinaryOperation() // display the result
            }
        }
    }
    
    mutating func setOperand(_ operand: Double) {
        displayValue = operand
    }
    
    var result: Double? {
        get {
            return displayValue
        }
    }
    
}

//        if let matematicalSymbol = sender.currentTitle {
//            operation = matematicalSymbol
//            if operation == nil {
//                previousValue = displayValue
//            } else {
//                //                displayValue = returnHiddenMeaningAction(value: displayValue, operat: operation!)
//                //
//                //                result = returnMeaningAction(a: previousValue, displayValue, oper: operation!)
//                operation = nil
//                displayValue = result
//                previousValue = displayValue
//                isTypingNumber = false
//            }
