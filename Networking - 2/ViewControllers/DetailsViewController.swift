//
//  DetailsViewController.swift
//  Networking - 2
//
//  Created by Nasim Nozirov on 29.06.2022.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var authorLable: UILabel!
   
    var image: Image!

    override func viewDidLoad() {
        super.viewDidLoad()
        Networking.shared.fetchImage(from: image.download_url) { image in
            self.imageView.image = UIImage(data: image)
        }
        authorLable.text = image.author
    }


}

