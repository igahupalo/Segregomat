//
//  MapView.swift
//  Segregomat
//
//  Created by Iga Hupalo on 01/07/2020.
//  Copyright © 2020 Iga Hupalo. All rights reserved.
//

import SwiftUI
import MapKit

struct PszokMapView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var pszokMapViewModel = PszokMapViewModel()

    var body: some View {
        ZStack(alignment: .top) {
            Color("colorBackground").edgesIgnoringSafeArea(.all)

            pszokMapViewModel.getMapView().navigationBarBackButtonHidden(true).navigationBarItems(leading: BackButton(presentationMode: presentationMode)).navigationBarTitle("SEGREGOMAT", displayMode: .inline)

        }

    }
}

struct PszokMapView_Previews: PreviewProvider {
    static var previews: some View {
        PszokMapView()
    }
}
