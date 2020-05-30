//
//  MainRouter.swift
//  Logger
//
//  Created by Vitor Spessoto on 5/12/20.
//  Copyright © 2020 Vitor Spessoto. All rights reserved.
//

import Foundation
import UIKit

final class MainRouter {
    
    //*************************************************
    // MARK: - Public Properties
    //*************************************************
    static let instance = MainRouter()
    
    //*************************************************
    // MARK: - Private Properties
    //*************************************************
    private var navigationController: UINavigationController?
    
    //*************************************************
    // MARK: - Public Methods
    //*************************************************
    func start(window: UIWindow) {
        window.makeKeyAndVisible()
        window.frame = UIScreen.main.bounds
        
        let mainViewController = ViewController()
        let textAttributes = NSAttributedString.attributes(style: .bigTitle)
        
        navigationController = UINavigationController(rootViewController: mainViewController)
        
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.backgroundColor = StyleGuide.ViewStyle.NaviagationBar.backgroundColor
        
        window.rootViewController = navigationController
    }
}
