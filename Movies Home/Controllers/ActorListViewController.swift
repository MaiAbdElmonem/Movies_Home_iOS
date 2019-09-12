//
//  ActorListViewController.swift
//  Movies Home
//
//  Created by Mai Abd Elmonem on 9/10/19.
//  Copyright © 2019 Mai Ahmed. All rights reserved.
//

import UIKit

class ActorListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    let networkService = Network()
     var actorPage:Int = 1
//    var actors : [Actor]=[]
    
    
    @IBOutlet weak var actorsTableView: UITableView!
    
       
  

    override func viewDidLoad() {
        super.viewDidLoad()
       
//        networkService.whenComplete={arr in self.actors=arr
//            DispatchQueue.main.async {
//                                        self.actorsTableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
//                                        self.actorsTableView.reloadData()
//                                    }
//        }
//          networkService.downloadJson(urlJsonString: networkService.urlStr)
        self.networkService.downloadJson(pageNum: 1){ [weak self] success in
            if(success){
                self?.reloadTableData()
            }
        }
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return networkService.ActorsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath ) as? ActorTableViewCell
        
        cell?.actorName.text=networkService.ActorsArray[indexPath.row].name
        
        return cell!
    }
    
    func reloadTableData(){
        DispatchQueue.main.async {
            self.actorsTableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
                self.actorsTableView.reloadData()
        }
    
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
