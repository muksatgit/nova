//
//  LanguageList.swift
//  mBrochure
//
//  Created by Mukesh Sharma 3 on 11/24/15.
//  Copyright © 2015 Mukesh Sharma 3. All rights reserved.
//

import Foundation

class Language
{
    var languageDisplayName:String?
    var languageCode:String?
    var marketCode:String?
    
    init(){
        languageDisplayName = "";
        languageCode = "";
        marketCode = "";
    }
    
    
    internal func addLanguage(lanDisplayName:String, lanCode:String, mktCode:String)->Void
    {
        self.languageDisplayName = lanDisplayName;
        self.languageCode = lanCode;
        self.marketCode = mktCode;
    }
    
}