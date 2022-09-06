//
//  SignUpCoordinator.swift
//  SampleMVVMApp
//
//  Created by mtanaka on 2022/09/05.
//

import UIKit

final class SignUpCoordinator: Coordinator {
    
    private var signInVC: SignInViewController?
    
    init(signInVC: SignInViewController) {
        self.signInVC = signInVC
    }
    
    func start() {
        
        let signUpVC = UIStoryboard(name: StoryboardName.signUp.rawValue, bundle: nil).instantiateInitialViewController() as! HomeViewController
        signInVC?.navigationController?.pushViewController(signUpVC, animated: true)
    }
}
