//
//  DetailsPresenter.swift
//  Movies Home
//
//  Created by mai ahmed on 9/26/19.
//  Copyright © 2019 Mai Ahmed. All rights reserved.
//

import Foundation

class DetailPresenter{
    
     var actorId = Int()
     var person : MovieDetailsViewController?
    var profileView : ProfileViewProtocol?
    var profileModel : DetailsModelProtocol?
     init(person:MovieDetailsViewController) {
     self.person!.personId = actorId
    }
    init(profileView: ProfileViewProtocol, profileModel: DetailsModelProtocol){
        self.profileView = profileView
        self.profileModel = profileModel
    }
    
    func getprofiles(){
        profileModel?.getActorProfilesJson(actorId:actorId){ [weak self] success in
            if(success){
               self?.profileView?.reloadCollectionData()
            }
        }
    
 }
    
    func getprofileArrCount() -> Int {
        return profileModel!.getprofileArrCount()
    }
    
    func getactorprofileImage(index: Int) -> String { 
        return profileModel!.getactorprofileImage(index: index)
    }
}
