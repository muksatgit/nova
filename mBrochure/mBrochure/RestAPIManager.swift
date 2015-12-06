//
//  RestAPIManager.swift
//  mBrochure
//
//  Created by Mukesh Sharma 3 on 11/23/15.
//  Copyright © 2015 Mukesh Sharma 3. All rights reserved.
//

import Foundation

class RestAPIManager
{
    var _url:String = "";
    
    func loadData(url: String, param:String, resultHandler:(String) -> Void) -> Void
    {
        self._url = url;
        resultHandler("Hello from Class with URL")
        
    }
    
}
