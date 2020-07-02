//
//  AuthorsView.swift
//  Segregomat
//
//  Created by Iga Hupalo on 05/05/2020.
//  Copyright © 2020 Iga Hupalo. All rights reserved.
//

import SwiftUI

struct AuthorsView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        
        ZStack {
            Color("colorBackground").edgesIgnoringSafeArea(.all)
            
            AuthorsText().frame(alignment: .top)
         }.navigationBarBackButtonHidden(true).navigationBarItems(leading: BackButton(presentationMode: presentationMode)).navigationBarTitle("SEGREGOMAT", displayMode: .inline)
        
    }
}
struct AuthorsView_Previews: PreviewProvider {
    static var previews: some View {
        AuthorsView()
    }
}

struct AuthorsText: View {
    var body: some View {
        GeometryReader { geometry in
            
            VStack(alignment: .center, spacing: 20) {
                VStack(alignment: .center, spacing: 0) {
                    Text("POMYSŁ I DESIGN").font(.custom("Rubik-Bold", size: 14))
                    Text("Anna Ludwin").font(.custom("Rubik-Regular", size: 14))
                }
                VStack(alignment: .center, spacing: 0) {

                    Text("PROGRAMIŚCI IOS").font(.custom("Rubik-Bold", size: 14))
                    Text("Kinga Gniedziejko\nIga Hupało\nJan Mielniczuk").font(.custom("Rubik-Regular", size: 14))
                        .multilineTextAlignment(.center)
                }
                VStack(alignment: .center, spacing: 0) {
                    Text("PROGRAMIŚCI ANDROID").font(.custom("Rubik-Bold", size: 14))
                    Text("Kacper Kiedos\nPaweł Klecha").font(.custom("Rubik-Regular", size: 14))
                        .multilineTextAlignment(.center)
                }
                VStack(alignment: .center, spacing: 0) {

                    Text("PROMOTORZY").font(.custom("Rubik-Bold", size: 14))
                    Text("Marek Rybicki\nMaja Wolińska\nAleksandra Trojanowska").font(.custom("Rubik-Regular", size: 14))
                        .multilineTextAlignment(.center)
                    
                }
                VStack(alignment: .center, spacing: 0) {
                    Text("POMOC TECHNICZNA").font(.custom("Rubik-Bold", size: 14))
                    Text("Krzysztof Waśko").font(.custom("Rubik-Regular", size: 14))
                }

                Text("ASP Wrocław\n2020").font(.custom("Rubik-Bold", size: 14))
                    .multilineTextAlignment(.center)
            }

        }.frame(minWidth: 100, maxWidth: .infinity, minHeight: 100, maxHeight: .infinity, alignment: .top)
    }
}

