//
//  BrochureSpread.swift
//  mBrochure
//
//  Created by Mukesh Sharma 3 on 11/30/15.
//  Copyright © 2015 Mukesh Sharma 3. All rights reserved.
//

import Foundation
import UIKit

class BrochureData
{
    var brochureDataArray:NSArray?
    
    internal func loadBrochureData(brochureObject:Brochure) -> Void
    {
        let url = NSURL(string: APIConst.APIConstInstance.GET_BROCHURE_DATA)!
        let session = NSURLSession.sharedSession();
        var postParams = APIParam.APIParamInstance.getBrochureDataAPIParam();
        let request = NSMutableURLRequest(URL: url)
        
        request.HTTPMethod = "POST"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        postParams = postParams.stringByReplacingOccurrencesOfString(APIParam.APIParamInstance.BROCHURE_NUMBER, withString: String(brochureObject.brochureNum));
        
        
        
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
                
                let getBrochureDataResp:NSDictionary = json.valueForKeyPath("getBrochureDataResp") as! NSDictionary;
                let brochureData:NSDictionary = getBrochureDataResp.valueForKeyPath("brochureData") as! NSDictionary;
                
                brochureObject.id = brochureData.valueForKeyPath("id") as! Int;
                

                brochureObject.campaignNum = brochureData.valueForKeyPath("campaignNum") as! Int;
                brochureObject.campaignYear = brochureData.valueForKeyPath("campaignYear") as! Int;
                brochureObject.brochureNum = brochureData.valueForKeyPath("brochureNum") as! Int;
                
                brochureObject.brochureName = brochureData.valueForKeyPath("brochureName") as! String;
                brochureObject.brochureMarketingText = brochureData.valueForKeyPath("brochureMarketingText") as! String;
                brochureObject.brochureThumbnail = brochureData.valueForKeyPath("brochureThumbnail") as! String;

                brochureObject.langCode = brochureData.valueForKeyPath("langCode") as! String;
                brochureObject.countryCode = brochureData.valueForKeyPath("countryCode") as! String;
                brochureObject.marketId = brochureData.valueForKeyPath("marketId") as! Int;
                brochureObject.isMarketDefaultBrochure = brochureData.valueForKeyPath("isMarketDefaultBrochure") as! Int;
                brochureObject.isActive = brochureData.valueForKeyPath("isActive") as! Int;
                brochureObject.isRepOnly = brochureData.valueForKeyPath("isRepOnly") as! Int;
                
                
                let downloadSize:NSDictionary = brochureData.valueForKeyPath("downloadSize") as! NSDictionary;
                
                
                brochureObject.downloadSizeSmall = downloadSize.valueForKeyPath("small") as! Double;
                brochureObject.downloadSizeMedium = downloadSize.valueForKeyPath("medium") as! Double;
                brochureObject.downloadSizeLarge = downloadSize.valueForKeyPath("large") as! Double;
                
                let coverPage:NSDictionary = brochureData.valueForKeyPath("coverPage") as! NSDictionary;
                brochureObject.coverImageURL = (coverPage.valueForKeyPath("medium")) as! String;
                
                let backPage:NSDictionary = brochureData.valueForKeyPath("backPage") as! NSDictionary;
                brochureObject.backPageURL = (backPage.valueForKeyPath("medium")) as! String;
                
                
                guard let spreadArray = brochureData["spreads"] as? NSArray else {
                    return
                }
                
                for spread in spreadArray
                {
                    var spreadObject:Spread = Spread();
                    spreadObject.id = spread.valueForKeyPath("id") as! Int;
                    spreadObject.isMiniBrochureSpread = spread.valueForKeyPath("isMiniBrochureSpread") as! Int;
                    spreadObject.spreadNumber = spread.valueForKeyPath("spreadNumber") as! Int;
                    
                    
                    let images:NSDictionary = spread.valueForKeyPath("images") as! NSDictionary;
                   
                    let smallImage:NSDictionary = images.valueForKeyPath("small") as! NSDictionary;
                    spreadObject.smallImageURL = smallImage.valueForKeyPath("url") as! String;
                    
                    let mediumImage:NSDictionary = images.valueForKeyPath("medium") as! NSDictionary;
                    spreadObject.mediumImageURL = mediumImage.valueForKeyPath("url") as! String;
                    
                    let largeImage:NSDictionary = images.valueForKeyPath("large") as! NSDictionary;
                    spreadObject.largeImageURL = largeImage.valueForKeyPath("url") as! String;

                    
                    
                    guard let productsArray:NSArray = spread["products"] as? NSArray else {
                        return
                    }
                    
                    
                    for product in productsArray
                    {
                        let productObject:Product = Product();
                        let productObjectRaw:NSDictionary = (product as? NSDictionary)!;
                        
                        productObject.id = productObjectRaw.valueForKeyPath("id") as? Int;
                        productObject.spreadNumber = productObjectRaw.valueForKeyPath("spreadNumber") as! Int;
                        productObject.pageNumber = productObjectRaw.valueForKeyPath("pageNumber") as! Int;
                        productObject.name = productObjectRaw.valueForKeyPath("name") as! String ;
                        productObject.searchProductName = productObjectRaw.valueForKeyPath("searchProductName") as! String;
                        productObject.productId = productObjectRaw.valueForKeyPath("productId") as! String;
                        productObject.price = productObjectRaw.valueForKeyPath("price") as! String;
                        
                        spreadObject.productsArray.append(productObject);
                    }
                    
                    guard let multimediaArray:NSArray = spread["multimedia"] as? NSArray else {
                        return
                    }
                    
                    for multimedia in multimediaArray
                    {
                        var multimediaObject:Multimedia = Multimedia();
                        var multimediaObjectRaw:NSDictionary = (multimedia as? NSDictionary)!;
                        
                        multimediaObject.mediaId = multimediaObjectRaw.valueForKeyPath("mediaId") as! Int;
                        multimediaObject.spreadNumber = multimediaObjectRaw.valueForKeyPath("spreadNumber") as! Int;
                        multimediaObject.pageNumber = multimediaObjectRaw.valueForKeyPath("pageNumber") as! Int;
                        multimediaObject.mediaType = multimediaObjectRaw.valueForKeyPath("mediaType") as! String;
                        multimediaObject.mediaUrl = multimediaObjectRaw.valueForKeyPath("mediaUrl") as! String;
                        multimediaObject.campaignNum = multimediaObjectRaw.valueForKeyPath("campaignNum") as! Int;
                        multimediaObject.campaignYear = multimediaObjectRaw.valueForKeyPath("campaignYear") as! Int;
                        multimediaObject.brochureNum = multimediaObjectRaw.valueForKeyPath("brochureNum") as! Int;

                        spreadObject.multimediaArray.append(multimediaObject);
                    }
                    
                    spreadObject.type = spread.valueForKeyPath("type") as! String;
                    brochureObject.spreadArray.append(spreadObject);
                }
                BrochureListModal.brochureListModalInstance.brochureLoaded(brochureObject);
                print("All Data Loaded and parsed for Brochure : ",brochureObject.brochureNum);
                
            } catch {
                print("error serializing JSON: \(error)")
            }
        }).resume()
    
    }
    

}
