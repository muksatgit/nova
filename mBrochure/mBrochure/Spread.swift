//
//  Spread.swift
//  mBrochure
//
//  Created by Mukesh Sharma 3 on 11/30/15.
//  Copyright © 2015 Mukesh Sharma 3. All rights reserved.
//

import Foundation
import UIKit

class Spread
{
    var id:Int!
    var isMiniBrochureSpread:Int!
    var addToBag:Int!
    var mbBrochureMasterId:Int!
    var spreadNumber:Int!
    var type:String!
    var smallImageURL:String!
    var mediumImageURL:String!
    var largeImageURL:String!
    var updatedAt:NSDate!
    var socialTitle:String!
    var socialDescription:String!
    var shortSocialDescription:String!
    var multimediaArray = [Multimedia]();
    var productsArray = [Product]();
    var spreadImage:UIImage!
    
}