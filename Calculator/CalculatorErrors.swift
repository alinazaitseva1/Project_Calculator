//
//  CalculatorErrors.swift
//  Calculator
//
//  Created by Alina Zaitseva on 4/11/18.
//  Copyright © 2018 Alina Zaitseva. All rights reserved.
//

import Foundation

enum ErrorOperations: Error {
    case divisionByZero
    case infinityValue
    
    var exchange: String {
        switch self {
        case .divisionByZero:
            return "Eror! You can not divide by zero"
        case .infinityValue:
            return "Error! Undifined value"

        }
    }
}

