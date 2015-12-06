//
//  ViewController.swift
//  mBrochure
//
//  Created by Mukesh Sharma 3 on 11/19/15.
//  Copyright (c) 2015 Mukesh Sharma 3. All rights reserved.
//

import UIKit



class SelectMarketViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    
    @IBOutlet weak var marketList: UITableView?
    
    var countryObject:Country = Country()
    
    internal func updateNotificationSentLabel() -> Void
    {
        dispatch_async(dispatch_get_main_queue(), {self.marketList?.reloadData()});
    
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateNotificationSentLabel", name: "marketListLoaded", object:nil )
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        self.countryObject = SelectMarketModal.selectMarketInstance.marketListData[indexPath.row];
        
        AppData.AppDataInstance.currentMarket = countryObject.countryDisplayName;
        
        
        let selectLanguageViewController:SelectLanguageViewController = (self.storyboard!.instantiateViewControllerWithIdentifier("SelectLanguageView") as? SelectLanguageViewController)!
        selectLanguageViewController.countryObject = self.countryObject;
        print(self.countryObject.countryDisplayName);
        self.navigationController?.pushViewController(selectLanguageViewController, animated: true)
       
    }
    
    override func viewWillDisappear(animated: Bool)
    {
        super.viewWillDisappear(animated)
    }
    
    


    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
         return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
       // print(SelectMarketModal.selectMarketInstance.marketListData.count)
        
        return SelectMarketModal.selectMarketInstance.marketListData.count;
    }
    

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        //let cell = UITableViewCell()//tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        let countryObject:Country = SelectMarketModal.selectMarketInstance.marketListData[indexPath.row];
        let countryName:String = countryObject.countryDisplayName as String!;
        
        cell.textLabel!.text = countryName;
        return cell
    }
}

