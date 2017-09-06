//
//  HeaderCell.swift
//  ApplaudoiOSChallenge
//
//  Created by Adan Garcia on 06/09/17.
//  Copyright © 2017 Adan Garcia. All rights reserved.
//

import UIKit

class HeaderCell: UICollectionReusableView {
    @IBOutlet weak var title: UILabel!
    
    func setup(name:String) {
        title.text = name
    }
}
