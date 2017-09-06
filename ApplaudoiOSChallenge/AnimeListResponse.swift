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
    
    var list : [Anime] = []
   
    init?(map: Map) { }
    
    init() {  }
    
    mutating func mapping(map: Map) {
        getAnimeList(map: map, parameter: "lists.dropped")
        getAnimeList(map: map, parameter: "lists.completed")
        getAnimeList(map: map, parameter: "lists.watching")
        getAnimeList(map: map, parameter: "lists.plan_to_watch")
    }
    
    private mutating func getAnimeList(map: Map, parameter:String) {
        var results : [Anime]?
        results <- map[parameter]
        
        if let results = results {
            self.list.append(contentsOf: results)
        }
    }
}
