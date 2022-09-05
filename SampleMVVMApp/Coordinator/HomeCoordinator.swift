//
//  HomeCoordinator.swift
//  SampleMVVMApp
//
//  Created by mtanaka on 2022/09/02.
//

import UIKit

final class HomeCoordinator: Coordinator {
    
    private var signUpVC: SignUpViewController?
    
    init(signUpVC: SignUpViewController) {
        self.signUpVC = signUpVC
    }
    
    func start() {
        
        let homeVC = UIStoryboard(name: StoryboardName.home.rawValue, bundle: nil).instantiateInitialViewController() as! HomeViewController
        signUpVC?.navigationController?.pushViewController(homeVC, animated: true)
    }
}
