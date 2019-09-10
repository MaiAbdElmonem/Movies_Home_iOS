//
//  Network.swift
//  Movies Home
//
//  Created by Mai Abd Elmonem on 9/10/19.
//  Copyright © 2019 Mai Ahmed. All rights reserved.
//

import Foundation

class Network {
    
    func downloadJson(urlJsonString:String) {
        //        let config = URLSessionConfiguration.default
        //        let session = URLSession(configuration: config)
        let urlString = urlJsonString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        if urlString != nil {
            let url = URL(string: urlString!)
            
            let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
                
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
                
                // serialise the data / NSData object into Dictionary [String : Any]
                guard let json = (try? JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [String: Any] else {
                    print("Not containing JSON")
                    return
                }
                
                //            print("gotten json response dictionary is \n \(json)")
                // update UI using the response here
                do{
                    
                    let actorsArrary = json["results"]
                        as? [Dictionary <String,Any>] ?? []
                    
                    for i in actorsArrary{
                        let actorObj = Actor()
                        let actorname = i["name"] as? String ?? ""
                        let actorpath = i["profile_path"] as? String ?? ""
                        let actorId = i["id"] as! Int
                        //                 let actorKnownForDepartment=i["known_for_department"] as? String ?? ""
                        
                        actorObj.name = actorname
                        actorObj.profile_path = actorpath
                        actorObj.id = actorId
                        //                actorObj.known_for_department = actorKnownForDepartment
                        
                        self.actors.append(actorObj)
                    }
//                    DispatchQueue.main.async {
//                        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
//                        self.tableView.reloadData()
//                    }
                }
                
            }
            
            task.resume()
        }
    }
    
}
