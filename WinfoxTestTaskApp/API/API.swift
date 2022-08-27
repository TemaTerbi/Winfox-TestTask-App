//
//  API.swift
//  WinfoxTestTaskApp
//
//  Created by TeRb1 on 26.08.2022.
//

import UIKit
import Alamofire

var baseUrl: String {
    return "http://94.127.67.113:8099/"
}

var getPlacesUrl: String {
    return "getPlaces"
}

var getMenuUrl: String {
    return "getMenu/"
}

var checkUser: String {
    return "checkUser/"
}

class ApiManager {
    
    var viewModel = HomeScreenViewModel()
    
    static let shared = ApiManager()
    
    func getPlaces(completion: @escaping ([Places]) -> Void) {
        AF.request(baseUrl + getPlacesUrl).response { responseData in
            guard let data = responseData.data else { return }
            if let places = try? JSONDecoder().decode([Places].self, from: data) {
                completion(places)
            } else {
                print("error of decode")
            }
        }
    }
    
    func getMenu(completion: @escaping ([Menu]) -> Void, id: String) {
        AF.request(baseUrl + getMenuUrl + id).response { responseData in
            guard let data = responseData.data else { return }
            if let menu = try? JSONDecoder().decode([Menu].self, from: data) {
                completion(menu)
            } else {
                print("error of decode")
            }
        }
    }
    
    func postCheckUser(_ number: String, _ id: String) -> Bool {
        var result = false
        
        let params: Parameters = [
            "phone": number,
            "id": id
        ]
        
        AF.request(baseUrl + checkUser, method: .post, parameters: params).validate(statusCode: 200..<299).responseData { response in
            switch response.result {
            case.success(let success):
                result = true
            case.failure(let error):
                print(error)
                result = false
            }
        }
        return result
    }
}
