//
//  APIParam.swift
//  mBrochure
//
//  Created by Mukesh Sharma 3 on 11/28/15.
//  Copyright © 2015 Mukesh Sharma 3. All rights reserved.
//

import Foundation

class APIParam
{
    static let APIParamInstance = APIParam();
    
    let BROCHURE_NUMBER:String = "<BROCHURE_NUMBER>";
    
    func getMarketListAPIParam() -> String
    {
        return "{ \"getMarketsList\": { \"version\": \"1\", \"devKey\": \"c1bf8b0a25e6fe7b6bdbc1b3b5461936\"}}";
    }
    
    func getBrochureListAPIParam() -> String
    {
        return "{\"getBrochureList\": {\"campaigns\": [{\"campaignYear\": 15,\"campaignNum\": 12}],\"langCd\": \"\(AppData.AppDataInstance.currentLanguageCode)\",\"mrktCd\": \"\(AppData.AppDataInstance.currentMarketCode)\",\"version\": \"2.0\",\"devKey\": \"c1bf8b0a25e6fe7b6bdbc1b3b5461936\",\"device\": \"n\"}}";
    }
    
    func getBrochureDataAPIParam() -> String
    {
        return "{\"getBrochureData\": {\"brochureNum\": \"<BROCHURE_NUMBER>\",\"version\": \"2.0\",\"langCd\": \"\(AppData.AppDataInstance.currentLanguageCode)\",\"campaignNum\": 12,\"mrktCd\": \"\(AppData.AppDataInstance.currentMarketCode)\",\"campaignYear\": 15,\"devKey\": \"c1bf8b0a25e6fe7b6bdbc1b3b5461936\"}}";
    }
}


