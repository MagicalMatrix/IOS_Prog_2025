//
//  ViewController.swift
//  IOS_Prog_2025
//
//  Created by user279431 on 11/18/25.
//

import UIKit

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
        var buffer = curBuffer
        var numberBuffer = ""
        var result = 0
        var wasLastOperator = false
        var isNegative = false
        
        //
        var i = 0
        //check starting -
        while curBuffer[i] == "-" {
            isNegative = !isNegative
            i += 1
        }
        while !isOperator(char: curBuffer[i])
        {
            numberBuffer += String(curBuffer[i])
            i += 1
        }
        //convert first string to actual number
        result = Int(numberBuffer)!
        numberBuffer = ""
        
        if (isNegative)
        {
            result = -result
            isNegative = false
        }
        
        /*
        for char in curBuffer
        {
            //ignore logarithm heading
            if (char == "l" || char == "o" || char == "g" || char == "(")
            {
                continue
            }
            //if not operator add to numberBuffer
            if(!isOperator(char: char))
            {
                numberBuffer += String(char)
            }
            else //is an operator, evaluate
            {
                var addedValue = Int(numberBuffer)
                numberBuffer = ""
                
                
            }
        }
        */
        
        
        //convert result back to string and display
        clearBuffer()
        CalcResult.text = String(format: "%.0f", result)
    }
    
    func evaluateExpression(expr: Character, first: Int, second: Int) -> Int
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
        return 0
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
        if (!isOperator(char: curBuffer.last!)) //here change for second last if wants spaces
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
        appendBuffer(val: "+")
    }
    
    @IBAction func Subtraction(_ sender: Any)
    {
        appendBuffer(val: "-")
    }
    
    @IBAction func Multiplication(_ sender: Any)
    {
        appendBuffer(val: "*")
    }
    
    @IBAction func Division(_ sender: Any)
    {
        appendBuffer(val: "/")
    }
    
    @IBAction func Percentage(_ sender: Any)
    {
        appendBuffer(val: " % ")
    }
    
    @IBAction func Logarithm(_ sender: Any)
    {
        curBuffer = "log(" + curBuffer + ")"
        CalcBufer.text = curBuffer
        //appendBuffer(val: " + ")
    }
    
    @IBAction func Power(_ sender: Any)
    {
        appendBuffer(val: " ^ ")
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

