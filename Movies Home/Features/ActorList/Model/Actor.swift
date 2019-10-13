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
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try values.decode(String.self, forKey: .name)
        self.id = try values.decode(Int.self, forKey: .id)
        self.profilepath = try values.decodeIfPresent(String.self, forKey: .profilepath)
    }
    
    init(id: Int, profilepath: String, name:String) {
        self.id = id
        self.profilepath = profilepath
        self.name = name
    }
    
}

