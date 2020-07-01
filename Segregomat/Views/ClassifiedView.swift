//
//  TrashcanView.swift
//  Segregomat
//
//  Created by Iga Hupalo on 02/05/2020.
//  Copyright © 2020 Iga Hupalo. All rights reserved.
//

import SwiftUI

struct ClassifiedView: View {
    private let category: String
    private let details: String
    var categoryLabel: String
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var isDetailsActive = false

    init() {
        self.category = "mixed"
        self.details = "details"
        categoryLabel = "ZMIESZANE"
    }
    
    init(item: Item) {
        self.category = item.category
        self.details = item.details
        switch self.category {
            case "plastic":
                categoryLabel = "PLASTIK I METAL"
            case "glass":
                categoryLabel = "SZKŁO"
            case "paper":
                categoryLabel = "PAPIER"
            case "bio":
                categoryLabel = "BIO"
            default:
                categoryLabel = "ZMIESZANE"
        }
    }

    var body: some View {
        
        ZStack {
            Color("colorBackground").edgesIgnoringSafeArea(.all)

                VStack(alignment: .center) {
                    if(!self.isDetailsActive) {
                        Spacer()

                        VStack {
                            Image(category)
                            Text(categoryLabel).font(.custom("Rubik-Bold", size: 20))
                        }.animation(.easeInOut)
                            Spacer()
                    }
                     
                    DetailsButton(details: details, isDetailsActive: isDetailsActive)
                    
                    Spacer()
                 }.navigationBarBackButtonHidden(true).navigationBarItems(leading: BackButton(presentationMode: presentationMode), trailing: OptionButton()).navigationBarTitle("SEGREGOMAT", displayMode: .inline)
        }
    }
}

struct TrashcanView_Previews: PreviewProvider {
    static var previews: some View {
        ClassifiedView()
    }
}







