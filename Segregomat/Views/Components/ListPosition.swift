//
//  ListPosition.swift
//  Segregomat
//
//  Created by Iga Hupalo on 30/06/2020.
//  Copyright © 2020 Iga Hupalo. All rights reserved.
//

import SwiftUI

struct ListPosition: View{
    let item: ItemViewModel
    let textInput: String
    
    init(item: ItemViewModel, textInput: String) {
        self.item = item
        self.textInput = textInput.lowercased()
    }
    
    func getText() -> Text {
        var text = Text("")
        let name = item.item.name.lowercased()
        let splits = name.components(separatedBy: textInput).flatMap { [$0, textInput] }.dropLast().filter { $0 != "" }
        
        for split in splits {
            if(split == textInput) {
                text = text + Text(split).font(.custom("Rubik-Medium", size: 20))
            } else {
                text = text + Text(split).font(.custom("Rubik-Light", size: 20))
            }
        }
        return text
    }
    
    var body: some View {
        NavigationLink(destination: item.getDestination()) {
            getText().foregroundColor(.black).padding([.trailing, .top, .bottom], 8).frame(minWidth: 100, maxWidth: .infinity, alignment: .leading)
        }
    }
}
