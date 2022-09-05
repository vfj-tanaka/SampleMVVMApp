//
//  SignUpCoordinator.swift
//  SampleMVVMApp
//
//  Created by mtanaka on 2022/09/05.
//

import UIKit

final class SignUpCoordinator: Coordinator {
    
    private let navigator: UINavigationController
    private var nextCoordinator: Coordinator?
    
    init(navigator: UINavigationController) {
        self.navigator = navigator
    }
    
    func start() {
        let vc = SignUpViewController()
        
    }
}
