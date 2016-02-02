//
//  ViewController.swift
//  Tuts+ Todo
//
//  Created by Yohannes Wijaya on 2/2/16.
//  Copyright © 2016 Yohannes Wijaya. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Stored Properties
    
    var items = [String]()
    
    let tableViewCellIdentifier = "TableViewCellIdentifier"

    // MARK: - IBOutlet Properties
    
    @IBOutlet var tableView: UITableView!
    
    // MARK: - UITableViewDataSource Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(self.tableViewCellIdentifier, forIndexPath: indexPath)
        cell.textLabel?.text = self.items[indexPath.row]
        return cell
    }
    
    // MARK: - UITableViewDelegateMethods
    
    // MARK: - UIViewController Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: self.tableViewCellIdentifier)
        
        self.items = ["Create Personal Project w/ Swift", "Teach people to program in Swift", "Share experience in Swift"]
        
        self.title = "ToDo"
    }

}

