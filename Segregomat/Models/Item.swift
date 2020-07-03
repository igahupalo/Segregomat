//
//  ItemModel.swift
//  Segregomat
//
//  Created by Iga Hupalo on 28/06/2020.
//  Copyright © 2020 Iga Hupalo. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct Item: Identifiable {
    let key: String
    let id: String
    let name: String
    let category: String
    let details: String
    let ref: DatabaseReference?
    
    init(key: String = "", name: String, category: String, details: String = "") {
        self.key = key
        self.id = key
        self.name = name
        self.category = category
        self.details = details
        self.ref = nil
    }
    
    enum Category: String {
        case plastic, paper, mixed, bio, pszok, glass, unclassified
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let name = value["item"]  as AnyObject? as? String,
            let category = value["category"]  as AnyObject? as? String,
            let details = value["details"]  as AnyObject? as? String
        else {
            return nil
        }
        self.ref = snapshot.ref
        self.key = snapshot.key
        self.id = snapshot.key
        self.name = name.lowercased()
        self.category = category
        self.details = details
    }
    
    func toAnyObject() -> Any {
        return [
            "name": name,
            "category": category,
            "details": details,
        ]
    }
    
    public var description: String {
        return "Name: \(name)\nCategory: \(category)\n"
    }
}
