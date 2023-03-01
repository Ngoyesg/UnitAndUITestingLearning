//
//  SPyNavigationController.swift
//  CopyOfPhotoApp
//
//  Created by Natalia Goyes on 24/02/23.
//

import UIKit

class SPyNavigationController: UINavigationController {
    
    var pushedViewController: UIViewController!
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool){
        super.pushViewController(viewController, animated: animated)
        
        pushedViewController = viewController
    }
}
