//
//  File.swift
//  Movies Home
//
//  Created by Lost Star on 9/3/19.
//  Copyright © 2019 Mai Ahmed. All rights reserved.
//

import Foundation
import ObjectMapper

struct ActorApiResponse : Mappable {
    var totalResults : Int?
    var results : [Actor]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        totalResults <- map["total_results"]
        results <- map["results"]
    }


}

struct Actor : Mappable {
    var name: String?
    var profilepath : String?
    var id : Int?
    
    init(id:Int, profilepath:String, name:String) {
        self.id = id
        self.name = name
        self.profilepath = profilepath
    }
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        //string maps api
        id <- map["id"]
        name <- map["name"]
        profilepath <- map["profile_path"]
    }
    
    
    
}

//class Actor {
//    var name: String = ""
//    var profile_path:String=""
//    var id=Int()
//
//}
