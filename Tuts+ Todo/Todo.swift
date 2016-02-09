//
//  Todo.swift
//  Tuts+ Todo
//
//  Created by Yohannes Wijaya on 2/9/16.
//  Copyright © 2016 Yohannes Wijaya. All rights reserved.
//

import Foundation

class Todo: Task {
    
    // MARK: - Stored Properties
    
    var isTodoDone: Bool
    
    // MARK: - Initializer
    
    init(name: String, isTodoDone: Bool) {
        self.isTodoDone = isTodoDone
        super.init(name: name)
    }
    
    // MARK: - NSCoding Protocol Methods
    
    @objc required init?(coder aDecoder: NSCoder) {
        self.isTodoDone = aDecoder.decodeObjectForKey("isTodoDone") as! Bool
        super.init(coder: aDecoder)
    }
    
    @objc override func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.isTodoDone, forKey: "isTodoDone")
        super.encodeWithCoder(aCoder)
    }
}