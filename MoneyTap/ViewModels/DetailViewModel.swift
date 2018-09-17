//
//  DetailViewModel.swift
//  MoneyTap
//
//  Created by Coffeebeans on 16/09/18.
//  Copyright © 2018 Coffeebeans. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

class DetailViewModel {
    private var coordinator:SceneCoordinatorType?
    var isLoading = BehaviorRelay<Bool>(value:true)
    var apiUrlString:String=""
    var searchResultHtmlString = BehaviorRelay<String>(value: "")
    
    init(pageId:Int,coordinator:SceneCoordinatorType) {
        apiUrlString="https://en.wikipedia.org/w/api.php?format=json&action=query&prop=extracts&explaintext=&exintro=&pageids=\(pageId)"
        self.coordinator=coordinator
        loadApiDataForClickedFeed()
    }
    
    func backClicked() {
        coordinator?.transition(to: coordinator?.currentViewController as! Navigationable, type: .pop(animated: true, level: .root))
    }
    
    func loadApiDataForClickedFeed() {
        NetworkManager.netManager.getHtmlData(url:self.apiUrlString,completion: {(data, error) in
            if(error == nil && data != nil) {
                let json = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
                var htmlToAttributedString: NSAttributedString? {
                    do {
                        return try NSAttributedString(data: data!, options: [.documentType: NSAttributedString.DocumentType.html,.characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
                    } catch {
                        return NSAttributedString()
                    }
                }
                self.searchResultHtmlString.accept(htmlToAttributedString?.string ?? "")
            }
        })
    }
    
}
