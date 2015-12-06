//
//  SelectMarketModal.swift
//  mBrochure
//
//  Created by Mukesh Sharma 3 on 11/24/15.
//  Copyright © 2015 Mukesh Sharma 3. All rights reserved.
//

import Foundation

class SelectMarketModal
{
    
    static let selectMarketInstance = SelectMarketModal()
    
    var marketListData = [Country]();
    
    
    init()
    {
        marketListData = [Country]();
    }
    
    
    func loadMarketData()
    {
        let postEndpoint: String = "http://uatmobileapi.avon.com/api/getMarketsList"
        let url = NSURL(string: postEndpoint)!
        let session = NSURLSession.sharedSession()
        let postParams = "{ \"getMarketsList\": { \"version\": \"1\", \"devKey\": \"c1bf8b0a25e6fe7b6bdbc1b3b5461936\"}}"
        let request = NSMutableURLRequest(URL: url)
        
        request.HTTPMethod = "POST"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = postParams.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        
        // Make the POST call and handle it in a completion handler
        session.dataTaskWithRequest(request, completionHandler: { ( data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            // Make sure we get an OK response
            guard let realResponse = response as? NSHTTPURLResponse where
                realResponse.statusCode == 200 else {
                    print("Not a 200 response")
                    return
            }
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                let marketsList = json["getMarketsListResp"]
                
                guard let regionArray = marketsList!!["regions"] as? NSArray else {
                    return
                }
                
                var marketList = MarketList();
                
                for region in regionArray
                {
                    
                    guard let countryArray = region["countries"] as? NSArray else
                    {
                        return
                    }
                    var countryObject = Country();
                    for country in countryArray
                    {
                        
                        //PARSING THE COUNTRY ARRAY
                        
                        guard let countryDisplayName = country["displayName"] as? NSString else
                        {
                            return
                        }
                        
                        
                        
                        guard let languageArray = country["languages"] as? NSArray else
                        {
                            return
                        }
                        
                        
                        
                        //PARSING THE LANGUAGE ARRAY
                       
                        var lanArray = [Language]();
                        
                        for language in languageArray
                        {
                            guard let languageDisplayName = language["langDisplayName"] as? NSString else
                            {
                                return
                            }
                            guard let langCd = language["langCd"] as? NSString else
                            {
                                return
                            }
                            guard let mrktCd = language["mrktCd"] as? NSString else
                            {
                                return
                            }
                            var languageObject = Language();
                            languageObject.languageDisplayName = languageDisplayName as String;
                            languageObject.languageCode = langCd as String;
                            languageObject.marketCode = mrktCd as String;
                            lanArray.append(languageObject);
                        }
                        countryObject = Country();
                        countryObject.addCountry(countryDisplayName as String, lanArray: lanArray as! [Language]);
                        self.marketListData.append(countryObject as Country)
                    }
                    
                }
                
                NSNotificationCenter.defaultCenter().postNotificationName("marketListLoaded", object: nil)    
                
                
                
            } catch {
                print("error serializing JSON: \(error)")
            }
        }).resume()
        
    }
}
