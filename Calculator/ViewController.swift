//
//  ViewController.swift
//  Calculator
//
//  Created by Vladimir on 11.08.2023.
//

import UIKit

class ViewController: UIViewController {
    
// MARK: IBOutlet
    
    @IBOutlet weak var resultLabel: UILabel!
    
// MARK: Private variables
    
    private var typing = false
    private var dotHasBeenPlaced = false
    
    private var firstNumber: Double = 0
    private var secondNumber: Double = 0
    private var operationSign: String = ""
    
    var currentInput: Double {
        get {
            return Double(resultLabel.text!)!
        }
        
        set {
            let value = "\(newValue)"
            let valueArray = value.components(separatedBy: ".")
            if valueArray[1] == "0" {
                resultLabel.text = "\(valueArray[0])"
            } else {
                resultLabel.text = value
            }
            
            typing = false
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultLabel.text = "What should I count?"
        
        view.backgroundColor = .black
        resultLabel.tintColor = .white
    }
    
// MARK: IBActions
    
    @IBAction func numberPressed(_ sender: UIButton) {
        guard let currentNumber = sender.currentTitle else { return }
        
        if typing {
            if (resultLabel.text?.count ?? 0) < 25 {
                resultLabel.text = resultLabel.text! + String(currentNumber)
            }
        } else {
            resultLabel.text = currentNumber
            typing = true
        }
    }
    
    @IBAction func operationPressed(_ sender: UIButton) {
        guard let currentOperation = sender.currentTitle else { return }
        operationSign = currentOperation
        firstNumber = currentInput
        typing = false
        dotHasBeenPlaced = false
    }
    
    @IBAction func equalityButtonPressed() {
        
        if typing {
            secondNumber = currentInput
        }
        
        dotHasBeenPlaced = false
        
        switch operationSign {
        case "÷":
            operationWithTwoNumbers{$0 / $1}
        case "X":
            operationWithTwoNumbers{$0 * $1}
        case "-":
            operationWithTwoNumbers{$0 - $1}
        case "+":
            operationWithTwoNumbers{$0 + $1}
        default: break
        }
    }
    
    @IBAction func clearButtonPressed() {
        firstNumber = 0
        secondNumber = 0
        currentInput = 0
        resultLabel.text = "0"
        typing = false
        dotHasBeenPlaced = false
        operationSign = ""
    }
    
    @IBAction func plusMinusButtonPressed() {
        currentInput = -currentInput
    }
    
    @IBAction func percentButtonPressed() {
        currentInput = currentInput / 100
        
        typing = false
    }
    
    @IBAction func squareRootButtonPressed() {
        currentInput = sqrt(currentInput)
    }
    
    @IBAction func dotButtonPressed() {
        if typing && !dotHasBeenPlaced {
            resultLabel.text = resultLabel.text! + "."
            dotHasBeenPlaced = true
        } else if !typing && !dotHasBeenPlaced {
            resultLabel.text = "0."
        }
    }

// MARK: Private funktion
    
    private func operationWithTwoNumbers(operation: (Double, Double) -> Double) {
        currentInput = operation(firstNumber, secondNumber)
        typing = false
    }
}
