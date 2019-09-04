//
//  ViewController.swift
//  Movies Home
//
//  Created by Lost Star on 9/2/19.
//  Copyright © 2019 Mai Ahmed. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
}
   
    
    
//     var actorId = Int()
//    var textPass = ""
//    var ImagePass = ""
//    var idPass = Int()
//    var profiles:[Profiles]=[]
    
    
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//
//        actorId = idPass
//        downloadJSON(actorId:actorId)
//
//    }
//
//    func downloadJSON(actorId:Int) {
//        let strID = "\(actorId)"
//        let imagesUrl="https://api.themoviedb.org/3/person/"+strID + "/images?api_key=be6e82ab66a065f245b84e4b4692aee8"
//        print(imagesUrl)
//        let url = URL(string:imagesUrl)
//        let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
//
//            guard error == nil else {
//                print ("error: \(error!)")
//                return
//            }
//
//            guard let content = data else {
//                print("No data")
//                return
//            }
//
//
//            guard let json = (try? JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [String: Any] else {
//                print("Not containing JSON")
//                return
//            }
//
//            do{
//                let profilesArray = json["profiles"] as? [Dictionary<String,Any>] ?? []
//                print(profilesArray)
////                self.profiles.removeAll()
//
//
////                for p in profilesArray{
////                    let profileObj=Profiles()
////                    let filepath = p["file_path"] as? String ?? ""
////                    profileObj.file_path = filepath
////                    self.profiles.append(profileObj)
//                }
//
////                DispatchQueue.main.async {
////                    self.collectionview.reloadData()
////                }
////
//            }
//
//        }
//
//        task.resume()
//
//    }
//
//    func getImage(_ url_str:String, _ imageView:UIImageView)
//    {
//
//        let url:URL = URL(string: url_str)!
//        let session = URLSession.shared
//
//        let task = session.dataTask(with: url, completionHandler: {
//            (
//            data, response, error) in
//
//
//            if data != nil
//            {
//                let image = UIImage(data: data!)
//
//
//                if(image != nil)
//                {
//
//                    DispatchQueue.main.async(execute: {
//
//                        imageView.image = image
//
//                    })
//                }
//            }
//        })
//
//        task.resume()
//    }
//
//
//
////    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
////        return profiles.count
////    }
////
////    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
////        let cell = collectionview.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
//
//        let url="https://image.tmdb.org/t/p/w500/"
//        let path = url + profiles[indexPath.row].file_path
//        getImage(path,cell.collectionviewImg)
//        return cell
//    }
//
//
//
//
//
//}
//
