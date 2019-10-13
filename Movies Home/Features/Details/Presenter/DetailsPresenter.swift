//
//  DetailsPresenter.swift
//  Movies Home
//
//  Created by mai ahmed on 9/26/19.
//  Copyright © 2019 Mai Ahmed. All rights reserved.
//

import Foundation

class DetailPresenter{
    
//     var person : MovieDetailsViewController?
//    var ActorObj : Actor?
//    var id = ""
    var profileView : ProfileViewProtocol?
    var profileModel : DetailsModelProtocol?
   
    init(profileView: ProfileViewProtocol, profileModel: DetailsModelProtocol){
        self.profileView = profileView
        self.profileModel = profileModel
    }
//    init(person:MovieDetailsViewController) {
//        self.person = person
//        self.person?.personId = actorId
//    }
    
    func getprofiles(){
        profileModel?.getActorProfilesJson(){ [weak self] success in
            if(success){
                DispatchQueue.main.async {
               self?.profileView?.reloadCollectionData()
                }
            }
        }
 }
    
    func getprofileArrCount() -> Int {
        return profileModel!.getprofileArrCount()
    }
    
    func getactorprofileImage(index: Int) -> String { 
        return profileModel!.getactorprofileImage(index: index)
    }
    
    func getActorName() -> String {
        return profileModel!.getActorName()
    }
    
    func getActorProfilepath() -> String {
        return profileModel!.getActorProfilepath()
    }
}
