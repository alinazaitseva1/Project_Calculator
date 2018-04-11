//
//  CalculatorErrors.swift
//  Calculator
//
//  Created by Alina Zaitseva on 4/11/18.
//  Copyright © 2018 Alina Zaitseva. All rights reserved.
//

import Foundation

enum ErrorOperations: Error {
    case divisionbyZero
    case infinity
    case tanEror
    case ctgEror
    
    var exchange: String {
        switch self {
        case .divisionbyZero:
            return "Eror! You can not divide by zero"
        case .infinity:
            return "Error! Undifined value"
        case .tanEror:
            return "Error! No such value for tan"
        case .ctgEror:
            return "Error! No such value for ctg"
        }
    }
}

