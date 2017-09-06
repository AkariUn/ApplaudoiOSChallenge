//
//  AnimeListResponse.swift
//  ApplaudoiOSChallenge
//
//  Created by Adan Garcia on 06/09/17.
//  Copyright © 2017 Adan Garcia. All rights reserved.
//

import Foundation
import ObjectMapper

struct AnimeListResponse: Mappable {
    
    var list : [Anime]!
   
    init?(map: Map) { }
    
    init() {  }
    
    mutating func mapping(map: Map) {
        list <- map["lists"]
    }
    
}
