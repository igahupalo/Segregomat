//
//  PszokView.swift
//  Segregomat
//
//  Created by Iga Hupalo on 06/05/2020.
//  Copyright © 2020 Iga Hupalo. All rights reserved.
//

import SwiftUI

struct PszokView: View {

    var body: some View {
        
        ZStack {
            Color("colorBackground").edgesIgnoringSafeArea(.all)
            VStack(alignment: .center) {
                Spacer()

                VStack {
                    Image("pszok")
                    
                    VStack(alignment: .center) {
                        Text("PSZOK").font(.custom("Rubik-Bold", size: 20))
                        Text("punkt selektywnego\nzbierania odpadów\nkomunalnych").font(.custom("Rubik-Regular", size: 16)).multilineTextAlignment(.center)
                    }
                
                Spacer()
                
                YourPszokButton()
                
                Spacer()
            }.navigationBarBackButtonHidden(true).navigationBarItems(leading: BackButton()).navigationBarItems(leading: BackButton(), trailing: OptionButton())
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

struct YourPszokButton: View {
    var body: some View {
        
        Button(action: {
            print("Hello World tapped!")
        }) {
            Text("ZNAJDŹ SWÓJ\nPSZOK").padding([.leading, .trailing], 40.0).padding([.top, .bottom],15).background(ButtonOutline()).font(.custom("Rubik-Bold", size: 17)).foregroundColor(.black).multilineTextAlignment(.center)
        }
    }
}
