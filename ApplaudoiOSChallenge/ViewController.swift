//
//  ViewController.swift
//  ApplaudoiOSChallenge
//
//  Created by Adan Garcia on 05/09/17.
//  Copyright © 2017 Adan Garcia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!

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
                    .categorise { $0.genres.first ?? "other" }
                    .map { grouping, animes in
                        let animeCategory = AnimeCategory(name: grouping, animes: animes)
                        return animeCategory
                }
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        })
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? DetailViewController,
            let cell = sender as? AnimeCell,
            let indexPath = collectionView.indexPath(for: cell),
            let anime = items?[indexPath.section].animes[indexPath.row] {
            viewController.anime = anime
            
        }
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.items?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader,
            let cell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header", for: indexPath) as? HeaderCell,
            let item = self.items?[indexPath.section] {
            cell.setup(name: item.name)
            return cell
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items?[section].animes.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let _cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        guard let cell = _cell as? AnimeCell,
            let item = self.items?[indexPath.section].animes[indexPath.row]
            else { return _cell }
        
        cell.setup(name: item.titleEnglish, imageUrl: item.image)

        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenRect = UIScreen.main.bounds
        let screenWidth = screenRect.size.width
        let cellWidth = (screenWidth - 20) / 3.0
        let cellHeight:CGFloat = cellWidth * 1.4
        let size = CGSize(width: cellWidth, height: cellHeight)
        
        return size
    }
}
