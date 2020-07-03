//
//  PszokButton.swift
//  Segregomat
//
//  Created by Iga Hupalo on 02/07/2020.
//  Copyright © 2020 Iga Hupalo. All rights reserved.
//

import Foundation
import SwiftUI

struct PszokButton: View {
    var body: some View {
        NavigationLink(destination: PszokMapView()) {
            Text("ZNAJDŹ SWÓJ\nPSZOK")
                //.padding([.leading, .trailing], 15.0).padding([.top, .bottom],15)
                .font(.custom("Rubik-Bold", size: 17)).foregroundColor(.black).multilineTextAlignment(.center).frame(minWidth: 0, maxWidth: .infinity,  minHeight: 0, maxHeight: .infinity, alignment: .center).background(DetailsButtonOutline())
        }
    }
}
