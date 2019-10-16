//
//  ColletionViewController.swift
//  Ecom Demo
//
//  Created by M, Stalin (Cognizant) on 16/10/19.
//  Copyright © 2019 stalin. All rights reserved.
//

import UIKit
import SDWebImage
import UserNotifications

class ColletionViewController: UIViewController,UNUserNotificationCenterDelegate {
     let imagecellIdentifier = "imageCell"
    
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var downloadBtn: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    var ImageUrl = 0
    var isDownloaded = false
    override func viewDidLoad() {
        super.viewDidLoad()
    self.collectionView.register(UINib(nibName:"ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: imagecellIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        pageControl.numberOfPages = 3
      
    }

 
    @IBAction func backAction(_ sender: Any) {
         self.dismiss(animated: true, completion: nil)
    }
    @IBAction func shareAction(_ sender: Any) {
        DispatchQueue.main.async {
            let url = URL(string: "https://picsum.photos/id/\(self.ImageUrl + 10)/300/400")
            let data = try? Data(contentsOf: url!)
            
            if let imageData = data {
                let image = UIImage(data: imageData)
                let shareAll = [image]
                let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
                activityViewController.popoverPresentationController?.sourceView = self.view
                self.present(activityViewController, animated: true, completion: nil)
            }
            //        let image = UIImage(named: "Product")
        }
    }
    @IBAction func downloadAction(_ sender: Any) {
        DispatchQueue.main.async {
            
            
            if !self.isDownloaded{
                if let url = URL(string: "https://picsum.photos/id/\(self.ImageUrl + 10)/300/400"),
                    let data = try? Data(contentsOf: url),
                    let image = UIImage(data: data) {
                    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                    self.isDownloaded = true
                    self.triggerPush()
                    
                }else {
                    let actionSheetController: UIAlertController = UIAlertController(title: "Action Sheet", message: "Swiftly Now! Choose an option!", preferredStyle: .alert)
                    let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
                        //Just dismiss the action sheet
                    }
                    actionSheetController.addAction(cancelAction)
                    self.present(actionSheetController, animated: true, completion: nil)
                }
                
            }
                
            else {
                let actionSheetController: UIAlertController = UIAlertController(title: "Alert", message: "File already Exsist", preferredStyle: .alert)
                let cancelAction: UIAlertAction = UIAlertAction(title: "ok", style: .cancel) { action -> Void in
                    //Just dismiss the action sheet
                }
                actionSheetController.addAction(cancelAction)
                self.present(actionSheetController, animated: true, completion: nil)
            }
        }
    }
    func triggerPush(){
        DispatchQueue.main.async {
            let content = UNMutableNotificationContent()
            content.title = "Download completed"
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
            let request = UNNotificationRequest(identifier: "SimplifiedIOSNotification", content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
            
        }
    }
    @IBAction func chnaged(_ sender: UIPageControl) {
     
        
    }
}
extension ColletionViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imagecellIdentifier, for: indexPath) as! ImageCollectionViewCell
        DispatchQueue.main.async {
            cell.sd_imageIndicator = SDWebImageActivityIndicator.white
          cell.imageview.sd_setImage(with: URL(string: "https://picsum.photos/id/\(self.ImageUrl + 10)/300/400"))
        }
            return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: self.collectionView.frame.width, height: self.collectionView.frame.height)
        return size
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        if pageControl.currentPage == 1 || pageControl.currentPage == 2{
            self.downloadBtn.isHidden = true
            self.shareBtn.isHidden = true
        }else {
            self.downloadBtn.isHidden = false
            self.shareBtn.isHidden = false
        }
    }
    
    
}
