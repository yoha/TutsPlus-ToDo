//
//  Task.swift
//  Tuts+ Todo
//
//  Created by Yohannes Wijaya on 2/9/16.
//  Copyright © 2016 Yohannes Wijaya. All rights reserved.
//

import Foundation

class Task: NSObject, NSCoding {
    
    // MARK: - Stored Properties
    
    var name: String
    
    // MARK: - Initializers
    
    convenience override init() {
        self.init(name: "Task Name")
    }
    
    init(name: String) {
        self.name = name
    }
    
    // MARK: - NSCoding Protocols Methods
    
    @objc required init?(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObjectForKey("name") as! String
    }
    
    @objc func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.name, forKey: "name")
    }
}