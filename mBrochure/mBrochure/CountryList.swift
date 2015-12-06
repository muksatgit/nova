//
//  Language.swift
//  mBrochure
//
//  Created by Mukesh Sharma 3 on 11/24/15.
//  Copyright © 2015 Mukesh Sharma 3. All rights reserved.
//

import Foundation

class Country
{
    var countryDisplayName:String?
    var languageList = [Language]();
    
    init(){
        countryDisplayName = "";
        languageList = [Language]();
    }
    
    
    internal func addCountry(ctName:String, lanArray:NSArray) -> Void
    {
        self.countryDisplayName = ctName;
        self.languageList = lanArray as! [Language];
    }
}
