//
//  AnimeCell.swift
//  ApplaudoiOSChallenge
//
//  Created by Adan Garcia on 06/09/17.
//  Copyright © 2017 Adan Garcia. All rights reserved.
//

import UIKit
import SDWebImage

class AnimeCell: UICollectionViewCell {
    @IBOutlet weak var title: UILabel?
    @IBOutlet weak var image: UIImageView!
    
    func setup(name:String, imageUrl:String) {
        title?.text = name
        
        let placeholder = UIImage(named: "")
        
        guard let encodedUrl = imageUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            else {
                self.image.image = placeholder
                return
        }
        let link = URL(string: encodedUrl)
        image.sd_setImage(with: link, placeholderImage: placeholder, options: .refreshCached)
    }
}
