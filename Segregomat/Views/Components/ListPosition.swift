//
//  ListPosition.swift
//  Segregomat
//
//  Created by Iga Hupalo on 30/06/2020.
//  Copyright © 2020 Iga Hupalo. All rights reserved.
//

import SwiftUI

struct ListPosition: View{
    @EnvironmentObject var session: FirebaseSession
    @Binding var animationState: AnimationState
    @Binding var chosenItem: Item?
    
    let item: Item
    let textInput: String

    
    init(item: Item, textInput: String, animationState: Binding<AnimationState>, chosenItem: Binding<Item?>) {
        self.item = item
        self.textInput = textInput.lowercased()
        self._animationState = animationState
        self._chosenItem = chosenItem
    }

    var body: some View {

        Button(action: {
            self.chosenItem = self.item
            self.animationState = .loading
        }) {
            getText()
                .foregroundColor(.black)
                .padding([.trailing, .top, .bottom], 8)
                .frame(minWidth: 100, maxWidth: .infinity, alignment: .leading)
        }
    }

    func getText() -> Text {
        var text = Text("")
        let name = item.name.lowercased()
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

    func getMatchingItems(textInput: String) -> [Item] {
        var itemList = [Item]()
        for item in session.items {
            if(item.name.contains(textInput.lowercased())) {
                itemList.append(item)
            }
        }

        return itemList
    }

}
