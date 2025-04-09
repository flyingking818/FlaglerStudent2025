//
//  AcademicsViewController.swift
//  Flagler Student
//
//  Created by Jeremy Wang on 3/10/25.
//

import UIKit
import Firebase
import FirebaseFirestore

class AcademicsViewController: UIViewController {

    //This is our course data model
    struct Course {
        var courseID: String
        var courseName: String
        var creditHours: Int
    }
    
    
    @IBOutlet weak var courseIDTextField: UITextField!
    @IBOutlet weak var courseNameTextField: UITextField!
    @IBOutlet weak var creditHoursTextField: UITextField!
    @IBOutlet weak var statusLabel: UILabel!
    
    //Instantiate the Firebase DB
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statusLabel.text = ""

        // Do any additional setup after loading the view.
    }
    
    //The custom Add Course Function
    @IBAction func addCoursePressed(_ sender: UIButton) {
        guard let courseID = courseIDTextField.text, !courseID.isEmpty else {
            statusLabel.text = "Please enter a valid course ID."
            return
        }
        
        guard let courseName = courseNameTextField.text, !courseName.isEmpty else {
            statusLabel.text = "Please enter a valid course name."
            return
        }
        
        guard let creditText = creditHoursTextField.text, let creditHours = Int(creditText) else {
            statusLabel.text = "Please enter a valid number for credit hours."
            return
        }
        
        db.collection("Courses").addDocument(data: [
            "CourseID": courseID,
            "CourseName": courseName,
            "CreditHours": creditHours,
            "Date": Date().timeIntervalSince1970
        ]) { error in
            if let e = error {
                print("There was an issue saving course to Firestore: \(e)")
                self.statusLabel.text = "Failed to save course."
                self.statusLabel.textColor = .systemRed
            } else {
                print("Successfully saved course.")
                self.statusLabel.text = "Course added successfully!"
                self.statusLabel.textColor = .systemGreen
                self.clearFields()
            }
        }
    }
    
    
    private func clearFields() {
        courseIDTextField.text = ""
        courseNameTextField.text = ""
        creditHoursTextField.text = ""
    }


}
