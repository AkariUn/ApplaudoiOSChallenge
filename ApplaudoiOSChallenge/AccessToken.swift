//
//  AccessToken.swift
//  ApplaudoiOSChallenge
//
//  Created by Adan Garcia on 05/09/17.
//  Copyright © 2017 Adan Garcia. All rights reserved.
//

import Foundation
import ObjectMapper

struct AccessToken: Mappable {

    var accessToken :  String!
    var tokenType : String!
    var expires : Int!
    var expiresIn : Int!
   
    
    init?(map: Map) { }
    
    init() {  }
    
    mutating func mapping(map: Map) {
        accessToken <- map["access_token"]
        tokenType <- map["token_type"]
        expires <- map["expires"]
        expiresIn <- map["expires_in"]
    }
    
}
