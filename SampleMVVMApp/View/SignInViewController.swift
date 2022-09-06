//
//  SignInViewController.swift
//  SampleMVVMApp
//
//  Created by mtanaka on 2022/09/05.
//

import UIKit
import RxSwift
import RxCocoa

final class SignInViewController: UIViewController {
    
    @IBOutlet private weak var mailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var goToSignUpButton: UIButton!
    
    private var viewModel: SignInViewModel!
    private let disposeBag = DisposeBag()
    private var loginTrigger = PublishSubject<Void>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
    }
    
    func bind() {
        
        
        self.viewModel = SignInViewModel()
        //        let input = SignInViewModel.Input
        //            mailTextDriver: mailTextField.rx.text.orEmpty.asDriver(),
        //            passwordTextDriver: passwordTextField.rx.text.orEmpty.asDriver()
        //        )
        
        loginButton.rx.tap.asDriver().drive(onNext: { [weak self] in
            self?.loginTrigger.onNext(())
        })
        .disposed(by: disposeBag)
        
        goToSignUpButton.rx.tap.asDriver().drive(onNext: { [weak self] in
            //            let homeCoordinator = HomeCoordinator(signUpVC: self)
            //            homeCoordinator.start()
        })
        .disposed(by: disposeBag)
        
    }
}
