//
//  ItemModelView.swift
//  Segregomat
//
//  Created by Iga Hupalo on 28/06/2020.
//  Copyright © 2020 Iga Hupalo. All rights reserved.
//

import Foundation
import SwiftUI

class ItemViewModel: Identifiable {
    let id: String
    let item: Item

    init(item: Item) {
        self.id = item.id
        self.item = item
    }
    
    func getDestination() -> some View {
        switch self.item.category {
        case "pszok":
            return AnyView(PszokView())
        default:
            return AnyView(ClassifiedView(item: self.item))
        }
    }
    
}
