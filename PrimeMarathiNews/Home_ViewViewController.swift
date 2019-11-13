//
//  Home_ViewViewController.swift
//  PrimeMarathiNews
//
//  Created by Shree Bhagwat on 11/11/19.
//  Copyright © 2019 Shree Bhagwat. All rights reserved.
//

import UIKit
import SDLoader
import SDWebImage
import AFNetworking
import AVFoundation
import GoogleMobileAds





class Home_ViewViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, VKSideMenuDelegate, LCBannerViewDelegate, GADBannerViewDelegate, GADInterstitialDelegate, UISearchBarDelegate, UICollectionViewDelegateFlowLayout{
 
    

    
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView3: UICollectionView!
    
    @IBOutlet weak var latestnewsButton: UIButton!
    @IBOutlet weak var latestnewLable: UILabel!
    @IBOutlet weak var collectionView2: UICollectionView!
    @IBOutlet weak var top10newsButton: UIButton!
    @IBOutlet weak var top10newLable: UILabel!
    @IBOutlet weak var collectionView1: UICollectionView!
    @IBOutlet weak var categoryViewAllButton: UIButton!
    @IBOutlet weak var categoriesLable: UILabel!
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var BannerView: LCBannerView!
    @IBOutlet weak var pageController: UIPageControl!
    @IBOutlet weak var myScrollView: UIScrollView!
    
    let categoryCollectionCellIdentifier = "cat_cell"
    let top10CollectionCellIdentifier = "top_cell"
    let latestCollectionViewCellIdentifier = "latest_cell"
    let infiniteTableViewCellIdentifier = "infinite_cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Registering all the cells


        self.myScrollView.delaysContentTouches = true
        self.myScrollView.canCancelContentTouches = true
        
        self.tableViewHeightConstraint.constant = self.view.frame.height
        self.tableView.isScrollEnabled = false
        self.myScrollView.bounces = false
        self.tableView.bounces = true
        
        
       
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.myScrollView.delegate = self
        self.myScrollView.addSubview(myView)
//        myScrollView.contentSize = myView.frame.size
        self.myScrollView.contentSize = CGSize(width: 375, height: 1500)
        self.myScrollView.superview?.isUserInteractionEnabled = true
        self.myScrollView.delaysContentTouches = true
        self.myScrollView.canCancelContentTouches = true
               
    }
    

  //MARK: Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
     
    }
    
  
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
//        let cell = tableView.dequeueReusableCell(withIdentifier: "infinite_cell", for: indexPath) as? InfiniteHomeTableViewCell
////        cell?.lable.text  = "\(indexPath.row)"
//
//        return cell!
        
        if indexPath.row == 2 || indexPath.row == 5 || indexPath.row == 7{
            let cell = tableView.dequeueReusableCell(withIdentifier: "infinite_cell", for: indexPath) as? InfiniteHomeTableViewCell
            cell?.frame.size.height = 120
            return cell!
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "infinite_video_cell", for: indexPath) as? InfiVideoTableViewCell
            cell?.backgroundColor = UIColor.red
            cell?.frame.size.height = 400
            return cell!
        }
     
}
    
    // MARK: Collection View
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionView1 {
            return 10
        } else if collectionView == collectionView2 {
            return 4
        }else {
            return 30
        }
      }
    
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionView1 {
            let categoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryCollectionCellIdentifier, for: indexPath) as? CategoryCollectionViewCell
//            categoryCell?.backgroundColor = UIColor.blue
            return categoryCell!
        }else if collectionView == collectionView2 {
            let topNews = collectionView.dequeueReusableCell(withReuseIdentifier: top10CollectionCellIdentifier, for: indexPath) as? Top10NewsCollectionViewCell
//            topNews?.backgroundColor = UIColor.green
            return topNews!
        }else {
            let latestCell = collectionView.dequeueReusableCell(withReuseIdentifier: "latest_cell", for: indexPath) as! LatestCollectionViewCell
//            latestCell.backgroundColor = UIColor.yellow
            return latestCell
            
        }
      }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionView1 {
            let cat_cell_height = 90.0
            let cat_cell_width = 150.0
            return CGSize(width: cat_cell_width, height: cat_cell_height)
        }else if collectionView == collectionView2 {
            let top_cell_height = 150.0
            let top_cell_width = 300.0
            return CGSize(width: top_cell_width, height: top_cell_height)
        }else {
            let latest_cell_height = 200.0
            let latest_cell_width = 200.0
            return CGSize(width: latest_cell_width, height: latest_cell_height)
        }
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "infinite_cell", for: indexPath) as? InfiniteHomeTableViewCell
//        let cell2 = tableView.dequeueReusableCell(withIdentifier: "infinite_video_cell", for: indexPath) as? InfiVideoTableViewCell
//        if
//    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == myScrollView {
            tableView.isScrollEnabled = (self.myScrollView.contentOffset.y >= 200)
        }
        if scrollView == tableView {
            tableView.isScrollEnabled = (tableView.contentOffset.y > 0)
        }
    }

}

