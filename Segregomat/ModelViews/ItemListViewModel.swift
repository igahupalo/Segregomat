//
//  ItemListModelView.swift
//  Segregomat
//
//  Created by Iga Hupalo on 28/06/2020.
//  Copyright © 2020 Iga Hupalo. All rights reserved.
//

import Foundation
import SwiftUI

class ItemListViewModel: ObservableObject {
    @Published var items = [Item]()
    @ObservedObject var session = FirebaseSession()
//    @EnvironmentObject var session: FirebaseSession

    
    func fetchItems() {
        self.session.getItems(itemListViewModel: self)
    }
    
    func getMatchingItems(textInput: String) -> [ItemViewModel] {
        var itemList = [ItemViewModel]()
        for item in self.items {
            if(item.name.contains(textInput.lowercased())) {
                itemList.append(ItemViewModel(item: item))
            }
        }
        
        for child in itemList {
            print(child.item.name)
        }

        return itemList
    }
}
