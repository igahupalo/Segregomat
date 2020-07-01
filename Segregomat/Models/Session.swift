//
//  Session.swift
//  Segregomat
//
//  Created by Iga Hupalo on 29/06/2020.
//  Copyright © 2020 Iga Hupalo. All rights reserved.
//

import Foundation
import FirebaseDatabase

class FirebaseSession: ObservableObject {
    @Published var items: [Item] = []
    var ref: DatabaseReference = Database.database().reference()


    func getItems(itemListViewModel : ItemListViewModel) {
        var fetchedItems: [Item] = [Item]()
        ref.child("items").observeSingleEvent(of: .value, with: { (snapshot) in
//            print("items: \(snapshot)")

//            if(snapshot.exists()) {
//                let array:NSArray = snapshot.children.allObjects as NSArray
//
//                for obj in array {
//                    let snapshot:DataSnapshot = obj as! DataSnapshot
//                    if let childSnapshot = snapshot.value as? [String : AnyObject]
//                         {
//                        if let name = childSnapshot["item"] as? String {
//                            print(name)
//                        }
//                    }
//                }
//
//            }
//            print(snapshot.value)

            snapshot.children.forEach({ (child) in

                if let child = child as? DataSnapshot {
                    let item = Item(snapshot: child)
                    fetchedItems.append(item!)
                }
            })
            self.items = fetchedItems
            itemListViewModel.items = self.items
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    

    
}

