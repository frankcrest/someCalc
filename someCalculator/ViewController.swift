//
//  ViewController.swift
//  someCalculator
//
//  Created by Frank Chen on 2019-09-24.
//  Copyright © 2019 Frank Chen. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    var operating = false
    var temp = 0.0
    var total = 0.0
    var operation = Operation.none
    
    //use to layout button text
    let row1 = ["AC","+-","%","/"]
    let row2 = ["7","8","9","*"]
    let row3 = ["4","5","6","-"]
    let row4 = ["1","2","3","+"]
    let row5 = ["0","0",".","="]
    
    //check
    let numbers = ["1","2","3","4","5","6","7","8","9","0"]
    let operators = ["+-","%","/","*","-","+"]
    
    enum Operation{
        case add,sub,mul,div,none
    }
    
    let resultLabel: UILabel = {
        let l = UILabel()
        l.textColor = .white
        l.backgroundColor = .black
        l.textAlignment = .right
        l.font = UIFont.systemFont(ofSize: 60)
        l.text = "0"
        return l
    }()
    
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution = .fillEqually
        return sv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        // Do any additional setup after loading the view.
    }
    
    func setupViews(){
        self.view.backgroundColor = .white
        
        self.view.addSubview(resultLabel)
        self.view.addSubview(stackView)
        
        createStackViews()
        
        resultLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.view)
            make.leading.equalTo(self.view)
            make.trailing.equalTo(self.view)
            make.height.equalTo(200)
        }
        
        stackView.snp.makeConstraints { (make) in
            make.top.equalTo(resultLabel.snp.bottom)
            make.leading.equalTo(self.view)
            make.trailing.equalTo(self.view)
            make.bottom.equalTo(self.view)
        }
    }
    
    func createStackViews(){
        for i in 0...4{
            let sv = UIStackView()
            sv.tag = i
            createButtons(sv: sv)
            sv.backgroundColor = .red
            sv.axis = .horizontal
            sv.distribution = .fillEqually
            self.stackView.addArrangedSubview(sv)
        }
    }
    
    func createButtons(sv: UIStackView){
        for i in 0...3{
            let b = UIButton()
            b.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
            b.tag = i
            switch sv.tag{
            case 0:
                b.setTitle(row1[i], for: .normal)
            case 1:
                b.setTitle(row2[i], for: .normal)
            case 2:
                b.setTitle(row3[i], for: .normal)
            case 3:
                b.setTitle(row4[i], for: .normal)
            case 4:
                b.setTitle(row5[i], for: .normal)
            default:
                b.setTitle("default", for: .normal)
            }
            b.backgroundColor = .darkGray
            b.setTitleColor(.white, for: .normal)
            sv.addArrangedSubview(b)
        }
    }
    
    @objc func buttonPressed(_ sender: UIButton){
        
        guard let buttonText = sender.titleLabel?.text else {return}
        
        //check if pressed number
        if numbers.contains(buttonText){
            if operating{
                resultLabel.text = buttonText
                operating = false
            } else{
                if resultLabel.text?.first == "0"{
                    resultLabel.text?.remove(at: resultLabel.text!.startIndex)
                }
                resultLabel.text?.append(buttonText)
            }
        }else if operators.contains(buttonText){
            operating = true
            guard let number = resultLabel.text else {return}
            temp = Double(number) as! Double
            switch buttonText{
            case "+":
                operation = Operation.add
            case "-":
                operation = Operation.sub
            case "/":
                operation = Operation.div
            case "*":
                operation = Operation.mul
            default:
                operation = Operation.none
            }
        }else if buttonText == "="{
            operating = true
            guard let number = resultLabel.text else {return}
            let num2 = Double(number) as! Double
            switch operation{
            case .add:
                total = temp + num2
                resultLabel.text = String(total)
            case .div:
                total = temp / num2
                resultLabel.text = String(total)
            case .mul:
                total = temp * num2
                resultLabel.text = String(total)
            case .sub:
                total = temp - num2
                resultLabel.text = String(total)
            case .none:
                print("no operation")
            }
        }else if buttonText == "AC"{
            operating = false
            operation = Operation.none
            resultLabel.text = "0"
        }else if buttonText == "."{
            if operating{
                resultLabel.text = buttonText
                operating = false
            }else{
                if (resultLabel.text?.contains("."))!{
                }else{
                    resultLabel.text?.append(buttonText)
                }
            }
        }
    }
    
    
    
    
    
}

