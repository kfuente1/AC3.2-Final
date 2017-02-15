//
//  LogInViewController.swift
//  AC3.2-Final
//
//  Created by Karen Fuentes on 2/15/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit
import Firebase

class LogInViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var logoImage: UIImageView!
    var user: FIRUser?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.logoImage.image = #imageLiteral(resourceName: "meatly_logo")
    }
    
    //MARK: - Target actions for buttons
    @IBAction func RegisterButtonWasPressed(_ sender: UIButton) {
        registerUser()
    }
    
    @IBAction func LoginButtonWasPressed(_ sender: UIButton) {
        signInUser()
    }
    
    //MARK: Alert Controller Setup
    func showAlert(title: String, message: String?) -> UIAlertController {
    
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
    
        return alertController
    }

    // MARK: - LogIn/Register user to Database
    func signInUser() {
        guard let email = emailTextField.text,
            let password = passwordTextField.text
            else {return}
        
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user , error) in
            if error != nil{
                let alertController = self.showAlert(title: "Login Failed!", message: "Failed to Login. Please Check Your Email and Password!")
                self.present(alertController, animated: true, completion: nil)
                self.emailTextField = nil
                self.passwordTextField = nil
            }else {
                self.user = user
            }
            
        })
    }
    
    
    func registerUser() {
        guard let email = emailTextField.text,
            let password = passwordTextField.text
            else {return}
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
            if error != nil {
                print("OH MAN ERROR CREATING USER: \(error)")
                let alertController = self.showAlert(title: "Signup Failed!", message: "Failed to Register. Please Try Again!")
                self.present(alertController, animated: true, completion: nil)
                self.passwordTextField.text = nil
                self.emailTextField.text = nil
            } else {
                self.user = user
                let alertController = self.showAlert(title: "Signup Successful!", message: "Successfully Registered. Please Login to Use Our App!")
                self.present(alertController, animated: true, completion: nil)
                self.passwordTextField.text = nil
                self.emailTextField.text = nil
            }
        })
    }
    
}

