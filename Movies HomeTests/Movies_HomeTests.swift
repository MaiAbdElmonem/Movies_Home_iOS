//
//  Movies_HomeTests.swift
//  Movies HomeTests
//
//  Created by Lost Star on 9/2/19.
//  Copyright © 2019 Mai Ahmed. All rights reserved.
//

import XCTest
@testable import Movies_Home

class Movies_HomeTests: XCTestCase {
//    var sut = ActorListPresenter(actorview: ActorViewProtocol, actormodel: ActorModelProtocol)
    var actorPresenter: ActorListPresenter?
    var testActorView : ActorViewProtocol?
    var testActorModel : ActorModelProtocol?
    
    

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        //real=mocking
        
        testActorView = MockingView()
        testActorModel = MockingModel()
        actorPresenter = ActorListPresenter(actorview: MockingView?, actormodel: MockingModel)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testactorListEmpty()  {
        XCTAssertEqual(actorPresenter?.getarrCount(), 0)
    }
    
    func testDataLoaded() {
        //given
        // i want data
        //when
        actorPresenter?.getJson()
        //then
        XCTAssertEqual(actorPresenter?.getarrCount(), 20)
    }
    
    func testPulltoRefersh() {
        //remove
        actorPresenter?.refresh()
        XCTAssertEqual(actorPresenter?.getarrCount(), 0)
        // get data
        actorPresenter?.getJson()
        XCTAssertEqual(actorPresenter?.getarrCount(), 20)
    }
    
    func testLoadmore() {
        // given
        actorPresenter?.refresh()
        actorPresenter?.getJson()
        actorPresenter?.incrementPage()
        
        // when
        actorPresenter?.getJson()
        //then
        //load more actors
        
    }
    

   
    
    class MockingView: ActorViewProtocol {
        func reloadTableData() {
        }
        
    }
    
    class MockingModel: ActorModelProtocol {
        
        var totalResults = 0
        var actors : [Actor]=[]
        
        func downloadJson(pageNum: Int, completion: @escaping (Bool) -> Void) {
            if let jsonBundle = Bundle.main.path(forResource: "data", ofType: "json") {
                do{
                    let jsondata = try? String(contentsOfFile: jsonBundle, encoding: .utf8)
                     //                 serialise the data / NSData object into Dictionary [String : Any]
                    if let jsonDict = (try? JSONSerialization.jsonObject(with: jsondata!.data(using: .utf8)! , options: JSONSerialization.ReadingOptions.mutableContainers)) as? [String: Any] {
                        
                    
//                do{
                
                    let actorsresultsArrary = jsonDict["results"]
                        as? [Dictionary <String,Any>] ?? []
                    
                    for i in actorsresultsArrary{
                        let actorObj = Actor()
                        let actorname = i["name"] as? String ?? ""
                        let actorpath = i["profile_path"] as? String ?? ""
                        let actorId = i["id"] as! Int
                        
                        
                        actorObj.name = actorname
                        actorObj.profile_path = actorpath
                        actorObj.id = actorId
                        
                        self.actors.append(actorObj)
                    }
                    completion(true)
                }
            }
            
            }
        }
        
        func getArrCount() -> Int {
            return actors.count
        }
        
        func getName(index: Int) -> String {
            return actors[index].name
            
        }
        func getId(index: Int) -> Int {
            return actors[index].id
        }
        
        func getactorImage(index: Int) -> String {
            if (index <  actors.count){
                
            }
            return actors[index].profile_path
        }
        func refresh() {
            actors.removeAll()
        }
        
        func getResults() -> Int {
            return totalResults
        }
   }
    

}
