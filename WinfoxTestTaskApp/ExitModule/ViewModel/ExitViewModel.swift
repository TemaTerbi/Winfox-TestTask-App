//
//  ExitViewModel.swift
//  WinfoxTestTaskApp
//
//  Created by TeRb1 on 27.08.2022.
//

import UIKit
import Firebase

class ExitViewModel {
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error)
        }
    }
}
