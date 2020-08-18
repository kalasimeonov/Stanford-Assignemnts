//
//  ImageGalleriesTableViewController.swift
//  Image Gallery
//
//  Created by Kaloyan Simeonov on 1.06.20.
//  Copyright © 2020 Kaloyan Simeonov. All rights reserved.
//

import UIKit

class ImageGalleriesTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if splitViewController?.preferredDisplayMode != .primaryOverlay {
            splitViewController?.preferredDisplayMode = .primaryOverlay
        }
    }
    
    @IBOutlet var galleriesTableView: UITableView!
    
    var galleries: [Gallery] = []
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return galleries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GalleryTableViewCell", for: indexPath) as! GalleryTableViewCell
        if let galleryTitle = galleries[indexPath.row].title {
            cell.galleryNameField.text = galleryTitle
        } else {
            cell.galleryNameField.text = "Untitled"
        }
        
        return cell
    }

    @IBAction func addNewGallery(_ sender: UIBarButtonItem) {
        galleries.append(Gallery())
        galleriesTableView.performBatchUpdates({galleriesTableView.insertRows(at: [IndexPath(row: galleries.count - 1, section: 0)], with: .automatic)})
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            galleries.remove(at: indexPath.row)
            galleriesTableView.performBatchUpdates({galleriesTableView.deleteRows(at: [indexPath], with: .fade)})
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
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
 
}
