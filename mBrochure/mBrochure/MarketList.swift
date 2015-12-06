//
//  MarketList.swift
//  mBrochure
//
//  Created by Mukesh Sharma 3 on 11/23/15.
//  Copyright © 2015 Mukesh Sharma 3. All rights reserved.
//

import Foundation

class MarketList
{
    var marketList = [Country]();
    
    
    init(){
        marketList = [Country]();
    }
    
    
    internal func addMarket(market:Country)->Void
    {
        self.marketList.append(market);
    }

    internal func printValue() -> Void
    {
    
        //printValue(marketList.count);
        for market in marketList
        {
            guard let mkt = market as? Country else
            {
                return
            }
            
            print(mkt.countryDisplayName);
            print(mkt.languageList.count)
            print("\n")
        }
    }
    
    
}
