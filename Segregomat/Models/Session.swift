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
    @Published var pszoks: [Pszok] = []
    var ref: DatabaseReference = Database.database().reference()


    func getItems(itemListViewModel : ItemListViewModel) {
        var fetchedItems: [Item] = [Item]()
        ref.child("items").observeSingleEvent(of: .value, with: { (snapshot) in
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
    
    func getPszoks(pszokMapViewModel : PszokMapViewModel) {
        var fetchedPszoks: [Pszok] = [Pszok]()
        ref.child("pszoks").observeSingleEvent(of: .value, with: { (snapshot) in
            print(snapshot.value)
            snapshot.children.forEach({ (child) in
                if let child = child as? DataSnapshot {
                    let pszok = Pszok(snapshot: child)
                    fetchedPszoks.append(pszok!)
                }
            })
            self.pszoks = fetchedPszoks
            pszokMapViewModel.pszoks = self.pszoks
        }) { (error) in
            print(error.localizedDescription)
        }
    }
 

    
}

