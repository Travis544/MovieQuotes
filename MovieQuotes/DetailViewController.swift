//
//  DetailViewController.swift
//  MovieQuotes
//
//  Created by Yuanhang on 3/29/22.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var movieLabel: UILabel!
    
    var movieQuote : MovieQuote!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem=UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(showEditQuoteDialog) )
        // Do any additional setup after loading the view.
        updateView()
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
            self.movieQuote.quote=quoteTextField.text!
            self.movieQuote.movie=movieTextField.text!
            self.updateView()
        }
        
        
        
        alertController.addAction(cancelAction)
        alertController.addAction(editQuoteAction)
        
        present(alertController, animated: true)
    }
    
    
//    if view did load crashes, it was too early, then I could do this
//    override func viewWillLoad(_ animated: false){
//        
//    }
    
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
