//
//  AddItemViewController.swift
//  Tuts+ Todo
//
//  Created by Yohannes Wijaya on 2/4/16.
//  Copyright © 2016 Yohannes Wijaya. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController {

    // MARK: - IBOutlet Properties
    
    @IBOutlet weak var textField: UITextField!
    
    // MARK: - IBAction Methods
    
    @IBAction func cancelButtonDidTouch(sender: UIBarButtonItem) {
        
    }
    
    @IBAction func createButtonDidTouch(sender: UIButton) {
        
    }
    
    // MARK: - UIViewController Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textField.becomeFirstResponder()
    }
}
