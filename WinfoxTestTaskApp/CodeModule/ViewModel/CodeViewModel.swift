//
//  CodeViewModel.swift
//  WinfoxTestTaskApp
//
//  Created by TeRb1 on 26.08.2022.
//

import UIKit
import Firebase

class CodeViewModel {
    let verificationId = UserDefaults.standard.string(forKey: "verificationId") ?? ""
    let number = UserDefaults.standard.string(forKey: "number") ?? ""
    let login = Dynamic(false)
    let error = Dynamic(false)
    
    func sigIn(_ code: String) {
        let creditional = PhoneAuthProvider.provider().credential(withVerificationID: verificationId, verificationCode: code)
        
        Auth.auth().signIn(with: creditional) { _, error in
            if error == nil {
                let successCheckUser = ApiManager.shared.postCheckUser(self.number, self.verificationId)
                if successCheckUser {
                    self.login.value = true
                } else {
                    self.login.value = false
                }
            } else {
                self.error.value = true
                print(error?.localizedDescription)
            }
        }
    }
}
