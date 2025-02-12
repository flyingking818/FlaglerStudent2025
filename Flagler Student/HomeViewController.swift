//
//  ViewController.swift
//  Flagler Student
//
//  Created by Jeremy Wang on 1/27/25.
//

import UIKit

class HomeViewController: UIViewController {
    
   
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func submitButton(_ sender: UIButton) {
        
        //Use the same object-oriented programming techniques
        //Access the members of the instantiated objects
        
        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        
        //Interpolation is preferred in Swift!
        messageLabel.text = "Welcome to Flagler,\(firstName) \(lastName)! Flagler is beautiful!"
        
        
    }
    
    
}

