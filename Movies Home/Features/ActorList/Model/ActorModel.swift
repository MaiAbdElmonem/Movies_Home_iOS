//
//  ActorModel.swift
//  Movies Home
//
//  Created by Mai Abd Elmonem on 9/16/19.
//  Copyright © 2019 Mai Ahmed. All rights reserved.
//

import Foundation

class ActorModel: ActorModelProtocol {
    
    var totalResults = 0
    var actors : [Actor]=[]
    let urlStr = ("https://api.themoviedb.org/3/person/popular?api_key=be6e82ab66a065f245b84e4b4692aee8&page=")
    
    
    func getArrCount() -> Int {
        return actors.count
    }
    
    func getName(index: Int) -> String {
        return actors[index].name
    }
    func getImage(index: Int) -> String {
        return actors[index].profile_path
    }
    func refresh() {
        actors.removeAll()
    }
    
    func getResults() -> Int {
        return totalResults
    }
    
    

    func downloadJson(pageNum: Int, completion: @escaping (Bool) -> Void) {
        if pageNum == 1 {
            actors.removeAll()
        }
        
        let url = URL(string: urlStr+"\(pageNum)")!
        //        let urlString = urlJsonString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        //        if urlString != nil {
        //            let url = URL(string: urlString!)
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            
            // ensure there is no error for this HTTP response
            guard error == nil else {
                print ("error: \(error!)")
                return
            }
            
            // ensure there is data returned from this HTTP response
            guard let content = data else {
                print("No data")
                return
            }
            
            //                self.whenComplete!(data)
            //                 serialise the data / NSData object into Dictionary [String : Any]
            guard let json = (try? JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [String: Any] else {
                print("Not containing JSON")
                return
            }
            
            
            //            print("gotten json response dictionary is \n \(json)")
            
            // update UI using the response here
            do{
                
                let actorsresultsArrary = json["results"]
                    as? [Dictionary <String,Any>] ?? []
                
                for i in actorsresultsArrary{
                    let actorObj = Actor()
                    let actorname = i["name"] as? String ?? ""
                    let actorpath = i["profile_path"] as? String ?? ""
                    let actorId = i["id"] as! Int
                    
                    
                    actorObj.name = actorname
                    actorObj.profile_path = actorpath
                    actorObj.id = actorId
                    
                    self.actors.append(actorObj)
                }
                completion(true)
            }
            
            //                self.whenComplete?(self.actors)
            
        }
        
        task.resume()
    }
    
  

    
    
}
