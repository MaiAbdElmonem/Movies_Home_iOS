//
//  ModelProtocol.swift
//  Movies Home
//
//  Created by Mai Abd Elmonem on 9/16/19.
//  Copyright © 2019 Mai Ahmed. All rights reserved.
//

import Foundation

protocol ActorModelProtocol: class {
    func downloadJson(pageNum:Int,completion:@escaping (_ success:Bool)->Void)
    func getArrCount() -> Int
    func getName(index:Int)->String
    
    
    
    func getactorImage(index:Int) -> String 
    func refresh()
    func getResults() -> Int
    
}
