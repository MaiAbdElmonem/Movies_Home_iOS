//
//  ActorTableViewController.swift
//  Movies Home
//
//  Created by Lost Star on 9/3/19.
//  Copyright © 2019 Mai Ahmed. All rights reserved.
//

import UIKit

class ActorTableViewController: UITableViewController ,UISearchBarDelegate {
     let searchBar = UISearchBar()
    
    @IBOutlet weak var searchOutlet: UIBarButtonItem!
    var actorImg  : UIImageView!
    var namelabel : UILabel!
    var actorPage:Int = 1
    
    var actors: [Actor] = []
    
    
    var searchText:String?
 let urlStr = ("https://api.themoviedb.org/3/person/popular?api_key=be6e82ab66a065f245b84e4b4692aee8")
     let searchURL = "https://api.themoviedb.org/3/search/person?api_key=facd2bc8ee066628c8f78bbb7be41943&query="
    
    override func viewDidLoad() {
        super.viewDidLoad()
         searchBar.delegate = self
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem(rawValue: 12)! , target: self, action: #selector(searchFunc))
        
        self.tableView.refreshControl = UIRefreshControl()
        self.tableView.refreshControl?.attributedTitle = NSAttributedString(string: "Refresh")
        self.tableView.refreshControl?.addTarget(self, action: #selector(refersh(_:)), for: UIControl.Event.valueChanged)
        self.tableView.addSubview(self.tableView.refreshControl!) // not required when using UITableViewController
        
        
        downloadJson(urlJsonString: urlStr)
    }
    

    
    
    @IBAction func refersh(_ sender: UIRefreshControl) {
        actors.removeAll()
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        hideSearchBar()
        downloadJson(urlJsonString: urlStr)
        sender.endRefreshing()
//        let elementindex = actors.count
//        actors.append(actors[elementindex])
         self.tableView.reloadData()
        
    }
    
    @IBAction func searchFunc (sender:AnyObject) {
      self.searchBar.text = ""
      self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
       
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
        actors = []
        self.tableView.reloadData()
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
        if searchText != nil {
            downloadJson(urlJsonString: searchURL+""+searchText!)
        }
        
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
       actors = []
        self.tableView.reloadData()
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
        self.actors = []
        self.tableView.reloadData()
        downloadJson(urlJsonString: urlStr)
        
    }
    
    
    
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
            DispatchQueue.main.async {
                self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
                self.tableView.reloadData()
            }
        }
            
        }
        
        task.resume()
        }
    }
    
    func getImage(_ url_str:String, _ indexPath :IndexPath)
    {
        
        let url:URL = URL(string: url_str)!
        let session = URLSession.shared
        
        let task = session.dataTask(with: url, completionHandler: {
            (
            data, response, error) in
            
            
            if data != nil
            {
                let img = UIImage(data: data!)
                
                
                if(img != nil)
                {
                    
                    DispatchQueue.main.async(execute: {
                       let imgCell = self.tableView.cellForRow(at: indexPath)
                        
                        if (imgCell != nil){
                        self.actorImg = imgCell?.viewWithTag(1)  as? UIImageView
                        self.actorImg.image = img
                        //self.actorImg.alpha = 0
                        
//                        UIView.animate(withDuration: 0.3, animations: {
//                            self.actorImg.alpha = 1.0
//                        })
                        }
                    })
                    
                }
                
            }
            
            
        })
        
        task.resume()
    }
    
    
    



    

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return actors.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath ) 

        // Configure the cell...
        actorImg = cell.viewWithTag(1)  as? UIImageView
        namelabel = cell.viewWithTag(2) as? UILabel
       namelabel.text = actors[indexPath.row].name
        
         let url="https://image.tmdb.org/t/p/w500/"
        let imageUrl=url + actors[indexPath.row].profile_path
        
        getImage(imageUrl,indexPath)
        
        if(indexPath.row==actors.count-1){
            if( actorPage<500){
                actorPage = actorPage+1
                let pageString = "\(actorPage)"
                let pageUrlString = "https://api.themoviedb.org/3/person/popular?api_key=be6e82ab66a065f245b84e4b4692aee8&page=" + pageString
                
                print(pageUrlString)
                downloadJson(urlJsonString: pageUrlString)
            }
            
        }
        

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let myVC = storyboard?.instantiateViewController(withIdentifier: "dvc") as! MovieDetailsViewController
        myVC.stringPassed = actors[indexPath.row].name
        myVC.theImagePassed =  actors[indexPath.row].profile_path
        myVC.idPassed = actors[indexPath.row].id
        navigationController?.pushViewController(myVC, animated: true)
        
    }
    
  
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
