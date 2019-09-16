//
//  ActorListViewController.swift
//  Movies Home
//
//  Created by Mai Abd Elmonem on 9/10/19.
//  Copyright © 2019 Mai Ahmed. All rights reserved.
//

import UIKit

class ActorListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate ,ActorViewProtocol{
    
    var presenter:ActorListPresenter?
   
//     var actorPage:Int = 1

    var  imageURL="https://image.tmdb.org/t/p/w500/"

   
    @IBOutlet weak var actorsTableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = ActorListPresenter(actorview: self, actormodel: ActorModel())
       presenter?.getJson()
        
        actorsTableView.refreshControl = UIRefreshControl()
        actorsTableView.refreshControl!.attributedTitle = NSAttributedString(string: "Pull to refresh")
        actorsTableView.refreshControl!.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        
        
    }
    
    @objc func refresh() {
        presenter?.refresh()
        presenter?.getJson()
    }

    func reloading(){
        DispatchQueue.main.async {
            self.actorsTableView.separatorStyle = .singleLine
            self.actorsTableView.reloadData()
            self.actorsTableView.refreshControl?.endRefreshing()
        }
        
    }
    
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return presenter!.getarrCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath ) as? ActorTableViewCell
        
//        cell?.actorName.text=networkService.ActorsArray[indexPath.row].name
       
        if (indexPath.row == presenter!.getarrCount()-3 && presenter?.getarrCount() != presenter?.getResults()){
            presenter?.incrementPage()
            presenter?.getJson()
        }
        if presenter!.getarrCount() != 0 {
             cell?.actorName.text = presenter!.getName(index:indexPath.row)
        }
        return cell!
    }
    
    
//         func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//            print("You selected row #\(indexPath.row)!")
//            let myVC = storyboard?.instantiateViewController(withIdentifier: "dvc") as! MovieDetailsViewController
//            myVC.stringPassed = networkService.ActorsArray[indexPath.row].name
////            myVC.theImagePassed =  actors[indexPath.row].profile_path
//            myVC.idPassed = networkService.ActorsArray[indexPath.row].id
//            navigationController?.pushViewController(myVC, animated: true)
//    
//        }
    
    func reloadTableData(){
        DispatchQueue.main.async {
            self.actorsTableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
                self.actorsTableView.reloadData()
        }    
    }
}

