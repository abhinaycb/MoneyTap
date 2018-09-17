//
//  MainViewModel.swift
//  MoneyTap
//
//  Created by Coffeebeans on 16/09/18.
//  Copyright © 2018 Coffeebeans. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class MainViewModel {
    private var coordinator:SceneCoordinatorType?
    let searchKeyword: BehaviorRelay<String>
    var searchResultObjects: BehaviorRelay<[PageObject]>
    var firstTimeScreen:BehaviorRelay<Bool>
    var noDataFoundScreen:BehaviorRelay<Bool>
    var isLoading: Driver<Bool>
    init(coordinator:SceneCoordinatorType) {
        self.coordinator=coordinator
        self.firstTimeScreen=BehaviorRelay<Bool>(value:true)
        self.noDataFoundScreen=BehaviorRelay<Bool>(value:false)
        self.searchKeyword=BehaviorRelay<String>(value:"")
        self.searchResultObjects=BehaviorRelay<[PageObject]>(value:[])
        let isLoading = ActivityIndicator()
        self.isLoading = isLoading.asDriver()
        _=searchKeyword.asObservable().subscribe(onNext: {data in
            if(data==""){
                self.noDataFoundScreen.accept(true)
                return
            }else{
                self.firstTimeScreen.accept(false)
            }
            
            NetworkManager.netManager.getSearchDataFromWiki(forKeyWord: data, completion: {(searchResults, error) in
                if(searchResults != nil) {
                    self.searchResultObjects.accept(searchResults?.queryObject?.pages ?? [])
                }
            })
        })
    }
    
    func tapped(pageObject:PageObject) {
        let repoViewController = DetailViewController(pageId: pageObject.pageid ?? 0,coordinator:coordinator!)
        coordinator?.transition(to: repoViewController, type: .push(animated:true))
    }
    lazy var firstTimeScreenView:UIView = {
        let lazyView=UIView(frame: CGRect(x: 40, y: UIScreen.main.bounds.size.height, width: UIScreen.main.bounds.size.width-20.0, height: 140.0))
        lazyView.backgroundColor=UIColor.lightGray
        let descriptionTextLabel=UILabel()
        descriptionTextLabel.translatesAutoresizingMaskIntoConstraints=true
        descriptionTextLabel.numberOfLines=0
        descriptionTextLabel.frame=CGRect(x: UIScreen.main.bounds.size.width/2-125.0, y: 0.0, width: 250.0, height: 120.0)
        lazyView.addSubview(descriptionTextLabel)
        descriptionTextLabel.text="Please Enter a keyword to get the wiki pages"
        descriptionTextLabel.font=UIFont(name: "Copperplate", size: 20.0)
        descriptionTextLabel.textColor=UIColor.lightText
        return lazyView
    }()
    
    func loadFirstTimeScreen() {
        
        UIView.animate(withDuration: 0.7) {
            self.firstTimeScreenView.frame=CGRect(x: 0, y: 100.0, width: UIScreen.main.bounds.size.width, height: 140.0)
        }
    }
    
    func popFirstTimeScreen() {
        UIView.animate(withDuration: 0.7, animations: {
            self.firstTimeScreenView.frame=CGRect(x: 0, y:UIScreen.main.bounds.size.height, width: UIScreen.main.bounds.size.width, height: 140.0)
        }) { (flag) in
            self.firstTimeScreenView.removeFromSuperview()
        }
    }
    
}
