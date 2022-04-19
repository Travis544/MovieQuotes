//
//  LoginViewController.swift
//  MovieQuotes
//
//  Created by Yuanhang on 4/18/22.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    var loginHandle : AuthStateDidChangeListenerHandle!
    @IBAction func pressedLoginExistingUser(_ sender: Any) {
        let email = emailTextField.text!
        let password=passwordTextField.text!
        AuthManager.shared.loginExistingEmailPasswordUser(email: email, password: password)
        
    }

    @IBAction func pressedNewUser(_ sender: Any) {
        let email = emailTextField.text!
        let password=passwordTextField.text!
        AuthManager.shared.signInNewEmailPasswordUser(email: email, password: password)
        
        
//        {
//            error
//            if let error=error{
//                print("There was an error signing in with email password")
//                return
//            }
//        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loginHandle=AuthManager.shared.addLoginObserver {
            self.performSegue(withIdentifier: "showListSegue", sender: self)
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        AuthManager.shared.removeObserver(loginHandle)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                // Do any additional setup after loading the view.
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
