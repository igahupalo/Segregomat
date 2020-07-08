//
//  PszokView.swift
//  Segregomat
//
//  Created by Iga Hupalo on 06/05/2020.
//  Copyright © 2020 Iga Hupalo. All rights reserved.
//

import SwiftUI

struct PszokView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var details: String = ""
    @State var isDetailsActive = false
    
    init(item: Item) {
        self._details = State(wrappedValue: item.details)
    }
    
    init() {}
    
    var body: some View {
        
        ZStack {
            Color("colorBackground").edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center) {
                Spacer()
                
                VStack {
                    if(!self.isDetailsActive) {
                        
                        Image("pszok")
                        
                        VStack(alignment: .center) {
                            Text("PSZOK")
                                .font(.custom("Rubik-Bold", size: 20))
                            Text("punkt selektywnego\nzbierania odpadów\nkomunalnych")
                                .font(.custom("Rubik-Regular", size: 16))
                                .multilineTextAlignment(.center)
                        }
                        Spacer()
                    }
                    
                    HStack {
                        if(!self.isDetailsActive) {
                            PszokButton().padding(5)
                            Spacer()
                        }
                        DetailsButton(isDetailsActive: $isDetailsActive, details: $details).padding(5)
                    }.frame(maxHeight: !isDetailsActive ? 80 : .infinity)
                        .padding()
                    
                    if(!self.isDetailsActive) {
                        Spacer()
                    }
                    
                }.navigationBarBackButtonHidden(true)
                    .navigationBarItems(
                        leading: BackButton(presentationMode: presentationMode),
                        trailing: OptionButton())
                    .navigationBarTitle("SEGREGOMAT", displayMode: .inline)
            }
        }
    }
}

struct PszokView_Previews: PreviewProvider {
    static var previews: some View {
        PszokView()
    }
}


