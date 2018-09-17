//
//  NetworkManager.swift
//  MoneyTap
//
//  Created by Abhinay Varma on 15/09/18.
//  Copyright © 2018 Coffeebeans. All rights reserved.
//

import UIKit
import RxSwift

class NetworkManager {
    
    static let netManager = NetworkManager();
    
    func getSearchDataFromWiki(forKeyWord:String, completion:@escaping((SearchResultModel?,Error?)->Void)) {
        let url = URL(string: "https://en.wikipedia.org//w/api.php?action=query&format=json&prop=pageimages%7Cpageterms&generator=prefixsearch&redirects=1&formatversion=2&piprop=thumbnail&pithumbsize=50&pilimit=10&wbptterms=description&gpssearch=\(forKeyWord.components(separatedBy: .whitespaces).joined())&gpslimit=10")!
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            let decoder = JSONDecoder()
            do {
                let searchData = try decoder.decode(SearchResultModel.self, from: data)
                completion(searchData,nil);
            } catch let err {
                completion(nil,err);
            }
        }
        task.resume()
    }
    
    func getHtmlData(url:String,completion:@escaping((Data?,Error?)->Void)) {
        let url = URL(string: url)!
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return completion(nil,error) }
            completion(data,nil);
        }
        task.resume()
    }
}
