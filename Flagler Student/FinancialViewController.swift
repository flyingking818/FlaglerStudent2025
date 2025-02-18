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
    }
    
    
    @IBAction func calculateButton(_ sender: UIButton) {
        //Processing... logic...
        
        
        
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
