
//
//  SpreadViewController.swift
//  mBrochure
//
//  Created by Mukesh Sharma 3 on 12/4/15.
//  Copyright © 2015 Mukesh Sharma 3. All rights reserved.
//

import Foundation
import UIKit
class SpreadViewController:  UIViewController
{
    
    
    @IBOutlet weak var spreadCollection: UICollectionView!
    var spreadArray = [Spread]();
    var selectedIndex:Int!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //spreadCollection.scrollToItemAtIndexPath(NSIndexPath, atScrollPosition: <#T##UICollectionViewScrollPosition#>, animated: <#T##Bool#>)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        
        var productsArray = [Product]();
        productsArray = (self.spreadArray[indexPath.row].productsArray) as NSArray as! [Product];
        
        let productViewController:ProductViewController = (self.storyboard!.instantiateViewControllerWithIdentifier("ProductViewController") as? ProductViewController)!
        productViewController.productArray = productsArray;
        
        self.navigationController?.pushViewController(productViewController, animated: true)
        
    }
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
    {
        return 1
    }
    // - COLLECTION VIEW DATA SOURCE
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        
        var numItems:Int = 0;
        if self.spreadArray.count > 0
        {
            numItems = (self.spreadArray.count)
        }
        return numItems;
    }
    // - COLLECTION VIEW DATA SOURCE
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("SpreadCell", forIndexPath: indexPath) as? SpreadCell
        
        let spreadObject:Spread = (self.spreadArray[indexPath.item]) as Spread;
        cell?.spreadImage?.image = spreadObject.spreadImage
        cell?.parentView = self;
        return cell!;
        
    }
}
