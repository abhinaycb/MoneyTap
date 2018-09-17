//
//  SceneCoordinatorType.swift
//  MoneyTap
//
//  Created by Abhinay Varma on 15/09/18.
//  Copyright © 2018 Coffeebeans. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

protocol SceneCoordinatorType {
    init(window: UIWindow)
    
    var currentViewController: UIViewController? { get set }
    
    @discardableResult
    func transition(to scene: Navigationable, type: SceneTransitionType) -> Completable
}


enum SceneTransitionType {
    enum PopType {
        case root
        case parent
        case vc(viewController: UIViewController)
    }
    
    case root
    case push(animated: Bool)
    case modal(animated: Bool)
    case pop(animated: Bool, level: PopType)
}
