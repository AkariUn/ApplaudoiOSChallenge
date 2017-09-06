//
//  Anime.swift
//  ApplaudoiOSChallenge
//
//  Created by Adan Garcia on 06/09/17.
//  Copyright © 2017 Adan Garcia. All rights reserved.
//

import Foundation
import ObjectMapper


struct Anime: Mappable {
    
    var id :  Int!
    var titleRomaji : String!
    var titleEnglish : String!
    var titleJapanese : String!
    var scroe : Int!
    var image : String!
    var totalEpisodes : Int!
    var genres : [String]!
    
    init?(map: Map) { }
    
    init() {  }
    
    mutating func mapping(map: Map) {
        id <- map["anime.id"]
        titleRomaji <- map["anime.title_romaji"]
        titleEnglish <- map["anime.title_english"]
        titleJapanese <- map["anime.title_japanese"]
        scroe <- map["anime.average_score"]
        image <- map["anime.image_url_med"]
        totalEpisodes <- map["anime.total_episodes"]
        genres <- map["anime.genres"]
    }
    
}

class AnimeCategory {
    var name:String
    var animes:[Anime]
    
    init(name:String, animes:[Anime]) {
        self.name = name
        self.animes = animes
    }
}
