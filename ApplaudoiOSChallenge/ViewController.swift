//
//  ViewController.swift
//  ApplaudoiOSChallenge
//
//  Created by Adan Garcia on 05/09/17.
//  Copyright © 2017 Adan Garcia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var items:[AnimeCategory]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    func loadData() {
        loadAccessToken()
    }

    func loadAccessToken() {
        ServiceManager.shared.getAccessToken { (result, token) in
            if let token = token, result == .ok {
                let userDefaults = UserDefaults.standard
                userDefaults.set(token.accessToken, forKey: "accessToken")
                
            }
            self.loadAnimeList()
        }
    }
    
    func loadAnimeList() {
        ServiceManager.shared.getAnimeList(for: "Melvinkooi", complete: { (result, items) in
            
            if let items = items, result == .ok {
                
                self.items = items
                    .categorise { $0.genres.first! }
                    .map { grouping, animes in
                        let animeCategory = AnimeCategory(name: grouping, animes: animes)
                        return animeCategory
                }
            }
        })
    }
 
}

