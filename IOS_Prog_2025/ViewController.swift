//
//  ViewController.swift
//  IOS_Prog_2025
//
//  Created by user279431 on 11/18/25.
//

import UIKit
import Foundation

extension String
{
    subscript(index: Int) -> Character
    {
        let requiredIndex = self.index(startIndex, offsetBy: index)
        return self[requiredIndex]
    }
}

class ViewController: UIViewController {

    
    
    @IBOutlet weak var CalcBufer: UILabel!
    @IBOutlet weak var CalcResult: UILabel!
    //@IBOutlet weak var BufferLabel: UILabel!
    //@IBOutlet weak var ResultLabel: UILabel!
    
    var curBuffer:String = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        clearAll()
        // Do any additional setup after loading the view.
    }
    
    func clearBuffer()
    {
        curBuffer = ""
        CalcBufer.text = ""
    }

    func clearAll()
    {
        curBuffer = ""
        CalcBufer.text = ""
        CalcResult.text = ""
    }
    
    func appendBuffer(val: String)
    {
        curBuffer += val
        CalcBufer.text = curBuffer
    }
    
    @IBAction func ClearAll(_ sender: Any)
    {
        clearAll()
    }
    
    @IBAction func Confirm(_ sender: Any)
    {
        /*
        var buffer = curBuffer
        //percentage
        buffer = buffer.replacingOccurrences(of: "%", with: "*0.01") <#T##StringProtocol#>)
        
        let expression = NSExpression(format: curBuffer)
        var returnValue = expression.expressionValue(with: nil, context: nil) as! Double
        returnValue = round(returnValue)
        CalcResult.text = String(format: "%.0f", returnValue)
        clearBuffer()
         */
        var numberBuffer = ""
        var result:Double = 0
        var isNegative = false
        
        var stashedExpression = ""
        var secondNumber:Double = 0
        
        //
        var i = 0
        //check starting -
        
        //if starts by expression then use last result as base
        if i < curBuffer.count && isOperator(char: curBuffer[i])
        {
            stashedExpression = String(curBuffer[i])
            result = Double(CalcResult.text!)!
            i += 1
        }
        else
        {
            /*
            while curBuffer[i] == "-" {
                isNegative = !isNegative
                i += 1
            }
            */
            while i < curBuffer.count && !isOperator(char: curBuffer[i])
            {
                numberBuffer += String(curBuffer[i])
                i += 1
            }
            //convert first string to actual number
            result = Double(numberBuffer)!
            numberBuffer = ""
            
            if (isNegative)
            {
                result = -result
                isNegative = false
            }
        }

        
        //start doing actual expressions
        
        while i < curBuffer.count
        {
            if isOperator(char: curBuffer[i])
            {
                //if loaded some number, then convert it
                if numberBuffer.count > 0
                {
                    secondNumber = Double(numberBuffer)!
                    numberBuffer = ""
                }
                
                //if no stashed expression add to stash
                if stashedExpression.count == 0
                {
                    stashedExpression = String(curBuffer[i])
                }
                else //some expression stashed, evaluate
                {
                    result = evaluateExpression(expr: stashedExpression[0], first: result, second: secondNumber)
                    stashedExpression = String(curBuffer[i])
                }
            }
            else
            {
                numberBuffer += String(curBuffer[i])
            }
            
            i += 1
            /*
            while i < curBuffer.count && curBuffer[i] == "-" {
                isNegative = !isNegative
                i += 1
            }
            */
        }
        
        //if loaded some number, then convert it
        if numberBuffer.count > 0
        {
            secondNumber = Double(numberBuffer)!
            numberBuffer = ""
        }
        
        //evaluate last operator if still exists some
        if stashedExpression.count > 0
        {
            print(stashedExpression)
            result = evaluateExpression(expr: stashedExpression[0], first: result, second: secondNumber)
            stashedExpression = ""
        }
        
        //convert result back to string and display
        clearBuffer()
        CalcResult.text = String(result)
    }
    
    func evaluateExpression(expr: Character, first: Double, second: Double) -> Double
    {
        if (expr == "+")
        {
            return first + second
        }
        if (expr == "-")
        {
            return first - second
        }
        if (expr == "*")
        {
            return first * second
        }
        if (expr == "/")
        {
            return first / second
        }
        if (expr == "^")
        {
            return pow(first, second)
        }
        return 0
    }
    
    func evaluateInstantExpression(expr: Character, first: Double) -> Double
    {
        if (expr == "%")
        {
            return first * 0.01
        }
        if (expr == ")") //log
        {
            return log(first)
        }
        return first
    }
    
    func isOperator(char: Character) -> Bool
    {
        if (char == "+" || char == "-" || char == "*" || char == "/" || char == "%" || char == ")" || char == "^" )
        {
            return true
        }
        return false
    }
    
    //*
    func TryAddOperator(oper: String)
    {
        //if last is not operator then add operator
        if (curBuffer.count <= 0 || !isOperator(char: curBuffer.last!)) //here change for second last if wants spaces
        {
            appendBuffer(val: oper)
        }
    }
    //*/
    
    func TryAddOperator(prefix: String, operator: Character)
    {
        
    }
    
    @IBAction func Addition(_ sender: Any)
    {
        TryAddOperator(oper: "+")
    }
    
    @IBAction func Subtraction(_ sender: Any)
    {
        appendBuffer(val: "-")
    }
    
    @IBAction func Multiplication(_ sender: Any)
    {
        TryAddOperator(oper: "*")
    }
    
    @IBAction func Division(_ sender: Any)
    {
        TryAddOperator(oper: "/")
    }
    
    @IBAction func Percentage(_ sender: Any)
    {
        TryAddOperator(oper: "%")
    }
    
    @IBAction func Logarithm(_ sender: Any)
    {
        TryAddOperator(oper: ")")
        //if
        //curBuffer = "log(" + curBuffer + ")"
        //CalcBufer.text = curBuffer
        //appendBuffer(val: " + ")
    }
    
    @IBAction func Power(_ sender: Any)
    {
        appendBuffer(val: "^")
    }
    
    //-------------------------------------------------------------
    
    
    @IBAction func Zero(_ sender: Any)
    {
        appendBuffer(val: "0")
    }
    
    @IBAction func One(_ sender: Any)
    {
        appendBuffer(val: "1")
    }
    
    @IBAction func Two(_ sender: Any)
    {
        appendBuffer(val: "2")
    }
    
    @IBAction func Three(_ sender: Any)
    {
        appendBuffer(val: "3")
    }
    
    @IBAction func Four(_ sender: Any)
    {
        appendBuffer(val: "4")
    }
    
    @IBAction func Five(_ sender: Any)
    {
        appendBuffer(val: "5")
    }
    
    @IBAction func Six(_ sender: Any)
    {
        appendBuffer(val: "6")
    }
    
    @IBAction func Seven(_ sender: Any)
    {
        appendBuffer(val: "7")
    }
    
    @IBAction func Eight(_ sender: Any)
    {
        appendBuffer(val: "8")
    }
    
    @IBAction func Nine(_ sender: Any)
    {
        appendBuffer(val: "9")
    }
}

