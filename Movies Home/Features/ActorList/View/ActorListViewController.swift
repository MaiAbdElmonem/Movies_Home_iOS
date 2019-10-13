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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return presenter!.getarrCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath ) as? ActorTableViewCell
//        if (indexPath.row == presenter!.getarrCount()-3 && presenter?.getarrCount() != presenter?.getResults()){
//            presenter?.incrementPage()
//            presenter?.getJson()
//        }
       
        if (indexPath.row < (presenter?.getarrCount())!){
            let getActorObj = presenter?.getActors(index: indexPath.row)
            cell?.configureCell(actor: getActorObj!)
        }
        return cell!
    }
    
    
         func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           print("You selected row #\(indexPath.row)!")
            ActorRouter.navigateToActorDetails(at: self.navigationController!, with: (presenter?.getActors(index: indexPath.row))!  )
//            let myVC = storyboard?.instantiateViewController(withIdentifier: "dvc") as! MovieDetailsViewController
//            let selected = actorsTableView.cellForRow(at: indexPath) as! ActorTableViewCell
//            presenter?.showDetail(index: indexPath.row)
//            myVC.stringPassed = indexPath
//            myVC.theImagePassed = indexPath
//            myVC.idPassed = indexPath
//            navigationController?.pushViewController(myVC, animated: true)
        }

    func reloadTableData(){
        DispatchQueue.main.async {
            self.actorsTableView.separatorStyle = .singleLine
            self.actorsTableView.reloadData()
            self.actorsTableView.refreshControl?.endRefreshing()
        }    
    }
    func navigateToActorDetails(actor: Actor) {
        let detailsViewController = storyboard?.instantiateViewController(withIdentifier: "dvc") as! MovieDetailsViewController
        detailsViewController.detailsPresenter = DetailPresenter(profileView: detailsViewController, profileModel: DetailsModel(personObj: actor))
            navigationController?.pushViewController(detailsViewController, animated: true)
    }
}

