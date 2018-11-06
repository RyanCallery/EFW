//
//  ViewController.swift
//  EFW
//
//  Created by Ryan Callery on 10/2/18.
//  Copyright © 2018 Ryan Callery. All rights reserved.
//
import Foundation
import UIKit

var weeksInt = 0

class ViewController: UIViewController {

    var tenthPercentLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.borderWidth = 1
        label.textAlignment = .center
        label.text = "10th"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        return label
    }()
    
    var fiftiethPercentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.borderWidth = 1
        label.textAlignment = .center
        label.text = "50th"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        return label
    }()
    
    var ninetiethPercentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.borderWidth = 1
        label.textAlignment = .center
        label.text = "90th"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        return label
    }()
    
    var tenthWeight: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.borderWidth = 1
        label.textAlignment = .center
        return label
    }()
    
    var fiftiethWeight: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
         label.font = UIFont.boldSystemFont(ofSize: 30)
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.borderWidth = 1
        label.textAlignment = .center
        return label
    }()
    
    var ninetiethWeight: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
         label.font = UIFont.boldSystemFont(ofSize: 30)
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.borderWidth = 1
        label.textAlignment = .center
        return label
    }()


    
    let topView: UIView = {
       let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray
        return view
    }()
    
    let stackView1: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray
        return view
    }()
    
    let stackView2: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray
        return view
    }()
    
    let stackView3: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray
        return view
    }()
    
    var gramsToPoundsButton: UIButton = {
       var button = UIButton()
        button.setTitle("G", for: .normal)
        button.backgroundColor = .gray
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(gramsToPounds), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    
   
    var weightStackView = UIStackView()
   
    let gestAgeTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Weeks"
        textField.textAlignment = .center
        textField.backgroundColor = .lightGray 
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1
        textField.keyboardType = .numbersAndPunctuation
        textField.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
        textField.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .editingDidBegin)
        textField.font = UIFont.boldSystemFont(ofSize: 50)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gestAgeTextField.delegate = self
   
        setUpViews()
        
    }
    func addWeeksAlert() {
        tenthWeight.text = ""; fiftiethWeight.text = ""; ninetiethWeight.text = ""
        let weeksAlert = UIAlertController(title: "Not available", message: "You can only enter weeks between 24 and 42", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        weeksAlert.addAction(cancelAction)
        present(weeksAlert, animated: true)
    }
    
    func addGramsToPoundsAlert() {
        let weightAlert = UIAlertController(title: "Enter weeks", message: "You must enter something for gestational weeks", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        weightAlert.addAction(action)
        present(weightAlert, animated: true)
    }
    
    @objc func gramsToPounds(){
        print("converter working")
        if gestAgeTextField.text == nil || gestAgeTextField.text == "" {
            print("alert working")
            addGramsToPoundsAlert()
            return
        }
        if Int(gestAgeTextField.text!)! < 24 || Int(gestAgeTextField.text!)! > 42 {
            addWeeksAlert()
            return
        }
        if grams  {
            let tenthWeightInPounds = convertToPounds(tenthWeight.text!)
            let fiftiethWeightInPounds = convertToPounds(fiftiethWeight.text!)
            let ninetiethWeightInPounds = convertToPounds(ninetiethWeight.text!)
            
            tenthWeight.text = tenthWeightInPounds
            fiftiethWeight.text = fiftiethWeightInPounds
            ninetiethWeight.text = ninetiethWeightInPounds
            gramsToPoundsButton.setTitle("lb.", for: .normal)
            grams = false
        } else {
            guard weeksInt >= 24 && weeksInt <= 42 else {return}
            let weightArray = gestationalWeight[weeksInt]
            tenthWeight.text = String(weightArray![tenth])
            fiftiethWeight.text = String(weightArray![fiftieth])
            ninetiethWeight.text = String(weightArray![ninetieth])
            gramsToPoundsButton.setTitle("G", for: .normal)
            grams = true
            
        }
    }
    
    func convertToPounds(_ weight: String) -> String {
        var string = ""
        
        guard let weightDouble = Double(weight) else {return "weight is nil"}
        let weightConvertedToPounds = poundsConverter(weightDouble)
        let weightConvertedToPoundsAsInt = Int(weightConvertedToPounds)
        let weightConvertedToPoundsAsIntAsDouble = Double(weightConvertedToPoundsAsInt)
        let remainder = weightConvertedToPounds - weightConvertedToPoundsAsIntAsDouble
        let ounces = poundsToOunces(remainder).rounded()
        let ouncesInt = Int(ounces)
        string = "\(weightConvertedToPoundsAsInt) lb \(ouncesInt) oz"
        return string
    }
    
    func poundsConverter(_ weight: Double) -> Double {
        var double = 1.0
        double = weight / 454
        return double
    }
    
    func poundsToOunces( _ weight: Double) -> Double {
        var double = 1.0
        double = weight * 16
        return double
    }
    

    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == "" {
            return
        }

        guard let textField = textField.text else {return }
        gramsToPoundsButton.setTitle("G", for: .normal)
        let textFieldAsInt = Int(textField)!
        weeksInt = Int(textField)!
        if textFieldAsInt <= 42 && textFieldAsInt >= 24 {
        let weightArray = gestationalWeight[textFieldAsInt]
        tenthWeight.text = String(weightArray![tenth])
        fiftiethWeight.text = String(weightArray![fiftieth])
        ninetiethWeight.text = String(weightArray![ninetieth])
        } else {
            addWeeksAlert()
        }
        
}
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
        tenthWeight.text = ""; fiftiethWeight.text = ""; ninetiethWeight.text = ""
    }
        
    }


    

extension ViewController {
    
    func setUpViews() {

        let safeArea = view.safeAreaLayoutGuide
        weightStackView = UIStackView(arrangedSubviews: [stackView1, stackView2, stackView3])
        weightStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(topView)
        topView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        topView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        topView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        topView.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 1/3).isActive = true
        topView.addSubview(gestAgeTextField)
        topView.addSubview(gramsToPoundsButton)
        gestAgeTextField.centerXAnchor.constraint(equalTo: topView.centerXAnchor).isActive = true
        gestAgeTextField.centerYAnchor.constraint(equalTo: topView.centerYAnchor).isActive = true
        gestAgeTextField.heightAnchor.constraint(equalTo: topView.heightAnchor, multiplier: 3/4).isActive = true
        gestAgeTextField.widthAnchor.constraint(equalTo: topView.widthAnchor, multiplier: 2/3).isActive = true
        gramsToPoundsButton.rightAnchor.constraint(equalTo: topView.rightAnchor).isActive = true
        gramsToPoundsButton.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -5).isActive = true
        gramsToPoundsButton.leftAnchor.constraint(equalTo: gestAgeTextField.rightAnchor, constant: 5).isActive = true
        gramsToPoundsButton.topAnchor.constraint(equalTo: gestAgeTextField.bottomAnchor, constant: 5).isActive = true
        view.addSubview(weightStackView)
        weightStackView.axis = .vertical
        weightStackView.distribution = .fillEqually
        weightStackView.backgroundColor = .red
        weightStackView.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        weightStackView.leftAnchor.constraint(equalTo: safeArea.leftAnchor).isActive = true
        weightStackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        weightStackView.rightAnchor.constraint(equalTo: safeArea.rightAnchor).isActive = true
        setUpStack()
        
        
    }
    

    
    func setUpStack() {
        
        addSubviewsConstraints(stackView1, views: [tenthPercentLabel, tenthWeight])
        addSubviewsConstraints(stackView2, views: [fiftiethPercentLabel, fiftiethWeight])
        addSubviewsConstraints(stackView3, views: [ninetiethPercentLabel, ninetiethWeight])
       
    }
    
    func addSubviewsConstraints( _ superview : UIView, views: [UIView]) {
        for (index, view) in views.enumerated() {
            superview.addSubview(view)
            if index == 0 {
                view.topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
                view.leftAnchor.constraint(equalTo: superview.leftAnchor).isActive = true
                view.bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
                view.widthAnchor.constraint(equalTo: superview.widthAnchor, multiplier: 1/3).isActive = true
            } else {
                view.topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
                view.rightAnchor.constraint(equalTo: superview.rightAnchor).isActive = true
                view.bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
                view.widthAnchor.constraint(equalTo: superview.widthAnchor, multiplier: 2/3).isActive = true
            }
            
            
        }
        
    }
    
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()

        return true
    }
    
  
    

}
