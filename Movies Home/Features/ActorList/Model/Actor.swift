//
//  File.swift
//  Movies Home
//
//  Created by Lost Star on 9/3/19.
//  Copyright © 2019 Mai Ahmed. All rights reserved.
//

import Foundation
import ObjectMapper

struct Actor : Codable {
    var id : Int?
    var profilepath : String?
    var name: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case profilepath = "profile_path"
        case name = "name"
    }
    
    init(from decoder : Decoder) throws {
        <#statements#>
    }
    
    init(id: Int, profilepath: String, name:String) {
        self.id = id
        self.profilepath = profilepath
        self.name = name
    }
}
//struct ActorApiResponse : Mappable {
//    var totalResults : Int?
//    var results : [Actor]?
//
//    init?(map: Map) {
//
//    }
//
//    mutating func mapping(map: Map) {
//        totalResults <- map["total_results"]
//        results <- map["results"]
//    }
//
//
//}

//struct Actor : Mappable {
//    var name: String?
//    var profilepath : String?
//    var id : Int?
//
//    init(id:Int, profilepath:String, name:String) {
//        self.id = id
//        self.name = name
//        self.profilepath = profilepath
//    }
//
//    init?(map: Map) {
//
//    }
//
//    mutating func mapping(map: Map) {
//        //string maps api
//        id <- map["id"]
//        name <- map["name"]
//        profilepath <- map["profile_path"]
//    }
//

    
}

