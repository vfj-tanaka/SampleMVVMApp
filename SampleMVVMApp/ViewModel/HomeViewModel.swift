//
//  HomeViewModel.swift
//  SampleMVVMApp
//
//  Created by mtanaka on 2022/09/05.
//

import Foundation
import RxSwift
import RxCocoa

final class HomeViewModel {
    
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    private let disposeBag = DisposeBag()
    
    func logout() {
        
        Firebase.logoutAuth { err in
            if err != nil {
                print("ログアウト時にエラーになりました。")
                return
            }
        }
    }
}
