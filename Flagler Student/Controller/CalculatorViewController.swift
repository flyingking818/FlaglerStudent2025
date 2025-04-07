//
//  CalculatorViewController.swift
//  Flagler Student
//
//  Created by Jeremy Wang on 3/10/25.
//

import UIKit

class CalculatorViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var displayLabel: UILabel!
    
    // MARK: - Properties
    private var userIsTyping = false  // tracks if user is in the middle of typing digits
    
    //Computed property/custom property
    //Let's remove the trailing 0
    private var displayValue: Double {
        get {
            return Double(displayLabel.text!) ?? 0
        }
        set{
            if floor(newValue) == newValue {
                displayLabel.text = String(Int(newValue))
            }else{
                displayLabel.text = String(newValue)
            }
        }
        
    }
    
    // MARK: - Object instantiation
    private var calculator = CalculatorModel()
    
      
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        displayLabel.text = "0"
    }
    
    // MARK: - IBActions
    
    /// Handle the digits
    @IBAction func digitPressed(_ sender: UIButton) {
        guard let digit = sender.currentTitle else { return } //Grab the face value of the button
        
        //If the user is typing, then append the digit to the screen text. If not, set it to the new number text.
        if userIsTyping {
            displayLabel.text?.append(digit)
        } else {
            displayLabel.text = digit
            userIsTyping = true    //MAKE SURE TO RESET THIS FLAG!
        }
        
    }
    
    
    /// Handle the operators +, -, *, /, =
    @IBAction func operationPressed(_ sender: UIButton) {
        guard let operationSymbol = sender.currentTitle else { return }
        
        // When the user presses an operator, we first set or calculate with the current display value
        if operationSymbol == "=" {
            // Complete the current operation, using the service from the model
            if let result = calculator.calculateResult(with: displayValue) {
                displayValue = result
            }
        } else {
            // For +, -, ×, ÷
            if let result = calculator.setOperation(with: displayValue, operation: operationSymbol) {
                displayValue = result
            }
        }
        
        // Reset typing state after an operator is pressed
        userIsTyping = false
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
