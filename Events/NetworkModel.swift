//
//  NetworkModel.swift
//  Events
//
//  Created by Muhammad Aaraiz Wasim on 23/08/2022.
//

import UIKit
import Alamofire
import AlamofireSwiftyJSON
import AlamofireImage
import SwiftyJSON

class NetworkingClient{
    var fruitlist : FruitList?
    typealias WebServiceResponse = (FruitList?) -> Void

    func getJSONData(completion: @escaping WebServiceResponse){
        
        let jsonUrl = "https://www.fruityvice.com/api/fruit/all"
        
        Alamofire.request(jsonUrl).validate(statusCode: 200..<300).responseJSON{(response) in

            switch response.result
            {
            case .success:
                guard let data = response.data else {return}
                guard let response = try? JSONDecoder().decode(FruitList.self, from: data) else {return}
                completion(response)
                debugPrint("FruitList::\(response.count)")
                print(response.count)
                case .failure:
                completion(nil)
                debugPrint("Error Occured")
                
            }
        }
    }
    

}
// MARK: - FruitListElement

struct FruitListElement: Codable {

    let genus, name: String
    let id: Int
    let family, order: String
    let nutritions: Nutritions

}

// MARK: - Nutritions

struct Nutritions: Codable {

    let carbohydrates, protein, fat: Double
    let calories: Int
    let sugar: Double

}

typealias FruitList = [FruitListElement]
