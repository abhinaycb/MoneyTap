//
//  ViewController.swift
//  MoneyTap
//
//  Created by Coffeebeans on 15/09/18.
//  Copyright © 2018 Coffeebeans. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class MainViewController: UIViewController,UITableViewDelegate,Navigationable {
    func viewController() -> UIViewController {
        return self
    }
    var disposeBag = DisposeBag()
    private var viewModelObject:MainViewModel?
    private var tableView: UITableView!
    private var searchController: UISearchController!
    
    init(viewModel:MainViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModelObject=viewModel
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        bindUIComponents()
    }
    
    //MARK:animation
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        //checking if preselectedand popped
        if let selectedIndex = self.tableView.indexPathForSelectedRow {
            self.tableView.deselectRow(at: selectedIndex, animated: true)
        }else{
            self.viewModelObject?.loadFirstTimeScreen()
        }
    }
    
    //MARK:TableView Implementation
    func configureTableView() {
        self.title = "Search"
        
        self.tableView = UITableView(frame: UIScreen.main.bounds)
        self.tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        self.view = self.tableView
        self.tableView.estimatedRowHeight = ROW_HEIGHT;
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        
        // Do any additional setup after loading the view.
        self.searchController = UISearchController(searchResultsController: nil)
        self.searchController.dimsBackgroundDuringPresentation = false
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.sizeToFit()
        
        self.tableView.tableHeaderView = self.searchController.searchBar
        
        definesPresentationContext = true
    }
    //MARK:Binding ViewMOdel
    func bindUIComponents() {
        _=searchController.searchBar.rx.text.orEmpty.bind(to: (viewModelObject?.searchKeyword)!)
        
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, PageObject>>(
            configureCell: { dataSource, tableView, indexPath, pageobject in
                let cell = WikiCell(frame: CGRect(origin: CGPoint.init(x: 0, y: 0), size: CGSize(width: UIScreen.main.bounds.width, height: 100)))
                
                cell.configure(title: pageobject.title ?? "" ,
                               description: pageobject.terms?.description?.first ?? "",
                               language: pageobject.thumbnail?.source ?? "",
                               imageObject:  pageobject.thumbnail)
                return cell
        })
        
        _=self.viewModelObject?.firstTimeScreen.subscribe(onNext:{ (flagValue) -> () in
            if(flagValue){
                self.view.addSubview(self.viewModelObject?.firstTimeScreenView ?? UIView())
                self.viewModelObject?.loadFirstTimeScreen()
                self.tableView.isHidden=true
            }else{
                self.viewModelObject?.popFirstTimeScreen()
                self.viewModelObject?.firstTimeScreenView.removeFromSuperview()
            }
        })
        
        self.viewModelObject?.searchResultObjects.asDriver()
            .map { [SectionModel(model: "PageObject", items: $0)] }
            .drive(self.tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        self.viewModelObject?.isLoading.asDriver()
            .drive()
            // .drive(isLoading(for: self.view))
            .disposed(by: disposeBag)
        
        self.tableView.rx.contentOffset
            .subscribe { _ in
                if self.searchController.searchBar.isFirstResponder {
                    _ = self.searchController.searchBar.resignFirstResponder()
                }
            }
            .disposed(by: disposeBag)
        
        self.tableView.rx.modelSelected(PageObject.self)
            .subscribe({ pageobject in
                self.viewModelObject?.tapped(pageObject: pageobject.element!)
            }).disposed(by: disposeBag)
    }
}

//        self.tableView.rx.reachedBottom
//            .bind(to:viewModel.inputs.loadNextPageTrigger)
//            .disposed(by: disposeBag)
//
//        self.tableView.rx.itemSelected
//            .map { (at: $0, animated: true) }
//            .subscribe(onNext: tableView.deselectRow)
//            .disposed(by: disposeBag)


//
//let jeremyGif = UIImage.gifImageWithName("funny")
//let imageView = UIImageView(image: jeremyGif)
//imageView.frame = CGRect(x: 20.0, y: 50.0, width: self.view.frame.size.width - 40, height: 150.0)
//view.addSubview(imageView)
