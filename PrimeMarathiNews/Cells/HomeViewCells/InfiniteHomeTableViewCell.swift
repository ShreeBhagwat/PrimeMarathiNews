//
//  InfiniteHomeTableViewCell.swift
//  PrimeMarathiNews
//
//  Created by Shree Bhagwat on 11/11/19.
//  Copyright © 2019 Shree Bhagwat. All rights reserved.
//

import UIKit

class InfiniteHomeTableViewCell: UITableViewCell {

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        setupTableViewCell()
    }
    
   var newsImageView: UIImageView = {
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
    
    func setupTableViewCell(){
        self.addSubview(newsImageView)
        self.addSubview(baseView)
        self.addSubview(playButton)
        
        baseView.addSubview(TitleView)
        baseView.addSubview(detailNew)
        baseView.addSubview(calender)
        baseView.addSubview(dateLabel)
        baseView.addSubview(eye)
        baseView.addSubview(viewsLabel)
        baseView.addSubview(shareButton)
        
        newsImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
        newsImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: -5).isActive = true
        newsImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        newsImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true

    }



}
