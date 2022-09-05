//
//  SignUpViewController.swift
//  SampleMVVMApp
//
//  Created by mtanaka on 2022/08/31.
//

import UIKit
import RxSwift
import RxCocoa

final class SignUpViewController: UIViewController {
    
    @IBOutlet private weak var userNameTextField: UITextField!
    @IBOutlet private weak var mailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var confirmTextField: UITextField!
    @IBOutlet private weak var statusLabel: UILabel!
    @IBOutlet private weak var registerButton: UIButton!
    @IBOutlet private weak var goToSignInButton: UIButton!
    
    private var viewModel: SignUpViewModel!
    private let disposeBag = DisposeBag()
    private var registerTrigger = PublishSubject<Void>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
    }
    
    private func bind() {
        
        self.viewModel = SignUpViewModel()
        let input = SignUpViewModel.Input(
            userNameTextDriver: userNameTextField.rx.text.orEmpty.asDriver(),
            mailTextDriver: mailTextField.rx.text.orEmpty.asDriver(),
            passwordTextDriver: passwordTextField.rx.text.orEmpty.asDriver(),
            confirmTextDriver: confirmTextField.rx.text.orEmpty.asDriver(),
            registerTrigger: registerTrigger
        )
        
        let output = self.viewModel.transform(input: input)
        output.validationResult.drive { validationResult in
            self.registerButton.isEnabled = validationResult.isValidated
            self.registerButton.layer.borderColor = validationResult.borderColor
            self.registerButton.layer.borderWidth = validationResult.width
            self.registerButton.layer.cornerRadius = validationResult.corner
            self.statusLabel.text = validationResult.text
            self.statusLabel.textColor = validationResult.color
        }
        .disposed(by: disposeBag)
        
        output.registerResult.drive { isSuccess, messsage in
            if !isSuccess {
                print("register fail")
            }
        }.disposed(by: disposeBag)
        
        registerButton.rx.tap.asDriver().drive(onNext: { [weak self] in
            self?.registerTrigger.onNext(())
        })
        .disposed(by: disposeBag)
        
        goToSignInButton.rx.tap.asDriver().drive(onNext: { _ in
            let homeCoordinator = HomeCoordinator(signUpVC: self)
            homeCoordinator.start()
        })
        .disposed(by: disposeBag)
    }
}
