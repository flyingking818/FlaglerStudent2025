//
//  LoginViewController.swift
//  Flagler Student
//
//  Created by Jeremy Wang on 4/7/25.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var messageLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageLabel.text = ""
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        // ==================User Input Validation===============
        // check for nil, empty ("")
        guard let email = emailTextField.text, !email.isEmpty else {
            messageLabel.text = "Please enter your email."
            return
        }
        
        guard let password = passwordTextField.text, !password.isEmpty else {
            messageLabel.text = "Please enter your password."
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let e = error {
                self.messageLabel.text = e.localizedDescription
            } else {
                //Navigate to the TabBarController
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                if let tabBarController = storyboard.instantiateViewController(withIdentifier: "MainTabBarController") as? UITabBarController {
                    // Optional: make the transition fullscreen
                    tabBarController.modalPresentationStyle = .fullScreen
                    self.present(tabBarController, animated: true, completion: nil)
                }
            }
        }
    }
    
}



