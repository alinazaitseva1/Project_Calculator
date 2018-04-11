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
    
    private var operationActions: Dictionary <OperationsName,Operation> = [
        .squareRoot : Operation.unaryOperation({pow($0, 2)}),
        .cubicRoot : Operation.unaryOperation({pow($0, 3)}),
        .exponent : Operation.unaryOperation({exp($0)}),
        .ctg : Operation.unaryOperation(tanh),
        .sinus : Operation.unaryOperation(sin),
        .cosine : Operation.unaryOperation(cos),
        .tan : Operation.unaryOperation(tan),
        .powerY : Operation.binaryOperation({$0 * pow($0,$1)}),
        .divide : Operation.binaryOperation({$0 / $1}),
        .plus : Operation.binaryOperation({$0 + $1}),
        .minus : Operation.binaryOperation({$0 - $1}),
        .multiply : Operation.binaryOperation({$0 * $1}),
        .equal : Operation.equalAction
    ]
    
    enum OperationsName: String {
        case squareRoot = "x²"
        case cubicRoot = "x³"
        case exponent = "eˣ"
        case ctg = "tanh"
        case sinus = "sin"
        case cosine = "cos"
        case tan = "tan"
        case powerY = "xʸ"
        case divide = "÷"
        case plus = "+"
        case minus = "-"
        case multiply = "*"
        case equal = "="
    }
    
    private struct PendingBinaryOperation {
        let action: (Double, Double) -> Double
        let firstValue: Double

        func performActions(with secondValue: Double) -> Double {
            return action(firstValue, secondValue)
        }
    }
    
    private var binaryOperationAction: PendingBinaryOperation? // create optional property in which we copy struct PendingBinaryOperation
    
    private mutating func performBinaryOperation() {
        guard let binaryOperation = binaryOperationAction, var displayValue = displayValue else { return }
        
            displayValue = binaryOperation.performActions(with: displayValue)
            binaryOperationAction = nil
    }
    
    mutating func performOperation(_ operationInput: OperationsName) {
        if let operation = operationActions[operationInput] {
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

