//
//  PhoneNumberViewModel.swift
//  WinfoxTestTaskApp
//
//  Created by TeRb1 on 26.08.2022.
//

import UIKit
import FirebaseAuth

class PhoneNumberViewModel {
    var verificationId = Dynamic("")
    var codeSend = Dynamic(false)
    
    func fetchCode(_ number: String) {
        PhoneAuthProvider.provider().verifyPhoneNumber(number, uiDelegate: nil) { verificationId, error in
            if error == nil {
                self.verificationId.value = verificationId ?? ""
                self.codeSend.value = true
                UserDefaults.standard.set(self.verificationId.value, forKey: "verificationId")
                UserDefaults.standard.set(number, forKey: "number")
            } else {
                print(error?.localizedDescription)
            }
        }
    }
}
