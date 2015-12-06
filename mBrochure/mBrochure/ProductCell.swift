//
//  ProductCell.swift
//  mBrochure
//
//  Created by Mukesh Sharma 3 on 12/4/15.
//  Copyright © 2015 Mukesh Sharma 3. All rights reserved.
//

import Foundation
import UIKit

class ProductCell: UITableViewCell
{
    
    var product:Product!
        {
        didSet
            {
                updateData();
            }
        }
    
    @IBOutlet weak var itemNumberLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBAction func btnAddToCart(sender: AnyObject)
    {
        
    }
    
    func updateData()->Void
    {
        itemNumberLabel.text = product.productId
        descriptionLabel.text = product.name;
        priceLabel.text = product.price;
    }
    
    
}
