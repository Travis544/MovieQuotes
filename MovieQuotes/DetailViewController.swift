//
//  DetailViewController.swift
//  MovieQuotes
//
//  Created by Yuanhang on 3/29/22.
//

import UIKit
import Firebase
class DetailViewController: UIViewController {

    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var movieLabel: UILabel!
    var movieQuoteRef: DocumentReference!
    var movieQuote : MovieQuote!
    var movieQuoteListener: ListenerRegistration!
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
//        updateView()
    }
    
    //  if view did load crashes, it was too early, then I could do this
    override func viewWillAppear(_ animated: Bool ){
        movieQuoteListener = movieQuoteRef.addSnapshotListener { (documentSnapshot, error) in
            if let error=error{
                print("Error getting movie quote \(error)")
                return
            }
            
//            we know there is a document snap shot so force unwrap, but it might be gone. someone might deleted.
            if !documentSnapshot!.exists{
                //might go back to list since someone else deleted this document
                return
            }
            
            let data=documentSnapshot
            print("SSSS")
            self.movieQuote = MovieQuote(id:data!.documentID, quote: data!["quote"] as! String, movie: data!["movie"] as! String,
            
                                         author: data!["author"] as! String)
            
//            decide we can edit or not.
            if(AuthManager.shared.currentUser!.uid==self.movieQuote?.author){
                self.navigationItem.rightBarButtonItem=UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(self.showEditQuoteDialog) )
            }else{
                self.navigationItem.rightBarButtonItem=nil
            }
            
            self.updateView()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.movieQuoteListener.remove()
    }
    
    
    @objc func showEditQuoteDialog(){
        print("You pressed addd button")
        let alertController = UIAlertController(title: "Create a new movie quotes", message:"", preferredStyle: UIAlertController.Style.alert)
        
        alertController.addTextField { textField in
            textField.placeholder="Quote"
            textField.text=self.movieQuote.quote
        }
        
        alertController.addTextField { textField in
            textField.placeholder="Movie"
            textField.text=self.movieQuote.movie
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) { action in
            print("Cancled")
        }
        
        let editQuoteAction = UIAlertAction(title: "Save", style: UIAlertAction.Style.default){
            action in
            print("you created a movie quote!")
            
            let quoteTextField=alertController.textFields![0] as UITextField
            let movieTextField=alertController.textFields![1] as UITextField
//            let s = MovieQuote(quote:quoteTextField.text!, movie: movieTextField.text!)
//            self.movieQuote.quote=quoteTextField.text!
//            self.movieQuote.movie=movieTextField.text!
            
            
            self.movieQuoteRef.updateData(["quote":quoteTextField.text!,
                                           "movie":movieTextField.text!,
                                           "created": Timestamp.init()
                                          ]){
                err in
                if let err=err{
                    print("Error updating document \(err)")
                }else{
                    print("updated success")
                }
            }
            self.updateView()
        }
        
        
        
        alertController.addAction(cancelAction)
        alertController.addAction(editQuoteAction)
        
        present(alertController, animated: true)
    }
    
    

    
    func updateView(){
        quoteLabel.text=movieQuote.quote
        movieLabel.text=movieQuote.movie
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
