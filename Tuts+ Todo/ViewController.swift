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
    
    var items = [Todo]() {
        didSet {
            let hasTodo = items.count > 0
            self.tableView.hidden = !hasTodo
            self.messageLabel.hidden = hasTodo
        }
    }
    
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
        let todoAtIndex = self.items[indexPath.row]
        cell.textLabel?.text = todoAtIndex.name
        cell.accessoryType = todoAtIndex.isTodoDone ? UITableViewCellAccessoryType.Checkmark : .None
        return cell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            self.items.removeAtIndex(indexPath.row)
            self.saveItems()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Right)
        }
    }
    
    // MARK: - UITableViewDelegateMethods
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        guard let validTableViewCellAtIndexPath = tableView.cellForRowAtIndexPath(indexPath) else { return }
        let todoItemAtIndex = self.items[indexPath.row]
        todoItemAtIndex.isTodoDone = !todoItemAtIndex.isTodoDone
        validTableViewCellAtIndexPath.accessoryType = todoItemAtIndex.isTodoDone ? UITableViewCellAccessoryType.Checkmark : .None
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.saveItems()
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
        self.items.append(Todo(name: "Create Personal Project w/ Swift", isTodoDone: false))
        self.items.append(Todo(name: "Tech People to program in Swift", isTodoDone: false))
        self.items.append(Todo(name: "Share experience in Swift", isTodoDone: false))
        self.title = "ToDo"
        self.loadItems()
    }
    
    // MARK: - AddItemViewControllerDelegate Methods
    
    func controller(controller: AddItemViewController, didAddItem withItem: Todo) {
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
    
    private func getPathToDocumentDirectory() -> String? {
        guard let validDocumentDirectory = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).first else { return nil }
        return validDocumentDirectory.stringByAppendingString("items")
    }
    
    private func loadItems() {
        guard let validDocumentDirectory = self.getPathToDocumentDirectory() else { return }
        guard let todoItems = NSKeyedUnarchiver.unarchiveObjectWithFile(validDocumentDirectory) as? [Todo] else { return }
        self.items = todoItems
    }
    
    
    private func saveItems() {
        guard let validDocumentDirectory = self.getPathToDocumentDirectory() else { return }
        NSKeyedArchiver.archiveRootObject(self.items, toFile: validDocumentDirectory) ? print("saved successfully") : print("Failed to save")
    }
}

