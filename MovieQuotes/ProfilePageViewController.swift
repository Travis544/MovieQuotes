//
//  ProfilePageViewController.swift
//  MovieQuotes
//
//  Created by Yuanhang on 4/21/22.
//

import UIKit
import FirebaseFirestore

class ProfilePageViewController: UIViewController {

    @IBOutlet weak var profilePhotoImageView: UIImageView!
    @IBOutlet weak var displayNameTextField: UITextField!
    
    var userListenerRegistration : ListenerRegistration?
    var imageUtil = ImageUtils()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userListenerRegistration = UserDocumentManager.shared.startListening(for: AuthManager.shared.currentUser!.uid, changeListener: {
            self.updateView()
        })
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        UserDocumentManager.shared.stopListening(userListenerRegistration)
    }
    
    
    
    func updateView(){
        print("TODO: SHow the name \(UserDocumentManager.shared.name)")
        displayNameTextField.text=UserDocumentManager.shared.name
        
//        check if the returned url is an empty string
        if !UserDocumentManager.shared.photoUrl.isEmpty{
        imageUtil.load(imageView: profilePhotoImageView, from: UserDocumentManager.shared.photoUrl)
        }
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
