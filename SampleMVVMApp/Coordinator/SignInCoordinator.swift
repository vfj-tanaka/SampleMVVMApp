//
//  SignInCoordinator.swift
//  SampleMVVMApp
//
//  Created by mtanaka on 2022/09/05.
//

import UIKit

final class SignInCoordinator: Coordinator {
    
    private var signUpVC: SignUpViewController?
    
    init(signUpVC: SignUpViewController) {
        self.signUpVC = signUpVC
    }
    
    func start() {
        
        let signInVC = UIStoryboard(name: StoryboardName.signIn.rawValue, bundle: nil).instantiateInitialViewController() as! HomeViewController
        signUpVC?.navigationController?.pushViewController(signInVC, animated: true)
    }
}
