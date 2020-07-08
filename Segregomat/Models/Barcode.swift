//
//  Barcode.swift
//  Segregomat
//
//  Created by Iga Hupalo on 08/07/2020.
//  Copyright © 2020 Iga Hupalo. All rights reserved.
//

import Foundation
import FirebaseDatabase


struct Barcode: Identifiable {
    let key: String
    let id: String
    let item: String
    let code: Int
    let ref: DatabaseReference?

    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let item = value["item"]  as AnyObject? as? String,
            let code = value["code"] as AnyObject? as? Int                                                                                      ,
            let id = value["id"] as AnyObject? as? Int

        else {
            return nil
        }
        self.ref = snapshot.ref
        self.key = snapshot.key
        self.id = String(id)
        self.item = item.lowercased()
        self.code = code
    }

    public var description: String {
        return "Name: \(item)\nCode: \(code)\n"
    }
}
