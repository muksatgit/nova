//
//  SpreadCell.swift
//  mBrochure
//
//  Created by Mukesh Sharma 3 on 12/4/15.
//  Copyright © 2015 Mukesh Sharma 3. All rights reserved.
//

import UIKit

class SpreadCell: UICollectionViewCell
{
    
    
    var parentView:SpreadViewController!
    @IBOutlet weak var spreadImage: UIImageView!
    
    var currentSpread:Spread!
        {
            didSet
            {
                updateData();
            }
        }
    
    private func updateData()
    {
        spreadImage.image = currentSpread.spreadImage;
    }

}
