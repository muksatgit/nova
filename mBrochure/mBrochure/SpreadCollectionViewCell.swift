//
//  SpreadCollectionViewCell.swift
//  mBrochure
//
//  Created by Mukesh Sharma 3 on 12/2/15.
//  Copyright © 2015 Mukesh Sharma 3. All rights reserved.
//

import UIKit

class SpreadCollectionViewCell: UICollectionViewCell
{
    
    @IBOutlet weak var spreadImage: UIImageView!
    
   
    var spreadObject:Spread!
        {
        didSet
        {
            updateData();
        }
    }
    
    
    
    private func updateData()
    {
        spreadImage?.image = spreadObject.spreadImage;
    }
}