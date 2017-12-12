//
//  DSA.swift
//  DSA
//
//  Created by Alex Paul on 12/8/17.
//  Copyright © 2017 Alex Paul. All rights reserved.
//

import Foundation

enum DSAPropertyKey: String {
    case title
    case description
}

// The DSA class must inherit from NSObject to get the required methods for NSCoding class
// This makes our class inherit from NSObject and NSCoding
// We have to conform to NSCoding by implementing it's encode() and init() methods
class DSA: NSObject, NSCoding {
    var title: String
    var dsaDescription: String
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: DSAPropertyKey.title.rawValue)
        aCoder.encode(dsaDescription, forKey: DSAPropertyKey.description.rawValue)
    }

    // Since our class is allowing subclassing the convenience initializer here must be marked required
    // If we mared the class final then we would be able to remove the required keyword
    required convenience init?(coder aDecoder: NSCoder) {
        guard let title = aDecoder.decodeObject(forKey: DSAPropertyKey.title.rawValue) as? String,
            let description = aDecoder.decodeObject(forKey: DSAPropertyKey.description.rawValue) as? String
            else { return nil }
        self.init(title: title, description: description)
    }

    init(title: String, description: String) {
        self.title = title
        self.dsaDescription = description
    }
}
