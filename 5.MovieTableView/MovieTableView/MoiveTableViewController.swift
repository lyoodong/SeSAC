//
//  MoiveTableViewController.swift
//  MovieTableView
//
//  Created by Dongwan Ryoo on 2023/07/29.
//

import UIKit

class MoiveTableViewController: UITableViewController {
    
    let movieInfo = MovieInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 150

    }
    // MARK: - UI set

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return movieInfo.movie.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:MovieTableViewCell.IDF ) as! MovieTableViewCell
        
        let row = movieInfo.movie[indexPath.row]
        
        cell.configureCell(row: row)
        
        return cell
        
    }

   

}
