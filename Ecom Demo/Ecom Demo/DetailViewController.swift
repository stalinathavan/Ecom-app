//
//  DetailViewController.swift
//  Ecom Demo
//
//  Created by stalin on 08/09/19.
//  Copyright © 2019 stalin. All rights reserved.
//

import UIKit
import SDWebImage
import UserNotifications


class DetailViewController: UIViewController,UNUserNotificationCenterDelegate {
var ImageUrl = 0
    @IBOutlet weak var detailImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
         UNUserNotificationCenter.current().delegate = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.detailImage.sd_imageIndicator = SDWebImageActivityIndicator.white
            self.detailImage.sd_setImage(with: URL(string: "https://picsum.photos/id/\(self.ImageUrl + 10)/300/400"))
        }
            
    }
    @IBAction func BackAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func downloadAction(_ sender: Any) {
//        SDWebImageManager.shared.loadImage(
//            with: URL(string: "https://picsum.photos/id/\(self.ImageUrl + 10)/300/400"),
//            options: .highPriority,
//            progress: nil) { (image, data, error, cacheType, isFinished, imageUrl) in
//                if isFinished{
        if let url = URL(string: "https://picsum.photos/id/\(self.ImageUrl + 10)/300/400"),
            let data = try? Data(contentsOf: url),
            let image = UIImage(data: data) {
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            let content = UNMutableNotificationContent()
           content.title = "Download completed"
           let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
            let request = UNNotificationRequest(identifier: "SimplifiedIOSNotification", content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        }
        
//                }
//        }
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
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        //displaying the ios local notification when app is in foreground
        completionHandler([.alert, .badge, .sound])
    }
}
