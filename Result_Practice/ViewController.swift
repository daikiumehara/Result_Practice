//
//  ViewController.swift
//  Result_Practice
//
//  Created by daiki umehara on 2021/05/17.
//

import UIKit

typealias CalcResult<T> = Result<T, CalcError>
enum CalcError: Error {
    case notNumber
    case noneValue
    case differentType
}

class ViewController: UIViewController {

    @IBOutlet var alertLabel: UILabel!
    @IBOutlet var value1TextField: UITextField!
    @IBOutlet var value2TextField: UITextField!
    @IBOutlet var answerLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func buttonDidTapped(_ sender: Any) {
        let result = value1TextField.text! +? value2TextField.text!
        switch result {
        case .success(let value):
            answerLabel.text = "\(value)"
            alertLabel.text = "正しく計算ができたぞ"
        case .failure(let error):
            switch error {
            case .differentType:
                alertLabel.text = "少数と整数は同時に計算できんぞ"
            case .noneValue:
                alertLabel.text = "値を入力するんだ"
            case .notNumber:
                alertLabel.text = "数字じゃないものは計算できんぞ"
            }
        }
    }
    
}

infix operator +? : AdditionPrecedence
func +?(_ lhs: String, _ rhs: String) -> CalcResult<Any> {
    if lhs.isEmpty || rhs.isEmpty {
        return .failure(.noneValue)
    }
    guard Double(lhs) != nil else { return .failure(.notNumber) }
    guard Double(rhs) != nil else { return .failure(.notNumber) }
    if Int(lhs) != nil, Int(rhs) != nil {
        return .success(Int(lhs)! + Int(rhs)!)
    } else if Int(lhs) == nil, Int(rhs) == nil {
        return .success(Double(lhs)! + Double(rhs)!)
    } else {
        return .failure(.differentType)
    }
}
