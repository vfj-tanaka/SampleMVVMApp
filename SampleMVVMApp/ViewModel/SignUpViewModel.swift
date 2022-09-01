//
//  SignUpViewModel.swift
//  SampleMVVMApp
//
//  Created by mtanaka on 2022/08/31.
//

import Foundation
import RxSwift
import RxCocoa

final class SignUpViewModel {
    
    struct Input {
        let userNameTextDriver: Driver<String>
        let mailTextDriver: Driver<String>
        let passwordTextDriver: Driver<String>
        let confirmTextDriver: Driver<String>
        let registerTrigger: PublishSubject<Void>
    }
    
    struct Output {
        let validationResult: Driver<ValidationResult>
        let registerResult: Driver<(isSuccessed: Bool, message: String)>

    }
    
    private let disposeBag = DisposeBag()
    private var userName: String?
    private var mail: String?
    private var password: String?
    
    func transform(input: Input) -> Output {
        
        let validationModel = ValidationModel()
        
        let blankValidation: Driver<Bool> = Driver.combineLatest(
            input.userNameTextDriver,
            input.mailTextDriver,
            input.passwordTextDriver,
            input.confirmTextDriver
        ) { userName, mail, password, confirm in
            self.userName = userName
            self.mail = mail
            self.password = password
            return validationModel.blankValidation(text: [userName, mail, password, confirm])
        }
        
        let confirmValidation: Driver<Bool> = Driver.combineLatest(
            input.passwordTextDriver,
            input.confirmTextDriver
        ) { password,confirm in
            return validationModel.confirmValidation(password: password, confirm: confirm)
        }
        
        let validationResult: Driver<ValidationResult> = Driver.combineLatest(
            blankValidation,
            confirmValidation
        ) { blankValidation, confirmValidation in
            if !blankValidation {
                return .blankError
            } else if !confirmValidation {
                return .confirmError
            } else {
                return .ok
            }
        }
        
        let registerResult: Driver<(isSuccessed: Bool, message: String)> =
        input.registerTrigger.asObservable().map { _ in
            return self.doRegister(userName: self.userName, mail: self.mail, password: self.password)
        }.asDriver(onErrorJustReturn: (isSuccessed: false, message: "エラー"))
        
        return Output(validationResult: validationResult, registerResult: registerResult)
    }
    
    private func doRegister(userName: String?, mail: String?, password: String?) ->
    (isSuccessed: Bool, message: String) {
        if let userName = userName, let mail = mail, let password = password {
            var uid = ""
            Firebase.registerAuth(mail: mail, password: password) { result in
                
                switch result {
                case .success(let uidString):
                    uid = uidString
                    print("Authの登録に成功しました")
                case .failure:
                    print("Authの登録に失敗しました")
                    return
                }
                
                Firebase.registerUser(userName: userName, mail: mail, uid: uid) { err in
                    
                    if err != nil {
                        print("ユーザーの登録に失敗しました")
                        return
                    }
                    
                    Firebase.emailAuth(mail: mail) { err in
                        
                        if err != nil {
                            print("認証メールの送信に失敗しました")
                            return
                        }
                    }
                }
            }
        }
        return (isSuccessed: true, message: "")
    }
}
