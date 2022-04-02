//
//  MovieQuotesTableViewController.swift
//  MovieQuotes
//
//  Created by Yuanhang on 3/28/22.
//

import UIKit
import Firebase
import FirebaseFirestore
class MovieQuoteTableViewCell : UITableViewCell{
    
    @IBOutlet weak var movieLabel: UILabel!
    @IBOutlet weak var quoteLabel: UILabel!
}


class MovieQuotesTableViewController: UITableViewController {
    let kMovieQuoteCell="MovieQuoteCell"
    let kMovieQuoteSegue = "myMovieQuoteDetailSegway"
    let names=["Travis", "Dave", "JOHN", "s", "TE", "ll"]
    var movieQuoteRef : CollectionReference!
    var quoteListener : ListenerRegistration!
    var movieQuotes : [MovieQuote] = [MovieQuote]()
    

    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        quoteListener.remove()
    }
    
    override func viewWillAppear(_ animated:Bool){
        super.viewWillAppear(animated)
        tableView.reloadData()
        quoteListener=movieQuoteRef.order(by: "created", descending:true).limit(to: 50).addSnapshotListener{ [self](querySnapshot, error) in
            self.movieQuotes=[]
            if querySnapshot != nil{
                querySnapshot?.documents.forEach({ QueryDocumentSnapshot in
                    print(QueryDocumentSnapshot.documentID)
                    print(QueryDocumentSnapshot.data())
                    let data=QueryDocumentSnapshot.data()
                    self.movieQuotes.append(MovieQuote(id:QueryDocumentSnapshot.documentID, quote: data["quote"] as! String, movie: data["movie"] as! String ))
                    
                })
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        
        self.navigationItem.rightBarButtonItem=UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showAddQuoteDialog) )
//        hard code some movie quote
        // let mq1=MovieQuote(quote: "I will be back", movie: "Terminator")
//        let mq2=MovieQuote(quote: "Everything is great", movie: "Lego Movie")
//        movieQuotes.append(mq1)
//        movieQuotes.append(mq2)
        movieQuoteRef = Firestore.firestore().collection("MovieQuotes")
        
    }
    
    @objc func showAddQuoteDialog(){
        print("You pressed addd button")
        let alertController = UIAlertController(title: "Create a new movie quotes", message:"", preferredStyle: UIAlertController.Style.alert)
        
        alertController.addTextField { textField in
            textField.placeholder="Quote"
        }
        
        alertController.addTextField { textField in
            textField.placeholder="Movie"
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) { action in
            print("Cancled")
        }
        
        let createQuoteAction = UIAlertAction(title: "Create Quote", style: UIAlertAction.Style.default){
            action in
            print("you created a movie quote!")
            
            let quoteTextField=alertController.textFields![0] as UITextField
            let movieTextField=alertController.textFields![1] as UITextField
//            let s = MovieQuote(quote:quoteTextField.text!, movie: movieTextField.text!)
            self.movieQuoteRef.addDocument(data: ["quote":quoteTextField.text!, "movie":movieTextField.text!, "created":Timestamp.init()])
//            self.movieQuotes.insert(s,at:0)
//            self.tableView.reloadData()
//            print(self.movieQuotes)
//
        }
        alertController.addAction(cancelAction)
        alertController.addAction(createQuoteAction)
        
        present(alertController, animated: true)
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movieQuotes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kMovieQuoteCell, for: indexPath) as! MovieQuoteTableViewCell
//        cell.textLabel?.text="THis is row \(indexPath.row)"
        
//        index path got a .section and .row--> it can tell you what section or row you're in.
        cell.quoteLabel.text=movieQuotes[indexPath.row].quote
        cell.movieLabel.text=movieQuotes[indexPath.row].movie
//         Configure the cell...

        return cell
    }
    

    
//     Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//         Return false if you do not want the specified item to be editable.
      
        return true
    }
    

    
//     Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
//             Delete the row from the data source
//            movieQuotes.remove(at: indexPath.row)
            let movieQuoteToDelete=movieQuotes[indexPath.row]
            movieQuoteRef.document(movieQuoteToDelete.id!).delete()
//            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        } else if editingStyle == .insert {
//             Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//         Get the new view controller using segue.destination.
//         Pass the selected object to the new view controller.
        if segue.identifier==kMovieQuoteSegue {
            let mqdvc=segue.destination as! DetailViewController
            if let indexPath = tableView.indexPathForSelectedRow{
//                mqdvc.movieQuote=movieQuotes[indexPath.row]
                mqdvc.movieQuoteRef=movieQuoteRef.document(movieQuotes[indexPath.row].id!)
            }
        }
        
    }


}
