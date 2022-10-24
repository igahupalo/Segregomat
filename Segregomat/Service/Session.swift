//
//  Session.swift
//  Segregomat
//
//  Created by Iga Hupalo on 29/06/2020.
//  Copyright © 2020 Iga Hupalo. All rights reserved.
//

import Foundation
import FirebaseDatabase
import Combine

class FirebaseSession: ObservableObject {
    @Published var items: [Item] = []
    @Published var pszoks: [Pszok] = []
    @Published var barcodes: [Barcode] = []

    var ref: DatabaseReference = Database.database().reference()

    func fetchData() {
        getItems { [weak self] in
            self?.getBarcodes()
        }
        getPszoks()
    }

    func getItems(completion: @escaping () -> Void) {
        var fetchedItems: [Item] = [Item]()
        ref.child("items").observe(.value, with: { (snapshot) in
            snapshot.children.forEach({ (child) in

                if let child = child as? DataSnapshot {
                    let item = Item(snapshot: child)
                    fetchedItems.append(item!)
                }
            })

            completion()
            self.items = fetchedItems

        }) { (error) in
            print(error.localizedDescription)
        }
    }

    func getPszoks() {
        var fetchedPszoks: [Pszok] = [Pszok]()
        ref.child("pszoks").observe(.value, with: { (snapshot) in
            snapshot.children.forEach({ (child) in
                if let child = child as? DataSnapshot {
                    let pszok = Pszok(snapshot: child)
                    fetchedPszoks.append(pszok!)
                }
            })
            self.pszoks = fetchedPszoks
        }) { (error) in
            print(error.localizedDescription)
        }
    }

    func getBarcodes() {
        ref.child("bar_codes").observe(.value, with: { (snapshot) in
            snapshot.children.forEach({ (child) in
                if let child = child as? DataSnapshot {
                    let barcode = Barcode(snapshot: child)

                    for index in 0...self.items.count - 1 {
                        if(self.items[index].key == barcode!.id) {
                            self.items[index].barcode = String(barcode!.code)
                        }
                    }
                }
            })
        }) { (error) in
            print(error.localizedDescription)
        }
    }
}

