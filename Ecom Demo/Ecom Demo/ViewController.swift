//
//  ViewController.swift
//  Ecom Demo
//
//  Created by stalin on 08/09/19.
//  Copyright © 2019 stalin. All rights reserved.
//

import UIKit
import SDWebImage
import UserNotifications

class ViewController: UIViewController {

    @IBOutlet weak var colletionview: UICollectionView!
    @IBOutlet weak var imageView: UIImageView!
    var selectedIndex = -1
    override func viewDidLoad() {
//        super.viewDidLoad()
        // create the alert
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge]) {
            (granted, error) in
            if granted {
                print("yes")
            } else {
                print("No")
            }
        }

        colletionview.delegate = self
        colletionview.dataSource = self
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width
      
        layout.sectionInset = UIEdgeInsets(top: 7, left:10, bottom: 7, right: 10)
        layout.itemSize = CGSize(width: width / 2, height: width / 2)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 5
        colletionview.collectionViewLayout = layout

        
       
    }


}
extension ViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = colletionview.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.layer.cornerRadius = 5
        DispatchQueue.main.async {
       cell.imageView.sd_imageIndicator = SDWebImageActivityIndicator.white
       cell.imageView.sd_setImage(with: URL(string: "https://picsum.photos/id/\(indexPath.item + 10)/165/155"))
            let width = UIScreen.main.bounds.width
            cell.imageView.frame.size = CGSize(width: width/2, height: width/2)
      }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 165 , height: 155
        )
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.item
        self.performSegue(withIdentifier: "detail", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextViewController = segue.destination as? DetailViewController {
            nextViewController.ImageUrl = self.selectedIndex
            
        }
    }
}
