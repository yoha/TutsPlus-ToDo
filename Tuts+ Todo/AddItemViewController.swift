//
//  AddItemViewController.swift
//  Tuts+ Todo
//
//  Created by Yohannes Wijaya on 2/4/16.
//  Copyright © 2016 Yohannes Wijaya. All rights reserved.
//

import UIKit

protocol AddItemViewControllerDelegate {
    func controller(controller: AddItemViewController, didAddItem withItem: String)
}

class AddItemViewController: UIViewController {
    
    // MARK: - Stored Properties
    
    var delegate: AddItemViewControllerDelegate?

    // MARK: - IBOutlet Properties
    
    @IBOutlet weak var textField: UITextField!
    
    // MARK: - IBAction Methods
    
    @IBAction func cancelButtonDidTouch(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func createButtonDidTouch(sender: UIButton) {
        guard let validDelegate = self.delegate, let validText = self.textField.text else { return }
        validDelegate.controller(self, didAddItem: validText)
    }
    
    // MARK: - UIViewController Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textField.becomeFirstResponder()
    }
}
