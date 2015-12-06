//
//  BrochureViewController.swift
//  mBrochure
//
//  Created by Mukesh Sharma 3 on 12/2/15.
//  Copyright © 2015 Mukesh Sharma 3. All rights reserved.
//

import Foundation
import UIKit

class BrochureViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate
{
    
    @IBOutlet weak var spreadCollection: UICollectionView!
    var spreadArray = [Spread]();
    
    var selectedSpread:Spread!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad();
        print(spreadArray.count);
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        
        self.selectedSpread = (self.spreadArray[indexPath.row]) as Spread;
        let spreadViewController:SpreadViewController = (self.storyboard!.instantiateViewControllerWithIdentifier("SpreadViewController") as? SpreadViewController)!
        spreadViewController.spreadArray = self.spreadArray;
        self.navigationController?.pushViewController(spreadViewController, animated: true)

    }

    
    
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    private struct Storyboard
    {
        static let Cellidentifier = "Spread Cell"
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return spreadArray.count;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = spreadCollection.dequeueReusableCellWithReuseIdentifier(Storyboard.Cellidentifier, forIndexPath: indexPath) as? SpreadCollectionViewCell
        cell!.backgroundColor = UIColor.blackColor()
        
        let spreadObject:Spread = (self.spreadArray[indexPath.item]) as Spread;
        cell!.spreadImage?.image = spreadObject.spreadImage
        return cell!;
        
    }
    
}