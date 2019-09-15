//
//  Network.swift
//  Movies Home
//
//  Created by Mai Abd Elmonem on 9/10/19.
//  Copyright © 2019 Mai Ahmed. All rights reserved.
//

import Foundation
import UIKit

class Network {
    
     var ActorsArray = Array<Actor>()
   
    let urlStr = ("https://api.themoviedb.org/3/person/popular?api_key=be6e82ab66a065f245b84e4b4692aee8&page=")
    let searchURL = "https://api.themoviedb.org/3/search/person?api_key=facd2bc8ee066628c8f78bbb7be41943&query="
     var totalResults = 0
    
//    var whenComplete: ((Data?)->())?
    
    func downloadJson(pageNum:Int,completion:@escaping (_ success:Bool)->Void){
        if pageNum == 1 {
            ActorsArray.removeAll()
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

                        self.ActorsArray.append(actorObj)
                    }
                     completion(true)
                    
//                    DispatchQueue.main.async {
//                        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
//                        self.tableView.reloadData()
//                    }
                }

//                self.whenComplete?(self.actors)

            }
        
            task.resume()
        }
    

    }
    

