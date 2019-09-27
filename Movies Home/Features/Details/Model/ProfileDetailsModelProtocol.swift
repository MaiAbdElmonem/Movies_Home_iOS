//
//  ProfileDetailsModelProtocol.swift
//  Movies Home
//
//  Created by mai ahmed on 9/26/19.
//  Copyright © 2019 Mai Ahmed. All rights reserved.
//

import Foundation

protocol DetailsModelProtocol {
    func getActorProfilesJson(actorId:Int,completion:@escaping (_ success:Bool)->Void)  
    func getprofileArrCount() -> Int
    func getactorprofileImage(index:Int) -> String 
}
