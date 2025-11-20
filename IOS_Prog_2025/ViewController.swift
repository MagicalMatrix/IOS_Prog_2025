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
        var numberBuffer = ""
        var result:Double = 0
        var minusNum = 0
        
        var stashedExpression = ""
        var secondNumber:Double = 0
        
        //
        var i = 0
        
        curBuffer = curBuffer.replacingOccurrences(of: "log(", with: "")
        
        //if starting by operator
        if i < curBuffer.count && isOperator(char: curBuffer[i])
        {
            result = Double(CalcResult.text!)!
            
            //if starts by instant expression evaluate it on result
            while i < curBuffer.count && isInstantOperator(char: curBuffer[i])
            {
                result = evaluateInstantExpression(expr: curBuffer[i], first: result)
                i += 1
            }
            
            //if starts by expression then use last result as base
            if i < curBuffer.count && isOperator(char: curBuffer[i])
            {
                stashedExpression = String(curBuffer[i])
                i += 1
                /*
                if curBuffer[i] == "-"
                {
                    minusNum += 1
                }
                 */
            }
            
            //if counted more than one minus, stop counting it as operator
            while i < curBuffer.count && curBuffer[i] == "-"
            {
                minusNum += 1
                i += 1
            }

        }
        else //if not starting by opeator
        {

            while i < curBuffer.count && !isOperator(char: curBuffer[i])
            {
                numberBuffer += String(curBuffer[i])
                i += 1
            }
            //convert first string to actual number
            result = Double(numberBuffer)!
            numberBuffer = ""
            
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
                    
                    if minusNum % 2 == 1
                    {
                        print(secondNumber)
                        secondNumber *= -1
                        print(secondNumber)
                    }
                    minusNum = 0
                }
                
                //if counted more than one minus, stop counting it as operator
                if stashedExpression.count > 0 && curBuffer[i] == "-"
                {
                    minusNum += 1
                    if minusNum > 0
                    {
                        i += 1
                        continue
                    }
                }
                
                //*
                //if something in the stash
                if stashedExpression.count > 0
                {
                    result = evaluateExpression(expr: stashedExpression[0], first: result, second: secondNumber)
                    //stashedExpression = String(curBuffer[i])
                }
                if isInstantOperator(char: curBuffer[i])
                {
                    result = evaluateInstantExpression(expr: curBuffer[i], first: result)
                }
                else //operator not instant, add to stash
                {
                    stashedExpression = String(curBuffer[i])
                }
                //*/
                
            }
            else
            {
                numberBuffer += String(curBuffer[i])
            }
            
            i += 1
        }
        
        //if loaded some number, then convert it
        if numberBuffer.count > 0
        {
            secondNumber = Double(numberBuffer)!
            numberBuffer = ""
            
            if minusNum % 2 == 1
            {
                print(secondNumber)
                secondNumber *= -1
                print(secondNumber)
            }
            minusNum = 0
        }
        
        //evaluate last operator if still exists some
        if stashedExpression.count > 0
        {
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
    
    func isInstantOperator(char: Character) -> Bool
    {
        if (char == "%" || char == ")")
        {
            return true
        }
        return false
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
        if (curBuffer.count <= 0 || isInstantOperator(char: curBuffer.last!) || !isOperator(char: curBuffer.last!)) //here change for second last if wants spaces
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
        if (curBuffer.count <= 0 || isInstantOperator(char: curBuffer.last!) || !isOperator(char: curBuffer.last!))
        {
            curBuffer = "log(" + curBuffer + ")"
            CalcBufer.text = curBuffer
        }
        //TryAddOperator(oper: ")")
        //if
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

