//
//  CourseListViewController.swift
//  Flagler Student
//
//  Created by Jeremy Wang on 4/14/25.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth


class CourseListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {

    
    private let cellIdentifier = "CourseCell"
    var courses: [CourseModel] = []
    let db = Firestore.firestore()
    

    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self   // << Required for swipe actions
        loadCourses()
        // Do any additional setup after loading the view.
    }
    
    /*
     A closure in Swift is a block of code that can be passed around and executed later. Think of it as an inline, self-contained function. Closures can capture and store references to variables and constants from the context in which they're defined.
     
     When you call .getDocuments { (querySnapshot, error) in ... }, you are providing a block of code that will execute after the documents are fetched from Firestore. This means the Firestore API does its work in the background and then "calls back" this code with the results.
     */
    
    func loadCourses() {
        guard let currentUserID = Auth.auth().currentUser?.uid else {
            print("No authenticated user.")
            return
        }
        
        db.collection("Courses")
            .whereField("UserID", isEqualTo: currentUserID)   //Added the where clause for filtering
            .order(by: "Date")
            .getDocuments { (querySnapshot, error) in
                
                if let e = error as NSError? {
                    print("There was an issue retrieving courses from Firestore. \(e.localizedDescription)")
                } else {
                    if let snapshotDocuments = querySnapshot?.documents {
                        for doc in snapshotDocuments {
                            let data = doc.data()
                            if let courseID = data["CourseID"] as? String,
                               let courseName = data["CourseName"] as? String,
                               let creditHours = data["CreditHours"] as? Int {
                                let newCourse = CourseModel(
                                    courseID: courseID,
                                    courseName: courseName,
                                    creditHours: creditHours,
                                    currentUserID: currentUserID // inject current user ID
                                )
                                self.courses.append(newCourse)
                            }
                        }
                        
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                }
            }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CourseCell", for: indexPath)
        let course = courses[indexPath.row]
        cell.textLabel?.text = "\(course.courseID): \(course.courseName) (\(course.creditHours) credits)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)-> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, view, completionHandler) in
            
            guard let self = self else { return }
            guard let currentUserID = Auth.auth().currentUser?.uid else {
                print("No authenticated user.")
                completionHandler(false)
                return
            }
            
            let courseToDelete = self.courses[indexPath.row]
            
            // Attempt to delete from Firestore
            self.db.collection("Courses")
                .whereField("CourseID", isEqualTo: courseToDelete.courseID)
                .whereField("UserID", isEqualTo: currentUserID)  // restrict deletion to owner
                .getDocuments { (snapshot, error) in
                    if let error = error {		
                        print("Error finding course to delete: \(error.localizedDescription)")
                        completionHandler(false)
                    } else {
                        for doc in snapshot!.documents {
                            doc.reference.delete()
                        }
                        
                        // Remove from local array and table view
                        self.courses.remove(at: indexPath.row)
                        tableView.deleteRows(at: [indexPath], with: .automatic)
                        completionHandler(true)
                    }
                }
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCourse = courses[indexPath.row]
        
        // Create and present the detail view controller
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailVC = storyboard.instantiateViewController(withIdentifier: "CourseDetailViewController") as? CourseDetailViewController {
            detailVC.course = selectedCourse
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }


}
