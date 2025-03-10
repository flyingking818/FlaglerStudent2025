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
    
    @IBOutlet weak var loanView: UIView!
    @IBOutlet weak var loanAmountTextField: UITextField!
    @IBOutlet weak var aprTextField: UITextField!
    @IBOutlet weak var yearsTextField: UITextField!
    @IBOutlet weak var pmtMessageLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // viewDidLoad is ideal for screen initialization
        honorStudentSwitch.isOn = false
        messageLabel.isHidden = true
        
        //Hide the loan subview by default
        loanView.isHidden = true
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
            loanView.isHidden = false
            loanAmountTextField.text = String(balance)
            
        } else {
            message = "\(name), your estimated balance is \(balance.formatted(.currency(code: "USD")))"
        }
        
       
        messageLabel.text = message
       
        
        
    }
    
    
    //PMT calculation
    
    @IBAction func calculatePMTButton(_ sender: UIButton) {
        //Calculate by using the PTM function
        //Here, it's better to validate
        let loanAmount = loanAmountTextField.text.flatMap(Double.init) ?? 0
        let apr = aprTextField.text.flatMap(Double.init) ?? 0
        let years = yearsTextField.text.flatMap(Int.init) ?? 0
        
        //let monthlyPayment = PMT(loanAmount: loanAmount, apr: apr, years: years)
        let monthlyPayment = PMT(loanAmount, apr, years)
        
        pmtMessageLabel.text = "Monthly Payment: \(monthlyPayment.formatted(.currency(code: "USD")))"
        pmtMessageLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
        
        
    }
    
    //Make the paramter labels optional by using the underscore
    func PMT (_ loanAmount: Double, _ apr: Double, _ years: Int) -> Double {
        return PMT(loanAmount: loanAmount, apr: apr, years: years)
    }
    
    //This requires the parameter names.
    func PMT (loanAmount: Double, apr: Double, years: Int) -> Double {
        
        //Calculate the periodic rate (monthly)
        let monthlyRate = apr / 100 / 12
        let numberOfPayments = years * 12
        
        let numberator: Double = monthlyRate * pow(1 + monthlyRate, Double(numberOfPayments))
        let denominator: Double = pow(1 + monthlyRate, Double(numberOfPayments)) - 1
        
        let pmt = loanAmount * (numberator / denominator)
        
        /*
        let pmt = loanAmount * monthlyRate * pow(1 + monthlyRate, Double(numberOfPayments)) / (pow(1 + monthlyRate, Double(numberOfPayments)) - 1)
        */
        return pmt
        
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
