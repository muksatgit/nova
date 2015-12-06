//
//  SelectLanguageVIewController.swift
//  mBrochure
//
//  Created by Mukesh Sharma 3 on 11/27/15.
//  Copyright © 2015 Mukesh Sharma 3. All rights reserved.
//

import Foundation
import UIKit
class SelectLanguageViewController: UIViewController, UITableViewDataSource
{
    
    @IBOutlet weak var SelectLanguageTableView: UITableView!
    
    var countryObject:Country?
    var language:Language?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Select Language"
        print("countryObject?.languageList.count:",countryObject?.languageList.count);
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        language = (countryObject?.languageList[indexPath.row])! as Language;
        
        AppData.AppDataInstance.currentLanguage = language?.languageDisplayName;
        AppData.AppDataInstance.currentLanguageCode = language?.languageCode;
        AppData.AppDataInstance.currentMarketCode = language?.marketCode;
        
        
        let userIdentificationView:UseridentificationVIewController = (self.storyboard!.instantiateViewControllerWithIdentifier("UserIdentificationView") as? UseridentificationVIewController)!
        //userIdentificationView.countryObject = self.countryObject;
        self.navigationController?.pushViewController(userIdentificationView, animated: true)
        
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return (countryObject?.languageList.count)!;
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        //let cell = UITableViewCell()//tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let cell = tableView.dequeueReusableCellWithIdentifier("languageCell", forIndexPath: indexPath) as UITableViewCell
        let languageObject:Language = ((countryObject?.languageList[indexPath.row])! as Language);
        let languageDisplayName:String = languageObject.languageDisplayName as String!;
        
        cell.textLabel!.text = languageDisplayName;
        return cell
    }

}
