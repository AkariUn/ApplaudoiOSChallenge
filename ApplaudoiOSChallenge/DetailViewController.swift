//
//  DetailViewController.swift
//  ApplaudoiOSChallenge
//
//  Created by Isidro Adan Garcia Solorio  on 9/6/17.
//  Copyright © 2017 Adan Garcia. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var banner: UIImageView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var titleEn: UILabel!
    @IBOutlet weak var titleJpn: UILabel!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var episodies: UILabel!
    
    var anime:Anime?
    
    override func viewDidLoad() {
        guard let anime = self.anime else {
            return
        }
        self.titleEn.text = anime.titleEnglish!
        self.titleJpn.text = anime.titleJapanese!
        self.genre.text = "Genre: \(anime.genres.joined(separator: ", "))"
        self.episodies.text = "Episodies: \(anime.totalEpisodes!)"
        
        let placeholder = UIImage(named: "generic")
        
        let link = URL(string: anime.image)
        image.sd_setImage(with: link, placeholderImage: placeholder, options: .refreshCached)
        
        if let animeBanner = anime.banner {
            let bannerLink = URL(string: animeBanner)
            banner.sd_setImage(with: bannerLink, placeholderImage: nil, options: .refreshCached)
        }
        
    }
}
