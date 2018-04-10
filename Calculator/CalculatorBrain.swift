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
        "x²" : Operation.unaryOperation({pow($0, 2)}),
        "x³" : Operation.unaryOperation({pow($0, 3)}),
        "eˣ" : Operation.unaryOperation({exp($0)}),
        "±" : Operation.unaryOperation({-$0}),
        "sin" : Operation.unaryOperation(sin),
        "cos" : Operation.unaryOperation(cos),
        "tan" : Operation.unaryOperation(tan),
        "ctg" : Operation.unaryOperation(tan),
        "xʸ" : Operation.binaryOperation({$0 * pow($0,$1)}),
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
            return action(firstValue, secondValue)
        }
    }
    
    private var binaryOperationAction: PendingBinaryOperation? // create optional property in which we copy struct PendingBinaryOperation
    
    private mutating func performBinaryOperation() {
        if binaryOperationAction != nil && displayValue != nil {
            displayValue = binaryOperationAction!.performActions(with: displayValue!)
            binaryOperationAction = nil
        }
    }
    
    mutating func performOperation(_ sender: String) {
        if let operation = operationActions[sender] {
            switch operation {
            case .unaryOperation(let action):
                if displayValue != nil {
                    displayValue = action(displayValue!)
                }
            case .binaryOperation(let action):
                if displayValue != nil {
                    binaryOperationAction = PendingBinaryOperation(action: action, firstValue: displayValue! )
                    displayValue = nil
                }
            case .equalAction:
                performBinaryOperation()
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

