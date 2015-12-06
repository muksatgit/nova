//
//  BrochureCollectionViewCell.swift
//  mBrochure
//
//  Created by Mukesh Sharma 3 on 11/30/15.
//  Copyright © 2015 Mukesh Sharma 3. All rights reserved.
//

import UIKit


class BrochureCollectionViewCell: UICollectionViewCell
{
    
    
    var brochureObject:Brochure!
        {
        didSet
            {
                updateData();
            }
        }
    
    var parentView:BrowseHomeViewController!
    
    @IBOutlet weak var brochureImage:UIImageView?
    @IBOutlet weak var brochureLabel:UILabel?
    @IBOutlet weak var viewBrochure:UIButton?
    
    @IBAction func btnViewBrochure(sender: AnyObject)
    {
        if(parentView != nil)
        {
            parentView.viewbrochure();
        }
    }
    
    private func updateData()
    {
        print(brochureObject.isDownloadPending());
        brochureImage?.image = brochureObject.coverImage;
        brochureLabel?.text = brochureObject.brochureName;
        viewBrochure?.hidden = brochureObject.isDownloadPending();
    }
}
