//
//  ActorListViewController.swift
//  Movies Home
//
//  Created by Mai Abd Elmonem on 9/10/19.
//  Copyright © 2019 Mai Ahmed. All rights reserved.
//

import UIKit

class ActorListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate{
    let searchBar = UISearchBar()
    
    @IBOutlet weak var searchOutlet: UIBarButtonItem!
    var searchText:String?
    
     var refreshControl: UIRefreshControl!
    let networkService = Network()
     var actorPage:Int = 1
//    var actors : [Actor]=[]
    var  imageURL="https://image.tmdb.org/t/p/w500/"
//    var totalResults = 0
    var currentPageNum=1
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
        actorsTableView.refreshControl = UIRefreshControl()
        actorsTableView.refreshControl?.attributedTitle = NSAttributedString(string: "refresh")
        actorsTableView.refreshControl?.addTarget(self, action: #selector(refresh(sender:)), for: UIControl.Event.valueChanged)
        actorsTableView.addSubview(actorsTableView.refreshControl!) // not required when using UITableViewController
        self.networkService.downloadJson(pageNum: 1){ [weak self] success in
            if(success){
                self?.reloadTableData()
            }
        }
        
        
    }
    
    @objc func refresh(sender:AnyObject) {
        actorPage = 1
        networkService.ActorsArray.removeAll()
        networkService.downloadJson(pageNum: 1){ [weak self] success in
            if(success){
                DispatchQueue.main.async {
                    self?.actorsTableView.refreshControl?.endRefreshing()
                }
                self?.reloadTableData()
            }
        }
    }
    
    @IBAction func searchFunc (sender:AnyObject) {
        self.searchBar.text = ""
        self.actorsTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.navigationItem.rightBarButtonItem = nil
        createSearchBar()
        setGestures()
    }
    
    func setGestures(){
        
        let keyboardTap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        keyboardTap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(keyboardTap)
        
    }
    @objc func hideKeyboard(){
        print("hideKeyboard")
        searchBar.resignFirstResponder()
        self.view.endEditing(true)
        if let cancelButton = self.searchBar.value(forKey: "cancelButton") as? UIButton {
            cancelButton.isEnabled = true
        }
    }
    
    func createSearchBar(){
        
        self.searchBar.showsCancelButton = true
        searchBar.placeholder = "Search Person"
        self.searchBar.becomeFirstResponder()
        
        self.searchBar.tintColor = UIColor.lightGray
        self.navigationItem.titleView = searchBar
        self.view.endEditing(false)
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("textDidChange")
        networkService.ActorsArray=[]
        actorsTableView.reloadData()
        self.searchText = searchText
        
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
        print("searchBarTextDidEndEditing")
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("searchBarSearchButtonClicked")
        
        searchBar.resignFirstResponder()
        if let cancelButton = self.searchBar.value(forKey: "cancelButton") as? UIButton {
            cancelButton.isEnabled = true
        }
        
        self.networkService.downloadJson(pageNum: 1){ [weak self] success in
            if(success){
                let s=self!.networkService.searchURL
                s+self!.searchText!
            }
        }
    }
        
    
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
         networkService.ActorsArray=[]
        actorsTableView.reloadData()
        print("searchBarTextDidBeginEditing")
        
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        if let cancelButton = self.searchBar.value(forKey: "cancelButton") as? UIButton {
            cancelButton.isEnabled = true
        }
        searchBar.text = ""
        searchBar.showsCancelButton = false
        
        hideSearchBar()
    }
    
    
    func hideSearchBar() {
        
        navigationItem.titleView = nil
        self.navigationItem.rightBarButtonItem = self.searchOutlet
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem(rawValue: 12)! , target: self, action: #selector(searchFunc))
        networkService.ActorsArray=[]
       actorsTableView.reloadData()
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
        
        let imagepath=imageURL + networkService.ActorsArray[indexPath.row].profile_path
//        cell?.actorImage.image = imagepath
        
        if (indexPath.row == networkService.ActorsArray.count-3) {
            self.currentPageNum += 1
            
            networkService.downloadJson(pageNum: self.currentPageNum){ [weak self] success in
                if(success){
                    self?.reloadTableData()
                }
            }
        }
        return cell!
        }
    
    
         func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            print("You selected row #\(indexPath.row)!")
            let myVC = storyboard?.instantiateViewController(withIdentifier: "dvc") as! MovieDetailsViewController
            myVC.stringPassed = networkService.ActorsArray[indexPath.row].name
//            myVC.theImagePassed =  actors[indexPath.row].profile_path
            myVC.idPassed = networkService.ActorsArray[indexPath.row].id
            navigationController?.pushViewController(myVC, animated: true)
    
        }
    
    func reloadTableData(){
        DispatchQueue.main.async {
            self.actorsTableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
                self.actorsTableView.reloadData()
        }    
    }
}

