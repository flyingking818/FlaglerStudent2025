//
//  ViewController.swift
//  Flagler Student
//
//  Created by Jeremy Wang on 1/27/25.
//

import UIKit
import MapKit

class HomeViewController: UIViewController {
    
   
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let flaglerCollegeLocation = CLLocationCoordinate2D(latitude: 29.8928, longitude: -81.3150)
        /*
         latitude: 29.8928 → It’s 29.89° North of the Equator.
         longitude: -81.3150 → It’s 81.31° West of the Prime Meridian.
         */
        
        // Set zoom level (region span)
        /*
        let region = MKCoordinateRegion(center: flaglerCollegeLocation, latitudinalMeters: 10000, longitudinalMeters: 10000)f
        */
        
        let region = MKCoordinateRegion(center: flaglerCollegeLocation, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        /*
         latitudeDelta / longitudeDelta    Zoom Level    Example Usage
         0.01 / 0.01    Very zoomed-in    City block level (detailed)
         0.05 / 0.05    Medium zoom    Covers a small town or district
         0.1 / 0.1    Wider zoom    Covers an entire city
         1.0 / 1.0    Far zoomed-out    Covers a large region or state
         10.0 / 10.0    Extremely zoomed-out    Covers multiple states or countries
         */
        
        // Apply region to the map
        mapView.setRegion(region, animated: true)
        
        //Let's add a pin (annotation) for Flagler
        let annotation = MKPointAnnotation()
        annotation.coordinate = flaglerCollegeLocation
        annotation.title = "Flagler College"
        annotation.subtitle = "The most beautiful college"
        mapView.addAnnotation(annotation)
               
        
    }

    
    @IBAction func submitButton(_ sender: UIButton) {
        
        //Use the same object-oriented programming techniques
        //Access the members of the instantiated objects
        //Optionals!
        
        /*
        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
         */
        
        guard let firstName = firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !firstName.isEmpty,
             let lastName = lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !lastName.isEmpty
        else {
            return showAlert(message: "Both first name and last name are requried!")
        }
                
        //Interpolation is preferred in Swift!
        messageLabel.text = "Welcome to Flagler,\(firstName) \(lastName)! Flagler is beautiful!"
        
    }
    
    //Outside the button function, we'll add a customer function
    func showAlert(message: String) -> Void {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(alertAction)
        present(alertController, animated: true)
    }

    
    
}

