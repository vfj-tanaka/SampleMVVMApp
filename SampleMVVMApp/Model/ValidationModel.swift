//
//  ValidationModel.swift
//  SampleMVVMApp
//
//  Created by mtanaka on 2022/08/31.
//

import Foundation
import UIKit

enum ValidationResult {
    
    case ok, blankError, confirmError
    
    var isValidated: Bool {
        
        switch self {
        case .ok: return true
        case .blankError, .confirmError: return false
        }
    }
    
    var text: String {
        
        switch self {
        case .ok: return "登録可能です"
        case .blankError: return "空欄があります"
        case .confirmError: return "パスワードが確認用と一致しません"
        }
    }
    
    var color: UIColor {
        
        switch self {
        case .ok: return .green
        case .blankError, .confirmError: return .red
        }
    }
    
    var borderColor: CGColor {
        
        switch self {
        case .ok: return UIColor.black.cgColor
        case .blankError, .confirmError: return UIColor.lightGray.cgColor
        }
    }
    
    var width: CGFloat {
        
        switch self {
        case .ok, .blankError, .confirmError: return 1
        }
    }
    
    var corner: CGFloat {
        
        switch self {
        case .ok, .blankError, .confirmError: return 5
        }
    }
}

final class ValidationModel {
    //[String]の中に空文字があればfalse
    func blankValidation(text: [String]) -> Bool {
        
        for text in text {
            if text.isEmpty {
                return false
            }
        }
        return true
    }
    // パスワードと確認用が一致してなかったらfalse
    func confirmValidation(password: String, confirm: String) -> Bool {
        
        return password == confirm
    }
}
