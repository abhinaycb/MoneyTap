//
//  SceneTransitionType.swift
//  MoneyTap
//
//  Created by Abhinay Varma on 15/09/18.
//  Copyright © 2018 Coffeebeans. All rights reserved.
//

import Foundation
import UIKit

protocol SceneType: Navigationable {
    associatedtype ViewModelType
    
    var viewModel: ViewModelType { get set }
    
    func viewController() -> UIViewController
    
}
