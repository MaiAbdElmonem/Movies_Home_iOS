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
    
    var auth = OAuth1Swift(consumerKey: "7d20c70a0b40cdb86a50d9b0eb0d45ad",
                           consumerSecret: "6ae7acf930bb532f",
                           requestTokenUrl: "https://www.flickr.com/services/oauth/request_token",
                           authorizeUrl: "https://www.flickr.com/services/oauth/authorize",
                           accessTokenUrl: "https://www.flickr.com/services/oauth/access_token")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
    }
    
    @IBAction func PickImage(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = true
            
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        let image = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
       showimage.image = image
        dismiss(animated: true, completion: nil)
    }
//    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
//        self.dismiss(animated: true, completion: { () -> Void in
//
//        })
//
//        showimage.image = image
//    }
    
    @IBAction func UploadImage(_ sender: UIButton) {
        let handle = auth.authorize(
        withCallbackURL: URL(string: "oauth-swift://oauth-callback/flickr")!) { result in
            switch result {
            case .success(let (credential, response, parameters)):
                print(credential.oauthToken)
                print(credential.oauthTokenSecret)
                
                
//                auth.client
            // Do your request
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
