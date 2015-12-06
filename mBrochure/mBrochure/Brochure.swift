//
//  BrochureModal.swift
//  mBrochure
//
//  Created by Mukesh Sharma 3 on 11/28/15.
//  Copyright © 2015 Mukesh Sharma 3. All rights reserved.
//

import Foundation
import UIKit
class Brochure
{
    var id:Int!
    var brochureNum:Int!
    var campaignNum:Int!
    var campaignYear:Int!
    var brochureName:String!
    var brochureMarketingText:String!
    var brochureThumbnail:String!
    var coverPage:String!
    var backPageURL:String!
    var coverImageURL:String!
    var backPage:UIImage!
    var coverImage:UIImage!
    var isMarketDefaultBrochure:Int!
    var downloadSizeSmall:Double!
    var downloadSizeMedium:Double!
    var downloadSizeLarge:Double!
    
    var isDownloadComplete:Bool!
    
    var downloadProgress:Int!
    
    var spreadArray = [Spread]();
    
    var langCode:String!
    var countryCode:String!
    var marketId:Int!
    var isActive:Int!
    var isRepOnly:Int!
    
    //=============
    var currentSpreadIndex = 0;
    
    
    func isDownloadPending()->Bool
    {
        var boolValue:Bool = true;
        
        if (isDownloadComplete != nil)
        {
            if(isDownloadComplete == true)
            {
                boolValue = false;
            }
            else
            {
                boolValue = true;
            }
        }
        else
        {
            boolValue = true;
        }
        
        return boolValue;
    }
    
    
    func downloadSpreads(imageQuality:String)->Void
    {
        if spreadArray.count > 0
        {
            for index in 0...(spreadArray.count-1)
            {
                var imageURL:String!
                if imageQuality == AppConst.AppConstInstance.SMALL {imageURL = spreadArray[index].smallImageURL as String;}
                if imageQuality == AppConst.AppConstInstance.MEDIUM {imageURL = spreadArray[index].mediumImageURL as String;}
                if imageQuality == AppConst.AppConstInstance.LARGE {imageURL = spreadArray[index].largeImageURL as String;}
                loadSpread(imageURL)
            }
        }
    }
    
    func getDataFromUrl(url:NSURL, completion: ((data: NSData?, response: NSURLResponse?, error: NSError? ) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            completion(data: data, response: response, error: error)
            }.resume()
    }
    
    func brochureLoadedValue() ->Float
    {
        let preComplete:Float = Float((self.currentSpreadIndex/self.spreadArray.count)/1000);
        print(preComplete);
        return preComplete;
    }
    
    
    func loadSpread(url:String)->Void
    {
        let imageURL = NSURL(string: url);
        
        print("Started downloading \"\(imageURL!.URLByDeletingPathExtension!.lastPathComponent!)\".")
        
        getDataFromUrl(imageURL!) { (data, response, error)  in
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                guard let data = data where error == nil else { return }
                print("Finished downloading \"\(imageURL!.URLByDeletingPathExtension!.lastPathComponent!)\".")
                self.spreadArray[self.currentSpreadIndex].spreadImage = UIImage(data: data)
                ++self.currentSpreadIndex;
                NSNotificationCenter.defaultCenter().postNotificationName("BDVC", object: nil)
                if self.currentSpreadIndex == (self.spreadArray.count-1)
                {
                    self.isDownloadComplete = true;
                    print(self.brochureNum, " is completed downloading");
                    NSNotificationCenter.defaultCenter().postNotificationName("brochureImagesLoaded", object: nil);
                }
                
                //coverImageArray.append(UIImage(data: data))
                
                /*brochureObject.coverImage = UIImage(data: data)
                self.imagesLoaded = self.imagesLoaded!+1
                if self.imagesLoaded == self.brochureListModal?.brochureDataArray.count
                {
                    self.brochureCollectionVIew.reloadData();
                    self.activityIndicator.stopAnimating();
                    self.brochureCollectionVIew.alpha = 1;
                    //self.updateLoadingText("");
                    
                }*/
                //self.brochureImage.image = UIImage(data: data)
            }
        }
    
    }
    

}
