//
//  BrowseHomeViewController.swift
//  mBrochure
//
//  Created by Mukesh Sharma 3 on 11/28/15.
//  Copyright © 2015 Mukesh Sharma 3. All rights reserved.
//

import Foundation
import UIKit

class BrowseHomeViewController: UIViewController, UICollectionViewDelegate, UIActionSheetDelegate
{
    
    @IBOutlet weak var brochureCollectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var brochureCollectionVIew: UICollectionView!
    @IBOutlet weak var loadingLabel: UILabel!
    
    var actionSheet = UIActionSheet?()
    var imagesLoaded:Int?
    var brochureListModal:BrochureListModal?
    var selectedBrochure:Brochure!
    var coverImageArray = [UIImage]();
    
    
    
    
    
    func viewbrochure()
    {
        
        let brochureViewController:BrochureViewController = (self.storyboard!.instantiateViewControllerWithIdentifier("BrochureViewController") as? BrochureViewController)!
        brochureViewController.spreadArray = self.selectedBrochure.spreadArray;
        
        self.navigationController?.pushViewController(brochureViewController, animated: true)
        
    }
    
    // - ITEM SELECT
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        
        self.selectedBrochure = (self.brochureListModal?.brochureDataArray[indexPath.row])! as Brochure;
        
        if (self.selectedBrochure.isDownloadComplete != nil)
        {
            if(self.selectedBrochure.isDownloadComplete == true)
            {
                viewbrochure();
                return;
            }
        }
        
        var labelSmallDownload:String = Double(self.selectedBrochure.downloadSizeSmall/1024).toString();
        labelSmallDownload = "Small ("+labelSmallDownload+")"
        
        var labelMediumDownload:String = Double(self.selectedBrochure.downloadSizeMedium/1024).toString();
        labelMediumDownload = "Medium ("+labelMediumDownload+")"
        
        var labelLargeDownload:String = Double(self.selectedBrochure.downloadSizeLarge/1024).toString();
        labelLargeDownload = "Large ("+labelLargeDownload+")"
        
        self.actionSheet = UIActionSheet(title: "Download", delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil, otherButtonTitles: labelSmallDownload,labelMediumDownload,labelLargeDownload)
        self.actionSheet!.showInView(self.view)
    }
    
    // - HANDLE ACTION SHEET SELECTION
    
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int)
    {
        switch (buttonIndex){
        case 0:
            print("Cancel")
        case 1:
            self.selectedBrochure.downloadSpreads(AppConst.AppConstInstance.SMALL);
        case 2:
            self.selectedBrochure.downloadSpreads(AppConst.AppConstInstance.MEDIUM);
        case 3:
            self.selectedBrochure.downloadSpreads(AppConst.AppConstInstance.LARGE);
        default:
            print("Default")
        }
    }
    
    internal func onBrochureDownloadValueChanged() -> Void
    {
        dispatch_async(dispatch_get_main_queue(),
            {
                //self.downloadProgress.setProgress(self.selectedBrochure.brochureLoadedValue(), animated: true);
        });
    }
    
    
    // - BROCHURE LIST LOADED
    internal func onBrochureListLoaded() -> Void
    {
        dispatch_async(dispatch_get_main_queue(),
            {
            self.brochureListModal = BrochureListModal.brochureListModalInstance;
            self.imagesLoaded = 0;
            self.loadCoverImages();
        });
    }
    // - BROCHURE IMAGES LOADED
    internal func onBrochureImagesLoaded() -> Void
    {
        dispatch_async(dispatch_get_main_queue(),
            {
                print(self.selectedBrochure.brochureNum, "finished downloading....")
                self.brochureCollectionVIew.reloadData();
                
               // print(self.selectedBrochure.isDownloadComplete);
                
                
//                self.brochureListModal?.brochureDataArray
                //self.btnVIewBrochure.alpha = 1;
            });
    }
    // - DOWNLOAD IMAGE
    
    func downloadImage(brochureObject: Brochure)
    {
        let imageURL = NSURL(string: brochureObject.coverImageURL!);
        print("Started downloading \"\(imageURL!.URLByDeletingPathExtension!.lastPathComponent!)\".")
        getDataFromUrl(imageURL!) { (data, response, error)  in
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                guard let data = data where error == nil else { return }
                print("Finished downloading \"\(imageURL!.URLByDeletingPathExtension!.lastPathComponent!)\".")
                brochureObject.coverImage = UIImage(data: data)
                self.imagesLoaded = self.imagesLoaded!+1
                if self.imagesLoaded == self.brochureListModal?.brochureDataArray.count
                {
                    self.brochureCollectionVIew.reloadData();
                    self.activityIndicator.stopAnimating();
                    self.brochureCollectionVIew.alpha = 1;
                }
                //self.brochureImage.image = UIImage(data: data)
            }
        }
    }
    // - DOWNLOAD IMAGE HELPER FUNCTION
    func getDataFromUrl(url:NSURL, completion: ((data: NSData?, response: NSURLResponse?, error: NSError? ) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            completion(data: data, response: response, error: error)
            }.resume()
    }
    
    // - LOAD COVER IMAGES
    func loadCoverImages()->Void
    {
        if brochureListModal?.brochureDataArray.count > 0
        {
            for brochure in (brochureListModal?.brochureDataArray)!
            {
                if let brochureObject:Brochure =  brochure as Brochure
                {
                    downloadImage(brochureObject);
                }
            }
        }
    }
    
    // SIMPLE CONST
    private struct Storyboard
    {
        static let Cellidentifier = "Brochure Cell"
    }
    
    // - THIS SHOULD GO TO COMMON UTILITIES
    func updateLoadingText(value:String) -> Void
    {
        if value == ""
        {
           self.loadingLabel.alpha = 0
        }
        else
        {
            self.loadingLabel.alpha = 1;
            self.loadingLabel.text = value;
        }
    }
    // - VIEW DID LOAD
    override func viewDidLoad()
    {
        super.viewDidLoad();
        updateLoadingText("Loading Brochures...")
        brochureCollectionVIew.alpha = 0;
        //self.btnVIewBrochure.alpha = 0;
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onBrochureListLoaded", name: "brochureListLoaded", object:nil )
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onBrochureDownloadValueChanged", name: "BDVC", object:nil )
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onBrochureImagesLoaded", name: "brochureImagesLoaded", object:nil)
        BrochureListModal.brochureListModalInstance.loadData();
        
        // TO BE USED LATER
        
        self.navigationItem.hidesBackButton = true;
        //self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Menu", style: UIBarButtonItemStyle.Done, target: self, action: nil)
        //self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Menu"), style: UIBarButtonItemStyle.Done, target: self, action: nil)
    }
    
    
    // - COLLECTION VIEW DATA SOURCE
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
    {
        return 1
    }
    // - COLLECTION VIEW DATA SOURCE
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        
        var numItems:Int = 0;
        if self.brochureListModal?.brochureDataArray.count > 0
        {
            numItems = (self.brochureListModal?.brochureDataArray.count)!
        }
        return numItems;
    }
    // - COLLECTION VIEW DATA SOURCE
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(Storyboard.Cellidentifier, forIndexPath: indexPath) as? BrochureCollectionViewCell
        
        let brochure:Brochure = (self.brochureListModal?.brochureDataArray[indexPath.item])! as Brochure;
        cell?.brochureImage?.image = brochure.coverImage;
        cell?.brochureLabel?.text = brochure.brochureName;
        cell?.viewBrochure?.hidden = brochure.isDownloadPending();
        cell?.parentView = self;
        return cell!;
        
    }
}

    // - COLLECTION VIEW DATA SOURCE
    extension Double
    {
        func toString() -> String
        {
        return String(format: "%.2f",self)
        }
    }
