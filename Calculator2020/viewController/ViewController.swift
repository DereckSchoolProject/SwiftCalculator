//
//  ViewController.swift
//  Calculator2020
//
//  Created by Service Informatique on 26/10/2020.
//  Copyright © 2020 MDS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var resultStackTextView: UITextView!
    var resultStack : [String] = [String]()
    var result : String = ""
    
    @IBAction func clickButton(_ sender: UIButton) {
        let saisie = sender.titleLabel?.text!
        
        if  saisie == "C" {
            resultStack = []
            result = ""
            resultLabel.text = "0"
            resultStackTextView.text = displayResult()
        } else if saisie == "=" {
            resultStack.append(result)
            resultStackTextView.text = displayResult()
            result = ""
            resultLabel.text = "\(calc())"
        } else if saisie == "+" || saisie == "-" || saisie == "/" || saisie == "X" {
            operatorClick(oper: saisie!)
            resultStackTextView.text = displayResult()
        } else if (saisie == "0" || saisie == "1" || saisie == "2" || saisie == "3" || saisie == "4" || saisie == "5" || saisie == "6" || saisie == "7" || saisie == "8" || saisie == "9" || saisie == ".") {
            numberClick(number: saisie!)
            resultStackTextView.text = displayResult()
        }
    }
    
    func numberClick(number:String) {
        result += number
        resultLabel.text = result
    }
    
    func operatorClick(oper:String) {
        if (result == "") {
            result = resultStack[resultStack.count - 2]
        }
        resultStack.append(result)
        resultStack.append(oper)
        result = ""
    }
    
    func calc() -> Double {
        while resultStack.count > 1 {
            for x in 0...resultStack.count {
                if (resultStack.count == 1) {
                    break
                }
                
                let item = resultStack[x]
                
                if (item == "X" || item == "/" || item == "+" || item == "-") {
                    let n1 = Double(resultStack[x - 1])!
                    let n2 = Double(resultStack[x + 1])!
                    if (item == "X") {
                        resultStack[x] = String(n1 * n2)
                        resultStack.remove(at: x + 1)
                        resultStack.remove(at: x - 1)
                        break
                    } else if (item == "/") {
                        resultStack[x] = String(n1 / n2)
                        resultStack.remove(at: x + 1)
                        resultStack.remove(at: x - 1)
                        break
                    } else if (item == "+") {
                        resultStack[x] = String(n1 + n2)
                        resultStack.remove(at: x + 1)
                        resultStack.remove(at: x - 1)
                        break
                    } else if (item == "-") {
                        resultStack[x] = String(n1 - n2)
                        resultStack.remove(at: x + 1)
                        resultStack.remove(at: x - 1)
                        break
                    } /* else if (item == "%") {
                        resultStack[x] = String(n1 % n2)
                        resultStack.remove(at: x + 1)
                        resultStack.remove(at: x - 1)
                        break
                    } */
                }
            }
        }
        
        result = resultStack[0]
        resultStack.remove(at: 0)
        return Double(result)!
    }
    
    func displayResult() -> String {
        var result = ""
        for x in resultStack {
            result += "\(x) "
        }
        return result
    }
}

