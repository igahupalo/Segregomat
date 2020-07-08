//
//  ScannerView.swift
//  Segregomat
//
//  Created by Iga Hupalo on 04/07/2020.
//  Copyright © 2020 Iga Hupalo. All rights reserved.
//

import SwiftUI
import AVFoundation
import SSSwiftUIGIFView

struct ScannerView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var scannedItem: Item?
    @State var isScannerInactive = false
    @State var barcodeValue = ""
    @State var torchIsOn = false
    @State private var animationState: AnimationState = .none
    @EnvironmentObject var session: FirebaseSession
    
    init() {
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().tintColor = .clear
        UINavigationBar.appearance().backgroundColor = .clear
    }
    
    func torchToggle() {
        self.torchIsOn.toggle()
    }
    
    var body: some View {
        ZStack {
            Color("colorBackground").edgesIgnoringSafeArea(.all)


            if(animationState == .none) {

                Scanner(supportBarcode: [.ean13, .ean8]).interval(delay: 1.0).found{
                    if(!self.isScannerInactive) {
                        self.scannedItem = self.getMatchingItem(scanned: $0)
                        self.barcodeValue = $0
                        self.animationState = .loading
                    }
                }.torchLight(isOn: self.torchIsOn)

                NavigationLink(destination: $scannedItem.wrappedValue == nil ? AnyView(UnclassifiedView()) : ($scannedItem.wrappedValue!.category == "pszok" ? AnyView(PszokView(item: self.$scannedItem.wrappedValue!)) : AnyView(ClassifiedView(item: self.$scannedItem.wrappedValue!))), isActive: $isScannerInactive) {
                    EmptyView()
                }
            }

            else if(animationState == .loading) {
                SwiftUIGIFPlayerView(gifName: "animation")
                    .onAppear(perform: performAnim)
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 360, height: 641, alignment: .center)
            }

        }.edgesIgnoringSafeArea(.all)
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle("")
            .navigationBarItems(
                leading: BackButton(presentationMode: presentationMode, icon: .cross, color: .white).accentColor(Color.white).shadow(color: Color.black, radius: 1, x: 0, y: 2),
                trailing: Button(action: {self.torchToggle()}) {
                    Image(torchIsOn ? "boltIconFilled" : "boltIcon").foregroundColor(.white).padding([.top, .bottom, .leading], 15).shadow(color: Color.black, radius: 1, x: 0, y: 2)
            })
    }

    private func performAnim() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.isScannerInactive = true
            self.animationState = .none
        }
    }
    
    private func getMatchingItem(scanned: String) -> Item? {
        var matchingItem: Item?
        for barcode in session.barcodes {
            if(String(barcode.code) == scanned) {
                let id = barcode.id
                for item in session.items {
                    if(item.id == id) {
                        matchingItem = item
                        break;
                    }
                }
                break;
            }
        }
        
        return matchingItem
    }
}

struct ScannerView_Previews: PreviewProvider {
    static var previews: some View {
        ScannerView()
    }
}
