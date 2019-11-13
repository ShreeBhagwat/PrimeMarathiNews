////
////  HomeViewController.swift
////  PrimeMarathiNews
////
////  Created by Shree Bhagwat on 10/11/19.
////  Copyright © 2019 Shree Bhagwat. All rights reserved.
////
//
//import UIKit
//
//class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
//    
//    @IBOutlet var tableView: UITableView!
//    
//    
//    
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        navigationController?.navigationBar.prefersLargeTitles = true
//        navigationItem.title = "Home"
//        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: "home_cell")
//        
//        // Do any additional setup after loading the view.
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        12
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "home_cell") as! HomeTableViewCell
//        cell.backgroundColor = UIColor.red
//        return cell
//    }
//    
//}
