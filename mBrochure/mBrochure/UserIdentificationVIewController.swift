//
//  UserIdentificationVIewController.swift
//  mBrochure
//
//  Created by Mukesh Sharma 3 on 11/27/15.
//  Copyright © 2015 Mukesh Sharma 3. All rights reserved.
//

import Foundation
import UIKit

class UseridentificationVIewController: UIViewController
{
    @IBAction func needRepClick(sender: AnyObject) {
    }
    
    @IBAction func haveRepClick(sender: AnyObject) {
    }
    
    @IBAction func startBrowsingClick(sender: AnyObject)
    {
        
        let browseHomeViewController:BrowseHomeViewController = (self.storyboard!.instantiateViewControllerWithIdentifier("BrowseHomeViewController") as? BrowseHomeViewController)!
        
        self.navigationController?.pushViewController(browseHomeViewController, animated: true)
        
    }
    
    @IBAction func repLoginClick(sender: AnyObject) {
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
}
