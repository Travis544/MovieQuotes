//
//  LoginViewController.swift
//  MovieQuotes
//
//  Created by Yuanhang on 4/18/22.
//

import UIKit
import Firebase
import FirebaseCore
import GoogleSignIn
class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    var loginHandle : AuthStateDidChangeListenerHandle!
    var rosefireName : String?
    @IBAction func pressedLoginExistingUser(_ sender: Any) {
        let email = emailTextField.text!
        let password=passwordTextField.text!
        AuthManager.shared.loginExistingEmailPasswordUser(email: email, password: password)
        
    }

    @IBAction func pressedRoseFire(_ sender: Any) {
//        should be your view controller
        Rosefire.sharedDelegate().uiDelegate=self
        Rosefire.sharedDelegate().signIn(registryToken: RoseFireRegistraryToken) { error, result in
            if let error = error{
                print("error signing in \(error)")
                return
            }
            
            self.rosefireName=result!.name
            AuthManager.shared.signInWithRosefireToken(result!.token)
        
        }
    }
    
    @IBAction func pressedGoogleSignIn(_ sender: Any) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)

        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { [unowned self] user, error in

          if let error = error {
            // ...
            print("error occured signing in with google \(error)")
            return
          }

          guard
            let authentication = user?.authentication,
            let idToken = authentication.idToken
          else {
            return
          }

          let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                         accessToken: authentication.accessToken)
            
            print("Google signed in worked, now use the credential to do the real firebase sign in")
            AuthManager.shared.signInWithGoogleCredential(credential)
          // ...
        }
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
        rosefireName=nil
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
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      
//        make sure that the segue identifier is correct.
        if segue.identifier == kShowListSegue{
            print("WORKS")
            print("Name= \(rosefireName ?? AuthManager.shared.currentUser!.displayName)")
            print("Photourl=\(AuthManager.shared.currentUser!.photoURL)")
            
            UserDocumentManager.shared.addNewUserMaybe(uid: AuthManager.shared.currentUser!.uid, name: (rosefireName ?? AuthManager.shared.currentUser!.displayName)  , photoUrl: AuthManager.shared.currentUser!.photoURL?.absoluteString ?? "")
        }
    }
    

}
