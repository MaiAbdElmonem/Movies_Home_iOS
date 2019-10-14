//
//  ActorModel.swift
//  Movies Home
//
//  Created by Mai Abd Elmonem on 9/16/19.
//  Copyright © 2019 Mai Ahmed. All rights reserved.
//

import Foundation
import Alamofire
import Moya

class ActorModel: ActorModelProtocol {
   
    var totalResults = 0
    var actors : [Actor]=[]
    let baseUrl = ("https://api.themoviedb.org/3/person/popular?api_key=be6e82ab66a065f245b84e4b4692aee8&page=")
    
    
    func getArrCount() -> Int {
        return actors.count
    }
    func getActors(index: Int) -> Actor {
       return actors[index]
    }

    func refresh() {
        actors.removeAll()
    }
    
    func getResults() -> Int {
        return totalResults
    }
    
let provider = MoyaProvider<MovieApi>(plugins: [NetworkLoggerPlugin(verbose: true)])
    
    func downloadJson(pageNum: Int, completion: @escaping (Bool) -> Void) {
        if pageNum == 1 {
            actors.removeAll()
        }
        provider.request(.actor(page: pageNum)) { result in
            switch result {
                case .success(let response):
                    do{
                        let results = try JSONDecoder().decode(ActorApiResponse.self, from: response.data )
                self.actors.append(contentsOf: (results.results)!)
                completion(true)
                    }catch {
                }
            case .failure(let error):
                print(error)
                completion(false)
                        
            }
        }
     }
}
//        Alamofire.request(baseUrl + "\(pageNum)").responseString { (response) in
//            switch response.result {
//
//            case .success:
//                let apiResponse = ActorApiResponse(JSONString: response.result.value!)
//                self.actors.append(contentsOf: (apiResponse?.results)!)
//             completion(true)
//            case .failure(let error):
//                print(error)
//                completion(false)
//            }
//        }
        

 


