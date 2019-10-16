//
//  DetailsModel.swift
//  Movies Home
//
//  Created by mai ahmed on 9/26/19.
//  Copyright © 2019 Mai Ahmed. All rights reserved.
//

import Foundation
import Alamofire

class DetailsModel : DetailsModelProtocol {
    var profilesArr:[Profiles]=[]
    var person : Actor?
    var baseUrl : String?
    
    init(person:Actor) {
        self.person = person
         self.baseUrl = "https://api.themoviedb.org/3/person/\(person.id!)/images?api_key=cb8effcf3a0b27a05a7daba0064a32e1"
    }
    func getactorprofileImage(index: Int) -> String {
        return profilesArr[index].filePath!
    }
    
    func getActorName() -> String {
        return (person?.name)!
    }
    
    func getActorProfilepath() -> String {
        return (person?.profilepath)!
    }
    
    func getprofileArrCount() -> Int {
        return profilesArr.count
    }
    
    func getActorProfilesJson(completion: @escaping (_ success:Bool)->Void) {
        Alamofire.request(baseUrl!).responseString{ (response) in
                   print(response)
            switch response.result {
            case .success:
                let profileResponse = ProfileApiResponse(JSONString: response.result.value!)
                guard let profil = profileResponse?.actorprofiles else {return}
                self.profilesArr.append(contentsOf: profil)
            print(profil)
                completion(true)
                
            case .failure(let error):
                print(error)
                completion(false)
            }
        }
    }
    
 }

