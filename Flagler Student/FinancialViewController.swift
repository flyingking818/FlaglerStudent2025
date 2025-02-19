//
//  FinancialViewController.swift
//  Flagler Student
//
//  Created by Jeremy Wang on 2/17/25.
//  Updated your documentation, explain the enhancements



import UIKit

class FinancialViewController: UIViewController {
    
    //Declare the outlets
        
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var tuitionTextField: UITextField!
    @IBOutlet weak var scholarshipTextField: UITextField!
    @IBOutlet weak var gradeLevelTextField: UITextField!
    @IBOutlet weak var honorStudentSwitch: UISwitch!
    @IBOutlet weak var messageLabel: UILabel!  //ouput
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // viewDidLoad is ideal for screen initialization
        honorStudentSwitch.isOn = false
        messageLabel.isHidden = true
    }
    
    
    @IBAction func calculateButton(_ sender: UIButton) {
        //Processing... logic...
       //no check
       // let name = nameTextField.text ?? ""
        
        messageLabel.isHidden = false
        
        // ==================Use Input Validation===============
        // check for nil, empty ("")
        guard let name = nameTextField.text, !name.isEmpty else {
            messageLabel.text = "Please enter your name."
            return
        }
        
        guard let tuitionText = tuitionTextField.text, !tuitionText.isEmpty, let tuition = Double(tuitionText) else {
            messageLabel.text = "Please enter a valid number for tuition."
            return
        }
        
        guard let scholarshipText = scholarshipTextField.text, !scholarshipText.isEmpty, let scholarship = Double(scholarshipText) else {
            messageLabel.text = "Please enter a valid number for scholarship."
            return
        }
        
        guard let gradeLevel = gradeLevelTextField.text, !gradeLevel.isEmpty else {
            messageLabel.text = "Please enter your grade level."
            return
        }
        
        //Processing
        var balance = tuition - scholarship
        
        //Honor student discount
        // + - / *   %-modulus or remainder
        
    
        if honorStudentSwitch.isOn {
            //balance = balance * (1-0.1)
            balance*=0.9
        }
        
        //Apply the grade level discount
        switch gradeLevel.lowercased() {
            case "freshman":
                balance*=1.0
            case "sophomore":
                balance*=0.98
            case "junior":
                balance*=0.97
            case "senior":
                balance*=0.95
            default:
                messageLabel.text = "Invalid grade level"
                break
        }
        
        // If the balance is over $10,000, suggest a loan for student to consider.
        let message: String  //formal declaration with a type
        if balance > 10000 {
            message = "\(name), your estimated balance is \(balance.formatted(.currency(code: "USD"))). You qualify for a student loan."
        } else {
            message = "\(name), your estimated balance is \(balance.formatted(.currency(code: "USD")))"
        }
        
       
        messageLabel.text = message
       
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
