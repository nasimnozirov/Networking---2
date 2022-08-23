//
//  FoodTableViewController.swift
//  Networking - 2
//
//  Created by Nasim Nozirov on 19.07.2022.
//

import UIKit

class FoodTableViewController: UITableViewController {
    
    private let url = "https://picsum.photos/v2/list"
    
    var images: [Image] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Networking.shared.fetchData(from: url) { images in
            self.images = images
            self.tableView.reloadData()
        }
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let image = images[indexPath.row]
        guard let detailsVC = segue.destination as? DetailsViewController else { return }
        detailsVC.image = image
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        images.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "food", for: indexPath)
        
        let image = images[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = image.author
        
        cell.contentConfiguration = content
        return cell
    }
}
