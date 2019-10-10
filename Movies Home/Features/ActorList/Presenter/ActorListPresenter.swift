//
//  ActorListPresenter.swift
//  Movies Home
//
//  Created by Mai Abd Elmonem on 9/16/19.
//  Copyright © 2019 Mai Ahmed. All rights reserved.
//

import Foundation

class ActorListPresenter {
    
    var PageNumber=1
//    var actors : [Actor]=[]
    var actorview:ActorViewProtocol?
    var actormodel:ActorModelProtocol?
    
    init(actorview: ActorViewProtocol, actormodel: ActorModelProtocol){
        self.actorview=actorview
        self.actormodel=actormodel
    }
    
    func getarrCount()-> Int {
        return actormodel!.getArrCount()
        
    }
    func getActors(index:Int) -> Actor {
        return actormodel!.getActors(index: index)
    }

//    func getName(index: Int) -> String {
//        return actormodel!.getName(index:index)
//
//    }
    func refresh() {
        PageNumber=1
        actormodel!.refresh()
    }
    func getResults() -> Int {
       return actormodel!.getResults()
    }
    func incrementPage(){
        PageNumber += 1
    }
    func resetPage(){
        PageNumber = 1
    }
    

    
    func getJson(){
        actormodel?.downloadJson(pageNum: 1){ [weak self] success in
            if(success){
                self?.actorview?.reloadTableData()
            }
        }
    }
    
}
