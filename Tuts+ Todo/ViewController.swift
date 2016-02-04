//
//  ViewController.swift
//  Tuts+ Todo
//
//  Created by Yohannes Wijaya on 2/2/16.
//  Copyright © 2016 Yohannes Wijaya. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AddItemViewControllerDelegate {
    
    // MARK: - Stored Properties
    
    var items = [String]()
    
    let tableViewCellIdentifier = "TableViewCellIdentifier"
    let addItemViewControllerSegue = "AddItemViewControllerSegue"

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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == self.addItemViewControllerSegue {
            guard let validNavigationController = segue.destinationViewController as? UINavigationController else { return }
            guard let validAddItemViewController = validNavigationController.topViewController as? AddItemViewController else { return }
            validAddItemViewController.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: self.tableViewCellIdentifier)
        
        self.items = ["Create Personal Project w/ Swift", "Teach people to program in Swift", "Share experience in Swift"]
        
        self.title = "ToDo"
    }
    
    // MARK: - AddItemViewControllerDelegate Methods
    
    func controller(controller: AddItemViewController, didAddItem withItem: String) {
        self.items.append(withItem)
        
        self.tableView.reloadData()
//        let lastIndexPath = NSIndexPath(forRow: self.items.count, inSection: 0)
//        self.tableView.beginUpdates()
//        self.tableView.reloadRowsAtIndexPaths([lastIndexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
//        self.items.append(withItem)
//        self.tableView.endUpdates()
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}

