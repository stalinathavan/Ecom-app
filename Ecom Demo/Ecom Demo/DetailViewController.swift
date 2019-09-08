//
//  DetailViewController.swift
//  Ecom Demo
//
//  Created by stalin on 08/09/19.
//  Copyright © 2019 stalin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
var ImageUrl = 0
    @IBOutlet weak var detailImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            let url = URL(string: "https://picsum.photos/id/\(self.ImageUrl + 10)/300/400")
            let data = try? Data(contentsOf: url!)
            if let imageData = data {
                let image = UIImage(data: imageData)
                self.detailImage.image = image
//                cell.imageView.image = image
            }
        }
            
    }
    @IBAction func BackAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
