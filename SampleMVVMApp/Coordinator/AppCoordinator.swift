//
//  AppCoordinator.swift
//  SampleMVVMApp
//
//  Created by mtanaka on 2022/09/02.
//

import UIKit

final class AppCoordinator: Coordinator {
    
    let window: UIWindow
    
    init(window: UIWindow) {
        
        self.window = window
    }
    
    func start() {
        
        let signUpVC = UIStoryboard(name: StoryboardName.signUp.rawValue, bundle: nil).instantiateInitialViewController() as! SignUpViewController
        let navSignUpVC = UINavigationController(rootViewController: signUpVC)
        window.rootViewController = navSignUpVC
        window.makeKeyAndVisible()
    }
}

