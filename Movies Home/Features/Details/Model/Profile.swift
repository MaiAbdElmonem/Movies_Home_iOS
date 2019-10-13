//
//  Profile.swift
//  Movies Home
//
//  Created by Lost Star on 9/3/19.
//  Copyright © 2019 Mai Ahmed. All rights reserved.
//

import Foundation
import ObjectMapper

struct ProfileApiResponse : Mappable {
    var actorprofiles : [Profiles]?
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        actorprofiles <- map["profiles"]
    }
    
}

struct Profiles : Mappable{
    
     var filePath:String?
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        filePath <- map["file_path"]
    }
    
}
