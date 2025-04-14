//
//  CourseDetailViewController.swift
//  Flagler Student
//
//  Created by Jeremy Wang on 4/14/25.
//

import UIKit

class CourseDetailViewController: UIViewController {
    

    var course: CourseModel?  // This will be set from the main list in the previous controller
    
    @IBOutlet weak var courseIDLabel: UILabel!
    @IBOutlet weak var courseNameLabel: UILabel!    
    @IBOutlet weak var creditHoursLabel: UILabel!
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        
        if let course = course {
            courseIDLabel.text = course.courseID
            courseNameLabel.text = course.courseName
            creditHoursLabel.text = "\(course.creditHours) credit hours"
        }

        // Do any additional setup after loading the view.
    }
    
    

   
}
