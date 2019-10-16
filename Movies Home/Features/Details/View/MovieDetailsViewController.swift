//
//  MovieDetailsViewController.swift
//  Movies Home
//
//  Created by Lost Star on 9/3/19.
//  Copyright © 2019 Mai Ahmed. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController , UICollectionViewDataSource, UICollectionViewDelegate , ProfileViewProtocol{
   
    var detailsPresenter : DetailPresenter?
    let profileurl = URL(string: "https://image.tmdb.org/t/p/w500/")
    let placeholderProfileImage = UIImage(named: "apple")

    @IBOutlet var collectionview: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionview.dataSource=self
        self.collectionview.delegate=self
        
        detailsPresenter?.getprofiles()
    }
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return detailsPresenter!.getprofileArrCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionview.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomCollectionCell
        
        
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.5
        cell.layer.cornerRadius = 3
        
        let ProfileImageUrl = profileurl!.appendingPathComponent((detailsPresenter?.getactorprofileImage(index: indexPath.row))!)
            cell.collectionImage.sd_setImage(with: ProfileImageUrl, placeholderImage: placeholderProfileImage)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionview.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderVIew", for: indexPath) as! HeaderViewCollection
        header.headerLabel.text=detailsPresenter?.getActorName()
        let ProfileImage = profileurl!.appendingPathComponent(detailsPresenter!.getActorProfilepath())
        header.headerImage.sd_setImage(with: ProfileImage, placeholderImage: placeholderProfileImage)
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let fullscreen = storyboard?.instantiateViewController(withIdentifier: "full") as! FullScreenViewController
        fullscreen.fullimgPassed = (detailsPresenter?.getactorprofileImage(index: indexPath.row))!
            navigationController?.pushViewController(fullscreen, animated: true)
    }
    
    func reloadCollectionData() {
            self.collectionview.reloadData()
    }
}
