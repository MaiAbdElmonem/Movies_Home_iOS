//
//  MovieApi.swift
//  Movies Home
//
//  Created by Mai Abd Elmonem on 10/13/19.
//  Copyright © 2019 Mai Ahmed. All rights reserved.
//

import Foundation
import Moya

enum MovieApi {
    case actor(page:Int)
}

extension MovieApi: TargetType {
  
    var baseURL: URL {
        guard let url = URL(string: "https://api.themoviedb.org/3/person/") else { fatalError("baseURL could not be configured") }
        return url
   }
    var path: String {
        switch self {
        case .actor :
            return "popular"
        }
    }
    var method: Moya.Method {
        switch self {
        case .actor:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .actor(let page):
            return .requestParameters(parameters: ["page": page, "api_key": "be6e82ab66a065f245b84e4b4692aee8"] , encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var sampleData: Data {
        switch self {
        case .actor:
          return Data()
        }
    }
}
