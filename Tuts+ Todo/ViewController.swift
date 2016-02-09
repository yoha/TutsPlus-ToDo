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
    
    var items = [String]() {
        didSet {
            let hasTodo = items.count > 0
            self.tableView.hidden = !hasTodo
            self.messageLabel.hidden = hasTodo
        }
    }
    var checkedItems: [String] = []
    
    let tableViewCellIdentifier = "TableViewCellIdentifier"
    let addItemViewControllerSegue = "AddItemViewControllerSegue"
    
    lazy var userDefaults = NSUserDefaults.standardUserDefaults()

    // MARK: - IBOutlet Properties
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var messageLabel: UILabel!
    
    // MARK: - UITableViewDataSource Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(self.tableViewCellIdentifier, forIndexPath: indexPath)
        cell.textLabel?.text = self.items[indexPath.row]
        cell.accessoryType = self.checkedItems.contains(self.items[indexPath.row]) ? UITableViewCellAccessoryType.Checkmark : .None
        return cell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            if let validIndexForItemInCheckedItems = self.checkedItems.indexOf(self.items[indexPath.row]) {
                self.checkedItems.removeAtIndex(validIndexForItemInCheckedItems)
            }
            self.items.removeAtIndex(indexPath.row)
            self.saveItems()
            self.saveCheckedItems()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Right)
        }
    }
    
    // MARK: - UITableViewDelegateMethods
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        guard let validTableViewCellAtIndexPath = tableView.cellForRowAtIndexPath(indexPath) else { return }
        if let validIndexForItemInCheckedItems = self.checkedItems.indexOf(self.items[indexPath.row]) {
            self.checkedItems.removeAtIndex(validIndexForItemInCheckedItems)
            validTableViewCellAtIndexPath.accessoryType = UITableViewCellAccessoryType.None
        }
        else {
            self.checkedItems.append(self.items[indexPath.row])
            validTableViewCellAtIndexPath.accessoryType = .Checkmark
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.saveCheckedItems()
    }
    
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
        self.loadItems()
        self.loadCheckedItems()
    }
    
    // MARK: - AddItemViewControllerDelegate Methods
    
    func controller(controller: AddItemViewController, didAddItem withItem: String) {
        self.items.append(withItem)
        self.saveItems()
        self.tableView.reloadData()
        
        // TODO: Attemtping to reload specific row instead of the entire table view
        /***
        let lastIndexPath = NSIndexPath(forRow: self.items.count, inSection: 0)
        self.tableView.beginUpdates()
        self.tableView.reloadRowsAtIndexPaths([lastIndexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        self.items.append(withItem)
        self.tableView.endUpdates()
        ***/
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    // MARK: - Helper Methods
    
    private func loadItems() {
        if let validItems = self.userDefaults.objectForKey("items") as? [String] {
            self.items = validItems
        }
    }
    
    private func loadCheckedItems() {
        if let validCheckedItems = self.userDefaults.objectForKey("checkedItems") as? [String] {
            self.checkedItems = validCheckedItems
        }
    }
    
    private func saveItems() {
        self.userDefaults.setObject(self.items, forKey: "items")
        self.userDefaults.synchronize()
    }
    
    private func saveCheckedItems() {
        self.userDefaults.setObject(self.checkedItems, forKey: "checkedItems")
        self.userDefaults.synchronize()
    }
}

