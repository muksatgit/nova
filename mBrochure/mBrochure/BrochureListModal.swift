//
//  BrochureListModal.swift
//  mBrochure
//
//  Created by Mukesh Sharma 3 on 11/28/15.
//  Copyright © 2015 Mukesh Sharma 3. All rights reserved.
//

import Foundation

class BrochureListModal
{
    static let brochureListModalInstance = BrochureListModal();
    
    
    var numBrochures:Int!
    //var brochureListData = [Brochure]();
    var brochureDataArray = [Brochure]();
    
    
    
    func brochureLoaded(object:Brochure)->Void
    {
        if(self.brochureDataArray.count > self.numBrochures)
        {
            
            print("somehting is wrong here");
        }
        else
        {
            self.brochureDataArray.append(object);
            if(self.brochureDataArray.count == self.numBrochures)
            {
                // all brochure data loaded
                NSNotificationCenter.defaultCenter().postNotificationName("brochureListLoaded", object: nil)
            }
        }
        
        
        
    }
    
    func loadData() -> Void
    {
        
        let url = NSURL(string: APIConst.APIConstInstance.GET_BROCHURE_LIST)!
        let session = NSURLSession.sharedSession();
        let postParams = APIParam.APIParamInstance.getBrochureListAPIParam();
        let request = NSMutableURLRequest(URL: url)
        
        request.HTTPMethod = "POST"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        request.HTTPBody = postParams.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        
        session.dataTaskWithRequest(request, completionHandler: { ( data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            // Make sure we get an OK response
            guard let realResponse = response as? NSHTTPURLResponse where
                realResponse.statusCode == 200 else {
                    print("Not a 200 response")
                    return
            }
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                let brochureListResponse = json["getBrochureListResp"]
                
                
                guard let brochureArray = brochureListResponse!!["brochureList"] as? NSArray else {
                    return
                }
                
                self.numBrochures = brochureArray.count;
                print("Number of Brochures : ", self.numBrochures)
                
                if self.brochureDataArray.count > 0
                {
                    self.brochureDataArray.removeAll();
                }
                
                for brochure in brochureArray
                {
                    let brochureObject = Brochure();
                    
                    guard let brochureNum:Int = brochure["brochureNum"] as? Int else
                    {
                        return
                    }
                    
                    brochureObject.brochureNum = brochureNum;
                    
                    let brochureDataModal:BrochureData = BrochureData();
                    brochureDataModal.loadBrochureData(brochureObject);
                }
                
            } catch {
                print("error serializing JSON: \(error)")
            }
        }).resume()
    }
    
}
