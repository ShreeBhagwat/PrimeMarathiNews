//
//  Top10NewsCollectionViewCell.swift
//  PrimeMarathiNews
//
//  Created by Shree Bhagwat on 11/11/19.
//  Copyright © 2019 Shree Bhagwat. All rights reserved.
//

import UIKit

class Top10NewsCollectionViewCell: UICollectionViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUpCellLayout()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

//
    }
    
    var imageView: UIImageView = {
        var imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.layer.cornerRadius = 10
        imageview.layer.masksToBounds = true
        imageview.alpha = 1
        imageview.contentMode = .scaleAspectFill
//        imageview.layer.zPosition = 1
        imageview.image = #imageLiteral(resourceName: "vegata")
        return imageview
    }()
    
        var baseView:UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10.0
        view.backgroundColor = UIColor.white
//        view.layer.zPosition = 100
        let ShadowPath2 = UIBezierPath(rect: view.bounds)
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOffset = CGSize(width: CGFloat(1.0), height: CGFloat(3.0))
        view.layer.shadowOpacity = 0.5
        view.layer.shadowPath = ShadowPath2.cgPath
        view.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        view.layer.borderWidth = 0.5
        return view
        
    }()
    
//    var shadowView: UIView = {
//        var view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.clipsToBounds = false
////        let shadowSize: CGFloat = 5.0
////        let shadowPath = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
////        y: -shadowSize / 2, width: view.frame.size.width + shadowSize, height: view.frame.size.height + shadowSize))
////
////        view.layer.masksToBounds = false
////        view.layer.shadowColor = UIColor.black.cgColor
////        view.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
////        view.layer.shadowOpacity = 0.5
////        view.layer.shadowPath = shadowPath.cgPath
//        view.backgroundColor = UIColor.black
//        view.layer.shadowColor = UIColor.gray.cgColor
//        view.layer.shadowOffset = CGSize(width: CGFloat(1.0), height: CGFloat(3.0))
//        view.layer.shadowOpacity = 0.5
//        return view
//    }()
    
    var TitleView : UILabel = {
        let view = UILabel()
        view.text = "Trial Heading"
        view.font = UIFont.boldSystemFont(ofSize: 16)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = UIColor.black
        return view
    }()
    
    var detailNew : UITextView = {
        let textView = UITextView()
        textView.textColor = UIColor.gray
        textView.isEditable = false
        textView.isSelectable = false
        textView.backgroundColor = UIColor.clear
        textView.text = "This is trial text view filed get text automaticallt from database"
        textView.font = UIFont.systemFont(ofSize: 11)
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    var dateLabel : UILabel = {
        let label = UILabel()
        label.text = "13/09/94"
        label.textColor = UIColor.gray
        label.font = UIFont.italicSystemFont(ofSize: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var viewsLabel : UILabel = {
        let label = UILabel()
        label.text = "1234"
        label.textColor = UIColor.gray
        label.font = UIFont.italicSystemFont(ofSize: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
   lazy var shareButton : UIButton = {
        var button = UIButton()
        button.setImage(UIImage(named: "ic_share"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = UIColor.red
        button.setTitle("Share", for: .normal)
        button.addTarget(self, action: #selector(shareButtonPressed), for: .touchUpInside)
        return button
    }()
    var calender: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = #imageLiteral(resourceName: "ic_cale")
        return image
    }()
    
    var eye : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = #imageLiteral(resourceName: "ic_view")
        return image
    }()
    
   lazy var playButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "play"), for: .normal)
        button.addTarget(self, action: #selector(playButtonPressed), for: .touchUpInside)
        return button
    }()
    
    
    
    func setUpCellLayout(){
        self.addSubview(baseView)
//        self.baseView.addSubview(imageView)
        self.addSubview(imageView)
        self.baseView.addSubview(TitleView)
        self.baseView.addSubview(shareButton)
        self.baseView.addSubview(viewsLabel)
        self.baseView.addSubview(dateLabel)
        self.baseView.addSubview(detailNew)
        self.baseView.addSubview(calender)
        self.baseView.addSubview(eye)
        self.addSubview(playButton)

        
    
        baseView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -2).isActive = true
        baseView.topAnchor.constraint(equalTo: self.topAnchor, constant: 25).isActive = true
        baseView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 28).isActive = true
        baseView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        
        imageView.leftAnchor.constraint(equalTo: self.baseView.leftAnchor, constant: -20).isActive = true
        imageView.topAnchor.constraint(equalTo: self.baseView.topAnchor, constant: -20).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        playButton.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
        playButton.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        playButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        playButton.widthAnchor.constraint(equalToConstant: 50).isActive = true

        
        
        TitleView.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 8).isActive = true
        TitleView.rightAnchor.constraint(equalTo: baseView.rightAnchor, constant: -8).isActive = true
        TitleView.topAnchor.constraint(equalTo: baseView.topAnchor, constant: 20).isActive = true
        
        calender.leftAnchor.constraint(equalTo: TitleView.leftAnchor).isActive = true
        calender.topAnchor.constraint(equalTo: TitleView.bottomAnchor, constant: 5).isActive = true
        calender.heightAnchor.constraint(equalToConstant: 20).isActive = true
        calender.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        dateLabel.leftAnchor.constraint(equalTo: calender.rightAnchor, constant: 2).isActive = true
        dateLabel.topAnchor.constraint(equalTo: TitleView.bottomAnchor, constant: 5).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        eye.leftAnchor.constraint(equalTo: dateLabel.rightAnchor, constant: 5).isActive = true
        eye.topAnchor.constraint(equalTo: calender.topAnchor).isActive = true
        eye.heightAnchor.constraint(equalToConstant: 20).isActive = true
        eye.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        viewsLabel.leftAnchor.constraint(equalTo: eye.rightAnchor, constant: 5).isActive = true
        viewsLabel.topAnchor.constraint(equalTo: dateLabel.topAnchor).isActive = true
        viewsLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        shareButton.leftAnchor.constraint(equalTo: viewsLabel.rightAnchor, constant: 5).isActive = true
        shareButton.topAnchor.constraint(equalTo: viewsLabel.topAnchor, constant: 2).isActive = true
        shareButton.heightAnchor.constraint(equalToConstant: 15).isActive = true
        shareButton.widthAnchor.constraint(equalToConstant: 15).isActive = true
        
        detailNew.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 1).isActive = true
        detailNew.leftAnchor.constraint(equalTo: TitleView.leftAnchor).isActive = true
        detailNew.rightAnchor.constraint(equalTo: TitleView.rightAnchor).isActive = true
        detailNew.bottomAnchor.constraint(equalTo: baseView.bottomAnchor).isActive = true
        
    }
    
    @objc func playButtonPressed(){
        print("Play Button Pressed")
    }
    
    @objc func shareButtonPressed(){
        print("Share BUtton Pressed")
    }
    
}
