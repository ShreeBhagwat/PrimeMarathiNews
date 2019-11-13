//
//  LatestCollectionViewCell.swift
//  PrimeMarathiNews
//
//  Created by Shree Bhagwat on 11/11/19.
//  Copyright © 2019 Shree Bhagwat. All rights reserved.
//

import UIKit

class LatestCollectionViewCell: UICollectionViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLatestNewsCell()
    }
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10.0
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = #imageLiteral(resourceName: "vegata")
        return imageView
    }()
    
    var baseView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10.0
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor.white
        view.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        view.layer.borderWidth = 0.5
        view.layer.zPosition = 1
        return view
    }()
    
    var TitleView : UILabel = {
           let view = UILabel()
           view.text = "Trial Heading"
           view.font = UIFont.boldSystemFont(ofSize: 16)
           view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
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
        button.layer.zPosition = 1
           return button
       }()
    
    @objc func playButtonPressed(){
        print("Play Btn Pressed")
    }
    @objc func shareButtonPressed(){
        print("share btn pressen")
    }
    
    
    func setupLatestNewsCell(){
        self.addSubview(baseView)
        self.addSubview(imageView)
        self.addSubview(playButton)
        self.baseView.addSubview(eye)
//        self.imageView.addSubview(playButton)
        self.baseView.addSubview(shareButton)
        self.baseView.addSubview(viewsLabel)
        self.baseView.addSubview(calender)
        self.baseView.addSubview(dateLabel)
        self.baseView.addSubview(TitleView)
        self.baseView.addSubview(detailNew)

        
        
        imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        imageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 2).isActive = true
        imageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -2).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        
        baseView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        baseView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        baseView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        baseView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        TitleView.topAnchor.constraint(equalTo: baseView.topAnchor, constant: 5).isActive = true
        TitleView.leftAnchor.constraint(equalTo: baseView.leftAnchor, constant: 5).isActive = true
        TitleView.rightAnchor.constraint(equalTo: baseView.rightAnchor, constant: -5).isActive = true
        
        calender.leftAnchor.constraint(equalTo: TitleView.leftAnchor).isActive = true
        calender.topAnchor.constraint(equalTo: TitleView.bottomAnchor, constant: 5).isActive = true
        calender.widthAnchor.constraint(equalToConstant: 20).isActive = true
        calender.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        dateLabel.leftAnchor.constraint(equalTo: calender.rightAnchor, constant: 2).isActive = true
        dateLabel.centerYAnchor.constraint(equalTo: calender.centerYAnchor).isActive = true
        
        eye.leftAnchor.constraint(equalTo: dateLabel.rightAnchor, constant: 5).isActive = true
        eye.topAnchor.constraint(equalTo: TitleView.bottomAnchor, constant: 5).isActive = true
        eye.widthAnchor.constraint(equalToConstant: 20).isActive = true
        eye.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        viewsLabel.leftAnchor.constraint(equalTo: eye.rightAnchor, constant: 2).isActive = true
        viewsLabel.centerYAnchor.constraint(equalTo: eye.centerYAnchor).isActive = true
        
        shareButton.leftAnchor.constraint(equalTo: viewsLabel.rightAnchor, constant: 5).isActive = true
        shareButton.topAnchor.constraint(equalTo: TitleView.bottomAnchor, constant: 5).isActive = true
        shareButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        shareButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        detailNew.topAnchor.constraint(equalTo: eye.bottomAnchor, constant: 5).isActive = true
        detailNew.leftAnchor.constraint(equalTo: TitleView.leftAnchor).isActive = true
        detailNew.rightAnchor.constraint(equalTo: TitleView.rightAnchor).isActive = true
        detailNew.widthAnchor.constraint(equalToConstant: 150).isActive = true
//        detailNew.rightAnchor.constraint(equalTo: baseView.rightAnchor, constant: -5).isActive = true

//        detailNew.bottomAnchor.constraint(equalTo: baseView.bottomAnchor).isActive = true
        
        playButton.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
        playButton.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        playButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        playButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
//        playButton.centerXAnchor.constraint(equalTo: baseView.centerXAnchor).isActive = true
//        playButton.bottomAnchor.constraint(equalTo: baseView.topAnchor, constant: 10).isActive = true
//        playButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
//        playButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        
    }
    
}
