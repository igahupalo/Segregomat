//
//  ScannerView.swift
//  Segregomat
//
//  Created by Iga Hupalo on 04/07/2020.
//  Copyright © 2020 Iga Hupalo. All rights reserved.
//

import SwiftUI
import AVFoundation


struct ScannerView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var scannerViewModel = ScannerViewModel()
    @State var scannedItem: ItemViewModel?
    @State var isScannerInactive = false


    @State var barcodeValue = ""
    @State var torchIsOn = false

    init() {
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().tintColor = .clear
        UINavigationBar.appearance().backgroundColor = .clear

        scannerViewModel.fetchItems()
    }

    func torchToggle() {
        self.torchIsOn.toggle()
    }

    var body: some View {
        ZStack {
            Scanner(supportBarcode: [.ean13, .ean8]).interval(delay: 1.0).found{
                if(!self.isScannerInactive) {
                    self.scannedItem = self.scannerViewModel.getMatchingItem(scanned: $0)
                    self.barcodeValue = $0
                    self.isScannerInactive.toggle()
                }
            }.torchLight(isOn: self.torchIsOn)

            NavigationLink(destination: $scannedItem.wrappedValue == nil ? AnyView(UnclassifiedView()) : AnyView($scannedItem.wrappedValue!.getDestination()), isActive: $isScannerInactive) {
                EmptyView()
            }

        }.edgesIgnoringSafeArea(.all).navigationBarBackButtonHidden(true).navigationBarTitle("")
            .navigationBarItems(
                leading: BackButton(presentationMode: presentationMode, icon: .cross, color: .white).accentColor(Color.white).shadow(color: Color.black, radius: 1, x: 0, y: 2),
                trailing: Button(action: {self.torchToggle()}) {
                    //Image(systemName: self.torchIsOn ? "bolt.slash.fill" : "bolt.fill").foregroundColor(.white).padding([.top, .bottom, .trailing], 15).shadow(color: Color.black, radius: 1, x: 0, y: 2)
                    Image(torchIsOn ? "boltIconFilled" : "boltIcon").foregroundColor(.white).padding([.top, .bottom, .leading], 15).shadow(color: Color.black, radius: 1, x: 0, y: 2)
                }
            )
    }
}

struct ScannerView_Previews: PreviewProvider {
    static var previews: some View {
        ScannerView()
    }
}
