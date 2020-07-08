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
    @Published var barcodes: [Barcode] = []

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

// TODO: delete this
    func getItems(scannerViewModel : ScannerViewModel) {
        var fetchedItems: [Item] = [Item]()
        ref.child("items").observeSingleEvent(of: .value, with: { (snapshot) in
            snapshot.children.forEach({ (child) in

                if let child = child as? DataSnapshot {
                    let item = Item(snapshot: child)
                    fetchedItems.append(item!)
                }
            })
            self.items = fetchedItems
            scannerViewModel.items = self.items
        }) { (error) in
            print(error.localizedDescription)
        }
    }

//    func getItems() {
//        var fetchedItems: [Item] = [Item]()
//        ref.child("items").observeSingleEvent(of: .value, with: { (snapshot) in
//            snapshot.children.forEach({ (child) in
//
//                if let child = child as? DataSnapshot {
//                    let item = Item(snapshot: child)
//                    fetchedItems.append(item!)
//                }
//            })
//            self.items = fetchedItems
//        }) { (error) in
//            print(error.localizedDescription)
//        }
//    }
    
    func getPszoks(pszokMapViewModel : PszokMapViewModel) {
        var fetchedPszoks: [Pszok] = [Pszok]()
        ref.child("pszoks").observeSingleEvent(of: .value, with: { (snapshot) in
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

    func getBarcodes(scannerViewModel : ScannerViewModel) {
        var fetchedBarcodes: [Barcode] = [Barcode]()
        ref.child("bar_codes").observeSingleEvent(of: .value, with: { (snapshot) in
            print(snapshot.value as Any)
            snapshot.children.forEach({ (child) in
                if let child = child as? DataSnapshot {
                    let barcode = Barcode(snapshot: child)
                    fetchedBarcodes.append(barcode!)
                }
            })
            self.barcodes = fetchedBarcodes
            scannerViewModel.barcodes = self.barcodes
        }) { (error) in
            print(error.localizedDescription)
        }
    }
}

