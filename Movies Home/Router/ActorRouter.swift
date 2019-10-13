//
//  ActorRouter.swift
//  Movies Home
//
//  Created by mai ahmed on 10/12/19.
//  Copyright © 2019 Mai Ahmed. All rights reserved.
//

import Foundation
import UIKit

class ActorRouter {
    class func navigateToActorDetails(at parent: UINavigationController, with model: Actor) {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let detailsViewController = storyBoard.instantiateViewController(withIdentifier: "dvc") as! MovieDetailsViewController
        detailsViewController.detailsPresenter = DetailPresenter(profileView: detailsViewController, profileModel: DetailsModel(personObj: model))
        parent.pushViewController(detailsViewController, animated: true)
    }
   
}
