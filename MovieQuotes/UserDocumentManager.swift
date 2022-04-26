//
//  UserDocumentManager.swift
//  MovieQuotes
//
//  Created by Yuanhang on 4/25/22.
//

import Foundation
import Firebase

class UserDocumentManager {

    var _latestDocument : DocumentSnapshot?
    static let shared = UserDocumentManager()
    var _collectionRef: CollectionReference
    
    private init() {
        _collectionRef = Firestore.firestore().collection(kUsersCollectionPath)
    }
    
    
    func addNewUserMaybe(uid : String, name: String?, photoUrl: String?){
//        get the user document for this uid
//        if it exist do nothing
//        if there is not user document, make it using the name and photo url
        let docRef = _collectionRef.document(uid)
        
        docRef.getDocument { document, error in
            if let document=document, document.exists{
                print("Document exist. Do nothin. Here is the data: \(document.data()!)")
            }else{
                print("Document does not exist. Create this user")
                docRef.setData([kUserName: name ?? "", kUserPhotoUrl: photoUrl ?? ""])
            }
        }
    }
    
    func startListening(for documentId: String, changeListener: @escaping (() -> Void)) -> ListenerRegistration {
        let query = _collectionRef.document(documentId)
        self._latestDocument=nil
        return query.addSnapshotListener { documentSnapshot, error in
            guard let document = documentSnapshot else {
              print("Error fetching document: \(error!)")
              return
            }
            guard document.data() != nil else {
              print("Document data was empty.")
              return
            }
//            print("Current data: \(data)")
            self._latestDocument = document
            changeListener()
          }
    }
    
    
    var name : String{
        if let name = _latestDocument?.get(kUserName){
//            doesnt work when you put as on top
//        I think its because get returns an any optional, but after getting the value, name is definitely a string value
            return name as! String
        }
        
        return ""
    }
    
    
    var photoUrl:  String{
        if let photoUrl = _latestDocument?.get(kUserPhotoUrl){
            return photoUrl as! String
        }
        
        return ""
    }
    
    func stopListening(_ listenerRegistration: ListenerRegistration?) {
        listenerRegistration?.remove()
    }
    
    
    func updateName(name: String) {
        _collectionRef.document( _latestDocument!.documentID).updateData([
            kUserName: name,
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    
    func updatePhotoUrl(url: String) {
        _collectionRef.document(_latestDocument!.documentID).updateData([
            kUserPhotoUrl: url,
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
}
