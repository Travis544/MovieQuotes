//
//  ProfilePageViewController.swift
//  MovieQuotes
//
//  Created by Yuanhang on 4/21/22.
//

import UIKit
import FirebaseFirestore

class ProfilePageViewController: UIViewController{

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
    
    
    @IBAction func displayNameDidChange(_ sender: Any) {
        print("TO DO: Update name to \(displayNameTextField.text)")
        UserDocumentManager.shared.updateName(name: displayNameTextField.text ?? "")
    }
    
    @IBAction func pressedChangePhoto(_ sender: Any) {
        print("CHANGE PHOTO")
        let imagePicker=UIImagePickerController()
        imagePicker.delegate = self
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){
            imagePicker.sourceType = .camera
            
        }else{
            imagePicker.sourceType = .photoLibrary
        }
        present(imagePicker, animated: true)
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



extension ProfilePageViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
  
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage? {
            profilePhotoImageView.image=image
            StorageManager.shared.uploadProfilePhoto(uid: AuthManager.shared.currentUser!.uid, image: image)
        }
        
        picker.dismiss(animated: true)
    }
    
    
}
