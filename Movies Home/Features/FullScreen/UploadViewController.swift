//
//  UploadViewController.swift
//  Movies Home
//
//  Created by Mai Abd Elmonem on 10/16/19.
//  Copyright © 2019 Mai Ahmed. All rights reserved.
//

import UIKit
import OAuthSwift
import SWXMLHash

class UploadViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var imagePicker = UIImagePickerController()
    
    @IBOutlet weak var showimage: UIImageView!
    
    var auth = OAuth1Swift()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePickerController.delegate = self
        // Do any additional setup after loading the view.
    }
    

    @IBAction func PickImage(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            print("Button capture")
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        }
    }
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        self.dismiss(animated: true, completion: { () -> Void in
            
        })
        
        showimage.image = image
    }
    
    @IBAction func UploadImage(_ sender: UIButton) {
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
