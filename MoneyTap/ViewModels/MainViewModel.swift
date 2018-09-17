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
    var isLoading = BehaviorRelay<Bool>(value: true)
    init(coordinator:SceneCoordinatorType) {
        self.coordinator=coordinator
        self.firstTimeScreen=BehaviorRelay<Bool>(value:true)
        self.noDataFoundScreen=BehaviorRelay<Bool>(value:false)
        self.searchKeyword=BehaviorRelay<String>(value:"")
        self.searchResultObjects=BehaviorRelay<[PageObject]>(value:[])
        _=searchKeyword.asObservable().subscribe(onNext: {data in
            if(data==""){
                self.noDataFoundScreen.accept(true)
                return
            }else{
                self.noDataFoundScreen.accept(false)
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
        let lazyView=UIView(frame: CGRect(x: 40, y: UIScreen.main.bounds.size.height + 50.0, width: UIScreen.main.bounds.size.width-20.0, height: 100.0))
        lazyView.backgroundColor=UIColor.white
        let descriptionTextLabel=UILabel()
        descriptionTextLabel.text="Please Enter Above a keyword to search on Wiki"
        descriptionTextLabel.translatesAutoresizingMaskIntoConstraints=false
        descriptionTextLabel.font=UIFont(name: "Copperplate", size: 20.0)
        descriptionTextLabel.textColor=UIColor.darkText
        descriptionTextLabel.frame=CGRect(x: UIScreen.main.bounds.size.width/2-100.0, y: 0.0, width: 200.0, height: 80.0)
        return lazyView
    }()
    
    func loadFirstTimeScreen() {
        UIView.animate(withDuration: 2.0) {
            DispatchQueue.main.async {
                self.firstTimeScreenView.frame=CGRect(x: 0, y: 140.0, width: UIScreen.main.bounds.size.width, height: 100.0)
            }
        }
    }
    
    func popFirstTimeScreen() {
        UIView.animate(withDuration: 2.0, animations: {
            self.firstTimeScreenView.frame=CGRect(x: 0, y:UIScreen.main.bounds.size.height + 50.0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - 50.0)
        }) { (flag) in
            self.firstTimeScreenView.isHidden=true
        }
    }
    
}
