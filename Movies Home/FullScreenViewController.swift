//
//  FullScreenViewController.swift
//  Movies Home
//
//  Created by Mai Abd Elmonem on 9/5/19.
//  Copyright © 2019 Mai Ahmed. All rights reserved.
//

import UIKit

class FullScreenViewController: UIViewController {

    var fullimgPassed = ""
    
    @IBOutlet weak var fullImage: UIImageView!
    
   
    @IBAction func saveImage(_ sender: UIButton) {
        
        let imageData = fullImage.image!.pngData()
        let compresedImage = UIImage(data: imageData!)
        UIImageWriteToSavedPhotosAlbum(compresedImage!, nil, nil, nil)
        
        let alert = UIAlertController(title: "Saved", message: "Your image has been saved", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url="https://image.tmdb.org/t/p/w500/"
        var ImageUrl:String = ""
        ImageUrl = url + fullimgPassed
        
        get_image(ImageUrl, fullImage)
        
    }
    
    
    func get_image(_ url_str:String, _ imageView:UIImageView)
    {
        
        let url:URL = URL(string: url_str)!
        let session = URLSession.shared
        
        let task = session.dataTask(with: url, completionHandler: {
            (
            data, response, error) in
            
            
            if data != nil
            {
                let image = UIImage(data: data!)
                
                
                if(image != nil)
                {
                    
                    DispatchQueue.main.async(execute: {
                        
                        imageView.image = image
                        
                        
                        
                        
                    })
                    
                }
                
            }
            
            
        })
        
        task.resume()
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