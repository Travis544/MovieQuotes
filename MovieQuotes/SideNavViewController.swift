//
//  SideNavViewController.swift
//  
//
//  Created by Yuanhang on 4/21/22.
//

import UIKit

class SideNavViewController: UIViewController {

    var tableViewController : MovieQuotesTableViewController!{
        let navController = presentingViewController as! UINavigationController
        return navController.viewControllers.last as? MovieQuotesTableViewController
    }

    @IBAction func pressedSignedOut(_ sender: Any) {
        dismiss(animated: true)
        
        AuthManager.shared.signOut()
    }
    
    
    @IBAction func pressedDeleteQuote(_ sender: Any) {
        dismiss(animated: true)
        
        tableViewController.setEditing(!tableViewController.isEditing, animated: true) 
        
    }
    @IBAction func pressedEditProfile(_ sender: Any) {
        tableViewController.performSegue(withIdentifier: kProfilePageSegue, sender: tableViewController)
        dismiss(animated: true)
        
    }
    
    @IBAction func pressedShowAllQuotes(_ sender: Any) {
        tableViewController.isShowingAllQuotes=true
        tableViewController.stopListening()
        tableViewController.startListening(filterByAuthor: nil){
            
        }
        dismiss(animated: true)
        
    }
    
    
    @IBAction func pressedShowMyQuotes(_ sender: Any) {
        tableViewController.isShowingAllQuotes=false
        tableViewController.stopListening()
        tableViewController.startListening(filterByAuthor: AuthManager.shared.currentUser?.uid){
            
        }
        dismiss(animated: true)
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
