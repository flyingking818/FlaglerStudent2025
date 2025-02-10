//
//  ViewController.swift
//  Flagler Student
//
//  Created by Jeremy Wang on 1/27/25.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var messageLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func submitButton(_ sender: UIButton) {
        
        messageLabel.text = "Hello world! Thank you for your submission!"
        
    }
    
}

