//
//  ProductViewController.swift
//  mBrochure
//
//  Created by Mukesh Sharma 3 on 12/4/15.
//  Copyright © 2015 Mukesh Sharma 3. All rights reserved.
//

import Foundation
import UIKit

class ProductViewController: UIViewController
{
    var productArray = [Product]();
    
    @IBOutlet weak var productTableView: UITableView!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return productArray.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell:ProductCell = tableView.dequeueReusableCellWithIdentifier("productCell", forIndexPath: indexPath) as! ProductCell
        let productObject:Product = productArray[indexPath.row] as Product;
        
        cell.product = productObject;
        return cell
    }
    
}
