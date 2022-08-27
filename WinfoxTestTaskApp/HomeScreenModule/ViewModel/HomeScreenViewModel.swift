//
//  HomeScreenViewModel.swift
//  WinfoxTestTaskApp
//
//  Created by TeRb1 on 26.08.2022.
//

import UIKit

class HomeScreenViewModel {
    
    var places = Dynamic([Places]())
    
    func getAllPlaces() {
        ApiManager.shared.getPlaces { places in
            self.places.value = places
        }
    }
}
