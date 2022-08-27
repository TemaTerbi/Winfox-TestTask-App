//
//  MapViewModel.swift
//  WinfoxTestTaskApp
//
//  Created by TeRb1 on 27.08.2022.
//

import UIKit

class MapViewModel {
    
    var places = Dynamic([Places]())
    
    func getAllPlaceMarks() {
        ApiManager.shared.getPlaces { places in
            self.places.value = places
        }
    }
    
}
