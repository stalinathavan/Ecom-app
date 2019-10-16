//
//  ColletionViewController.swift
//  Ecom Demo
//
//  Created by M, Stalin (Cognizant) on 16/10/19.
//  Copyright © 2019 stalin. All rights reserved.
//

import UIKit

class ColletionViewController: UIViewController {
     let imagecellIdentifier = "imageCell"
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    override func viewDidLoad() {
        super.viewDidLoad()
    self.collectionView.register(UINib(nibName:"ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: imagecellIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        pageControl.numberOfPages = 3
      
        
        
        // Do any additional setup after loading the view.
    }

    @IBAction func backAction(_ sender: Any) {
    }
    @IBAction func shareAction(_ sender: Any) {
    }
    @IBAction func downloadAction(_ sender: Any) {
    }
}
extension ColletionViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imagecellIdentifier, for: indexPath) as! ImageCollectionViewCell
            return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: self.collectionView.frame.width, height: self.collectionView.frame.height)
        return size
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
    
    
}
