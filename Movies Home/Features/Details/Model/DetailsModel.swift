//
//  DetailsModel.swift
//  Movies Home
//
//  Created by mai ahmed on 9/26/19.
//  Copyright © 2019 Mai Ahmed. All rights reserved.
//

import Foundation

class DetailsModel : DetailsModelProtocol {
    var profilesArr:[Profiles]=[]
    func getactorprofileImage(index: Int) -> String {
        return profilesArr[index].file_path
    }
    
    
    func getprofileArrCount() -> Int {
        return profilesArr.count
    }
    
    
   
    var person : MovieDetailsViewController?
    var baseUrl : String?
    var file_path:String=""
    var actorId = Int()
    init(person:MovieDetailsViewController) {
        self.person = person
        self.person!.personId = actorId
        self.baseUrl = "https://api.themoviedb.org/3/person/\(actorId)/images?api_key=cb8effcf3a0b27a05a7daba0064a32e1"
       
    }
    
    func getActorProfilesJson(actorId:Int,completion: @escaping (_ success:Bool)->Void) {
        let url = URL(string:baseUrl!)
        let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
            
            guard error == nil else {
                print("returning error")
                return
            }
            
            guard let content = data else {
                print("not returning data")
                return
            }
            
            
            guard let json = (try? JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [String: Any] else {
                print("Not containing JSON")
                return
            }
            
            
            do{
                let profilesArray = json["profiles"] as? [Dictionary<String,Any>] ?? []
                print(profilesArray)
                self.profilesArr.removeAll()
                
                
                for p in profilesArray{
                    let profileObj=Profiles()
                    self.file_path=p["file_path"] as? String ?? ""
                    profileObj.file_path=self.file_path
                    self.profilesArr.append(profileObj)
                }
//                self.updateData()
                
                completion(true)
            }
        }
        
        task.resume()
    }

    
//    var person : Profiles?
   
//    let profileBaseUrl=URL(string:"https://api.themoviedb.org/3/person/\(personId)/images?api_key=cb8effcf3a0b27a05a7daba0064a32e1")
    
}
