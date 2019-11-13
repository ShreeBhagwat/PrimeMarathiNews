//
//  CategoryCollectionViewCell.swift
//  PrimeMarathiNews
//
//  Created by Shree Bhagwat on 11/11/19.
//  Copyright © 2019 Shree Bhagwat. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
 
    override func awakeFromNib() {
        setupCategoryCell()
    }
    

    
    
    var imageView: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.image = #imageLiteral(resourceName: "vegata")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    var view: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor.black
        view.alpha = 0.7
        view.layer.zPosition = 1
        return view
    }()
    
    var label: UILabel = {
        var lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.text = "Category"
        lable.font = UIFont.boldSystemFont(ofSize: 16)
        lable.textColor = UIColor.white
        lable.layer.zPosition = 2
        return lable
    }()
    
    func setupCategoryCell(){
        self.addSubview(imageView)
        self.addSubview(view)
        self.addSubview(label)
        
        imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        view.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
    }
    
   
    
}
