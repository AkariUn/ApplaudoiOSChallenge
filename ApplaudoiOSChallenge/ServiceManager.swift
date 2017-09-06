//
//  ServiceManager.swift
//  ApplaudoiOSChallenge
//
//  Created by Adan Garcia on 05/09/17.
//  Copyright © 2017 Adan Garcia. All rights reserved.
//

import Foundation
import ObjectMapper

enum NetworkingResult {
    case ok
    case networkError
    case parseError
    case invalidUrlError
    case unknownError
    case unauthorized
}

enum RequestMethod:String {
    case get = "GET"
    case post = "POST"
}

struct NetworkResource<T> {
    var url:String
    var method:RequestMethod
    var params:[String:Any]?
    
    init(url:String, method:RequestMethod, params:[String:Any]? = nil) {
        self.url = url
        self.method = method
        self.params = params
    }
}

extension NetworkResource {
    func loadAsync(complete:@escaping (_ result:NetworkingResult, _ data:String?) -> Void) {
        debugPrint("Loading Resource!")
        guard let url = URL(string: self.url)
            else {
                complete(.unknownError, nil)
                return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = self.method.rawValue
        if let params = self.params {
            request.httpBody = NetworkResource.bodyFromDictionary(dictionary: params)
        }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let data = data, let stringData = String(data: data, encoding: .utf8), error == nil
                else {
                    complete(.parseError, nil)
                    return
            }
            
            complete(.ok, stringData)
        }
        task.resume()
    }
    
    fileprivate static func bodyFromDictionary(dictionary:[String:Any]) -> Data? {
        let params = dictionary.map { "\($0.key)=\($0.value)" }
        let paramsString = params.joined(separator: "&")
        return paramsString.data(using: .utf8)
    }
    
    fileprivate static func stringFromDictionary(dictionary:[String:Any]) -> String? {
        let params = dictionary.map { "\($0.key)=\($0.value)" }
        return params.joined(separator: "&")
    }
}

class ServiceManager {
    let BaseUrl = "https://anilist.co/api/"
    private let grantType = "client_credentials"
    private let clientId = "akariun-4nwzz"
    private let clientSecret = "e64DgXwgK2wWC763UaX0c9fU"
    
    static let shared = ServiceManager()
    
    func getAccessToken(complete:@escaping (_ result:NetworkingResult, _ data:AccessToken?) -> Void) {
        let url = "\(BaseUrl)auth/access_token"
        
        let parameters:[String : Any] = ["grant_type": grantType,
                                         "client_id": clientId,
                                         "client_secret": clientSecret]
        
        let resource = NetworkResource<AccessToken>(url: url, method: .post, params: parameters)
        
        resource.loadAsync { (result, data) in
            if let data = data {
                let token = Mapper<AccessToken>().map(JSONString: data)
                complete(result, token)
            } else {
                complete(.parseError, nil)
            }
            
        }
    }
    
    
    func getAnimeList(for userId:String ,complete:@escaping (_ result:NetworkingResult, _ data:[Anime]?) -> Void) {
        var url = "\(BaseUrl)user/\(userId)/animelist"
        debugPrint(url)
        let userDefaults = UserDefaults.standard
        
        guard let accessToken = userDefaults.string(forKey: "accessToken") else {
            complete(.unauthorized, nil)
            return
        }

        url.append("?access_token=\(accessToken)")
        
        let resource = NetworkResource<AccessToken>(url: url, method: .get, params: nil)
        
        resource.loadAsync { (result, data) in
            if let data = data {
                let animeList = Mapper<AnimeListResponse>().map(JSONString: data)
                complete(result, animeList?.list)
            } else {
                complete(.parseError, nil)
            }
            
        }
    }
}
