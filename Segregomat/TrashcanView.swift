//
//  TrashcanView.swift
//  Segregomat
//
//  Created by Iga Hupalo on 02/05/2020.
//  Copyright © 2020 Iga Hupalo. All rights reserved.
//

import SwiftUI

struct TrashcanView: View {

    var body: some View {
        
         Color("colorBackground").edgesIgnoringSafeArea(.all).overlay(
             GeometryReader { geometry in
                 VStack(alignment: .center) {
                    HeaderView().padding(.bottom).frame(minWidth: 100, maxWidth: .infinity)
                    
                    Spacer()
                    
                    VStack {
                        Image("plasticBin")
                        
                        Text("PLASTIK I METAL").font(.custom("Rubik-Bold", size: 20))
                    }
                    
                    Spacer()
                    
                    BetterOptionButton()
                    
                    Spacer()

                                       
                 }
                 .frame(width: geometry.size.width,
                        height: geometry.size.height, alignment: .top)
             }
         )
         
    }
}

struct TrashcanView_Previews: PreviewProvider {
    static var previews: some View {
        TrashcanView()
    }
}

struct BetterOptionButton: View {
    var body: some View {
        
        Button(action: {
            print("Hello World tapped!")
        }) {
            Text("MOŻNA LEPIEJ?").padding([.leading, .trailing], 40.0).padding([.top, .bottom],15).background(ButtonOutline()).font(.custom("Rubik-Bold", size: 17)).foregroundColor(.black)
        }
    }
}
