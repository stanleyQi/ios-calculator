//
//  ViewController.swift
//  calculator
//
//  Created by liqi on 22/09/19.
//  Copyright © 2019 liqi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var expression:String = "" 
    var result:String = ""
    
    let symbols = ["+","-","*","/"]
    
    @IBOutlet weak var input: UILabel!
    @IBOutlet weak var output: UILabel!
    
    @IBAction func inputNumber(_ sender: UIButton) {
        //validate:the lenght of the string expression is legal
        guard expression.count <= 15 else { return }
        
        //validate:can not be divided by 0
        if getTheLastChar(expression) == "/" && sender.tag == 0 { return }
        
        //concat the input string to expression
        expression += String(sender.tag)
        input.text = expression
    }
    
    @IBAction func inputSymble(_ sender: UIButton) {
        //validate:the prior letter should be a digit
        guard isPurnInt(string: getTheLastChar(expression)) else{
            return
        }
        
        //concat the input string to expression
        expression += sender.currentTitle ?? ""
        input.text = expression
    }
    
    @IBAction func calculate(_ sender: UIButton) {
        //validate:the last letter of the expression should not be a symbol
        guard !symbols.contains(getTheLastChar(expression)) else{
            return
        }
        
        //perform calculation
        let preSymbol:String  = getTheLastChar(expression)
        if expression != "" && !symbols.contains(preSymbol) {
            let expn = NSExpression(format: expression)
            output.text = "\(expn.expressionValue(with: nil, context: nil) ?? 0)"
            expression = ""
            input.text = (input.text ?? "") + "="
        }
    }
    
    @IBAction func reset(_ sender: UIButton) {
        expression = ""
        input.text = ""
        output.text = ""
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    private func getTheLastChar(_ str:String) -> String{
        var lastChar:String = ""
        if str != "" {
            lastChar = String(str[str.index(before: str.endIndex)])
        }
        return lastChar
    }
    
    private func isPurnInt(string: String) -> Bool {
        let scan: Scanner = Scanner(string: string)
        var val:Int = 0
        return scan.scanInt(&val) && scan.isAtEnd
    }
}

