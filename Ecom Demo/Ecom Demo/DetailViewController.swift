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
        SDWebImageManager.shared.loadImage(
            with: URL(string: "https://picsum.photos/id/\(self.ImageUrl + 10)/300/400"),
            options: .highPriority,
            progress: nil) { (image, data, error, cacheType, isFinished, imageUrl) in
                if isFinished{
                    let content = UNMutableNotificationContent()
                    
                    //adding title, subtitle, body and badge
                    content.title = "Download completed"
//                content.badge = 1
                    
                    
                    //getting the notification trigger
                    //it will be called after 5 seconds
                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
                    
                    //getting the notification request
                    let request = UNNotificationRequest(identifier: "SimplifiedIOSNotification", content: content, trigger: trigger)
                    
                    //adding the notification to notification center
                    UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
                }
        }
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
