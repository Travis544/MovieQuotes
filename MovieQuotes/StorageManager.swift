//
//  StorageManager.swift
//  MovieQuotes
//
//  Created by Yuanhang on 4/26/22.
//

import Foundation
import Firebase
import FirebaseStorage
class StorageManager{
    static let shared = StorageManager()
    var _storageRef : StorageReference
    public init(){
        _storageRef = Storage.storage().reference()
    }
    
    func uploadProfilePhoto(uid : String, image: UIImage){
        
        guard let imageData = ImageUtils.resize(image: image) else {
            print("COnverting the image to data failed")
            return
        }
        
            let photoRef=_storageRef.child(kUsersCollectionPath).child(uid)
            photoRef.putData(imageData, metadata: nil){ metadata, error in
                if let error = error{
                    print("There was an error uploading the image \(error)")
                    return
                }
                
                print("Upload complete, TOOO: get the download url")
                photoRef.downloadURL { downloadUrl, error in
                    if let error = error{
                        print("There was an error getting the download url of the image \(error)")
                        return
                    }
                    
                    print("Got the download url \(downloadUrl?.absoluteString)")
                    UserDocumentManager.shared.updatePhotoUrl(url: downloadUrl?.absoluteString ?? "" )
                }
                
                
            }
        
        
    }
    
    
   
}
