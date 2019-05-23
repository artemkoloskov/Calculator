//
//  ViewController.swift
//  calculator
//
//  Created by Artem Koloskov on 02.11.2017.
//  Copyright © 2017 Artem Koloskov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    @IBOutlet weak var historyDisplay: UILabel!
    
    var userIsInTheMiddleOfTyping = false
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTyping {
            let textCurrentlyInDisplay = display.text!
            if textCurrentlyInDisplay.contains(".") && digit == "." {
                
            } else {
                display.text = textCurrentlyInDisplay + digit
            }
        } else {
            if digit == "." {
                display.text = "0\(digit)"
            } else {
                display.text = digit
            }
            userIsInTheMiddleOfTyping = true
        }
    }
    
    var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            if (newValue - floor(newValue)) == 0 {
                if newValue > Double(INT64_MAX) {
                    display.text = "Err"
                } else {
                    display.text = String(Int64(newValue))
                }
            } else {
                display.text = String(newValue)
            }
        }
    }
    
    var historyDisplayValue: Double {
        get {
            return Double(historyDisplay.text!)!
        }
        set {
            if (newValue - floor(newValue)) == 0 {
                historyDisplay.text = String(Int(newValue))
            } else {
                historyDisplay.text = String(newValue)
            }
        }
    }
    
    private var brain = CalculatorBrain()
    
    @IBAction func performOperation(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
        }
        
        if let mathematicalSymbol = sender.currentTitle {
            if mathematicalSymbol == "AC"{
                userIsInTheMiddleOfTyping = false
                displayValue = 0
                historyDisplayValue = 0
                brain.setOperand(0)
            } else {
                brain.performOperation(mathematicalSymbol)
                
                if let result = brain.result {
                    displayValue = result
                }
            }
        }
    }
}

