//
//  Scene.swift
//  MoneyTap
//
//  Created by Abhinay Varma on 15/09/18.
//  Copyright © 2018 Coffeebeans. All rights reserved.
//

import Foundation
import UIKit.UIViewController

// Any object implementing `SceneType` MUST implement `InstantiatableFromNIB` or `InstantiatableFromStoryboard` protocol
// depending on how it will load ViewController

protocol InstantiatableFromNIB {
    func instantiateFromNIB() -> UIViewController
}

protocol InstantiatableFromStoryboard {
    func instantiateFromStoryboard() -> UIViewController
}

protocol Navigationable {
    func viewController() -> UIViewController
}
