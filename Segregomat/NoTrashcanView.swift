//
//  NoTrashcanView.swift
//  Segregomat
//
//  Created by Iga Hupalo on 06/05/2020.
//  Copyright © 2020 Iga Hupalo. All rights reserved.
//

import SwiftUI

struct NoTrashcanView: View {
    var body: some View {
        ZStack {
            Color("colorBackground").edgesIgnoringSafeArea(.all)
            VStack(alignment: .center, spacing: 20) {
                Text("segregomacie,\nnajpiękniejszy w świecie!\nczemu nie wiesz,\ngdzie wrzucić moje śmiecie…").font(.custom("Rubik-BoldItalic", size: 17)).multilineTextAlignment(.center)
                Text("produkt zostanie dodany\ndo bazy").font(.custom("Rubik-Light", size: 17)).multilineTextAlignment(.center)
            }.navigationBarBackButtonHidden(true).navigationBarItems(leading: BackButton()).navigationBarItems(leading: BackButton(), trailing: OptionButton())
                .navigationBarTitle("SEGREGOMAT", displayMode: .inline)
        }
    }
}

struct NoTrashcanView_Previews: PreviewProvider {
    static var previews: some View {
        NoTrashcanView()
    }
}
