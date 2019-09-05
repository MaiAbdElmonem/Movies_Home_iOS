//
//  DetailssViewController.swift
//  Movies Home
//
//  Created by Lost Star on 9/3/19.
//  Copyright © 2019 Mai Ahmed. All rights reserved.
//

import UIKit

class DetailssViewController: UIViewController {
    
    
    var stringPassed = ""
    var ImagePassed = ""
    var idPassed = Int()
    var personId = Int()
    
    var personImage:UIImageView!
    var personNameLabel:UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        personId=idPassed
//parseJSON(personId: personId)
        
        personNameLabel.text=stringPassed
        personImage.viewWithTag(1)
        
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
