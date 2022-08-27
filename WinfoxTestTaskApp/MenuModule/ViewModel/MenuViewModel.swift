//
//  MenuViewModel.swift
//  WinfoxTestTaskApp
//
//  Created by TeRb1 on 27.08.2022.
//

import UIKit

class MenuViewModel {
    
    var menu = Dynamic([Menu]())
    
    func getMenu(_ id: String) {
        ApiManager.shared.getMenu(completion: { menu in
            self.menu.value = menu
        }, id: id)
    }
}
