//
//  MovieQuotesTableViewController.swift
//  MovieQuotes
//
//  Created by Yuanhang on 3/28/22.
//

import UIKit
class MovieQuoteTableViewCell : UITableViewCell{
    
    @IBOutlet weak var movieLabel: UILabel!
    @IBOutlet weak var quoteLabel: UILabel!
}


class MovieQuotesTableViewController: UITableViewController {
    let kMovieQuoteCell="MovieQuoteCell"
    let names=["Travis", "Dave", "JOHN", "s", "TE", "ll"]
    var movieQuotes : [MovieQuote] = [MovieQuote]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
//        hard code some movie quote
        let mq1=MovieQuote(quote: "I will be back", movie: "Terminator")
        let mq2=MovieQuote(quote: "Everything is great", movie: "Lego Movie")
        movieQuotes.append(mq1)
        movieQuotes.append(mq2)
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
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
