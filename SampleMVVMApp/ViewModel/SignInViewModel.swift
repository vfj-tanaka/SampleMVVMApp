//
//  SignInViewModel.swift
//  SampleMVVMApp
//
//  Created by mtanaka on 2022/09/05.
//

import Foundation
import RxSwift
import RxCocoa

final class SignInViewModel {
    
    struct Input {
        let mailTextDriver: Driver<String>
        let passwordTextDriver: Driver<String>
        let loginTrigger: PublishSubject<Void>
    }
    
    struct Output {
        let validationResult: Driver<ValidationResult>
        let loginResult: Driver<(isSuccessed: Bool, message: String)>
    }
    
    private let disposeBag = DisposeBag()
    private var mail: String?
    private var password: String?
    
}
