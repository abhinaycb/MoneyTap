//
//  DetailViewController.swift
//  MoneyTap
//
//  Created by Coffeebeans on 16/09/18.
//  Copyright © 2018 Coffeebeans. All rights reserved.
//

import UIKit
import RxCocoa
import RxDataSources
import RxSwift

class DetailViewController: UIViewController,Navigationable {
    var disposeBag = DisposeBag()
    private var viewModelObject:DetailViewModel?
    private var wikiWebView:UIWebView!
    
    init(pageId:Int,coordinator:SceneCoordinatorType) {
        super.init(nibName: nil, bundle: nil)
        self.viewModelObject=DetailViewModel(pageId: pageId,coordinator:coordinator)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(DetailViewController.backClicked))
        self.navigationItem.leftBarButtonItem = newBackButton
        self.wikiWebView=UIWebView(frame: self.view.bounds)
        self.view=wikiWebView
        loadWebView()
        // Do any additional setup after loading the view.
    }
    
    @objc func backClicked() {
        self.viewModelObject?.backClicked()
    }
    
    func loadWebView() {
        _=self.viewModelObject?.searchResultHtmlString.asDriver().drive(onNext: {(htmlString) in
            self.wikiWebView.loadHTMLString(htmlString, baseURL: nil)
        })
    }
        
    
    func viewController() -> UIViewController {
        return self
    }
}
