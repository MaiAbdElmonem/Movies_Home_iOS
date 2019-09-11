//
//  File.swift
//  Movies Home
//
//  Created by Lost Star on 9/3/19.
//  Copyright © 2019 Mai Ahmed. All rights reserved.
//

import Foundation

class Actor {
    var name: String = ""
    var profile_path:String=""
    var id=Int()
    var actors : [Actor]=[]

    var net = Network()
    func request(str: String){
        net.whenComplete = { data in
            let content = data!
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
                    
                    
                    actorObj.name = actorname
                    actorObj.profile_path = actorpath
                    actorObj.id = actorId
                    
                    self.actors.append(actorObj)
                }
                //                    DispatchQueue.main.async {
                //                        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
                //                        self.tableView.reloadData()
                //                    }
            }
            
           
            

        }
        
    }
    
    

    
}
