//
//  LogEntryCell.swift
//  BulletJournal
//
//  Created by Jonathan Molina on 11/20/16.
//  Copyright © 2016 Jonathan Molina. All rights reserved.
//

import UIKit

extension UIImage {
    
    
    /// Scales an image to fit within a bounds with a size governed by the passed size. Also keeps the aspect ratio.
    /// Switch MIN to MAX for aspect fill instead of fit.
    ///
    /// - parameter newSize: newSize the size of the bounds the image must fit within.
    ///
    /// - returns: a new scaled image.
    func scaleImageToSize(newSize: CGSize) -> UIImage {
        var scaledImageRect = CGRect.zero
        
        let aspectWidth = newSize.width/size.width
        let aspectheight = newSize.height/size.height
        
        let aspectRatio = max(aspectWidth, aspectheight)
        
        scaledImageRect.size.width = size.width * aspectRatio;
        scaledImageRect.size.height = size.height * aspectRatio;
        scaledImageRect.origin.x = (newSize.width - scaledImageRect.size.width) / 2.0;
        scaledImageRect.origin.y = (newSize.height - scaledImageRect.size.height) / 2.0;
        
        UIGraphicsBeginImageContext(newSize)
        draw(in: scaledImageRect)
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage!
    }
}

class LogEntryCell: UITableViewCell {

    @IBOutlet weak var noteLable: UILabel!
    @IBOutlet weak var bulletImage: UIImageView!
    @IBOutlet weak var isImportantImage: UIImageView!
    var logEntry : LogEntry?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        loadBulletImage()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadBulletImage() {
        if let log = logEntry {
            switch log.bulletType {
            case .Task:
                bulletImage.image = #imageLiteral(resourceName: "TaskBullet").scaleImageToSize(newSize: bulletImage.frame.size)
            case .Event:
                bulletImage.image = #imageLiteral(resourceName: "EventBullet").scaleImageToSize(newSize: bulletImage.frame.size)
            case .Information:
                bulletImage.image = #imageLiteral(resourceName: "InfoBullet")
            }
            bulletImage.contentMode = .scaleAspectFit
            bulletImage.clipsToBounds = true
        }
    }

}
