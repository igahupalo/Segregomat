//
//  ContentView.swift
//  Segregomat
//
//  Created by Iga Hupalo on 02/05/2020.
//  Copyright © 2020 Iga Hupalo. All rights reserved.
//

import SwiftUI
import SSSwiftUIGIFView

struct MainView: View {
    @ObservedObject var model = MainViewModel()
    @ObservedObject var itemListViewModel = ItemListViewModel()
    @ObservedObject var scannerViewModel = ScannerViewModel()


    @State private var textInput = ""
    let searchFieldHint = "wyszukaj swój śmieć..."
    @State private var isSearchFieldEdited = false
    @State private var isLaunchScreenOn = true;
    
    init() {
        
    }
    
    var body: some View {

        NavigationView {
            ZStack {
                Color("colorBackground").edgesIgnoringSafeArea(.all)
                if(isLaunchScreenOn) {
                    SwiftUIGIFPlayerView(gifName: "launchScreenAnimation").onAppear(perform: performAnim).navigationBarTitle("").navigationBarHidden(true).aspectRatio(contentMode: .fit).frame(width: 375, height: 667, alignment: .center)
                } else {
                    VStack(alignment: .center) {
                        Spacer()
                        ListOutline().overlay(
                            VStack(alignment: .trailing, spacing: 0) {
                                SearchOutline().overlay(
                                    HStack(alignment: .center, spacing: 0) {
                                        ZStack(alignment: .leading) {
                                            Text(textInput == "" && isSearchFieldEdited == false ? searchFieldHint : "").font(.custom("Rubik-Medium", size: 20)).foregroundColor(.black).padding(0)
                                            
                                            TextField("", text: $textInput, onEditingChanged: {
                                                (editingChanged) in if editingChanged {
                                                    self.isSearchFieldEdited = true
                                                } else {
                                                    self.isSearchFieldEdited = false
                                                }
                                            
                                            }).font(.custom("Rubik-Medium", size: 20)).autocapitalization(.none)
                                        
                                            
                                        }
                                    }
                                )
                                
                                ScrollView(showsIndicators: false) {
                                    VStack{

                                        ForEach(itemListViewModel.getMatchingItems(textInput: textInput)) { (item) in
                                            ListPosition(item: item, textInput: self.textInput)
                                        }
                                        HStack {
                                            Spacer()
                                        }
                                    }.padding([.top], 5)
                                }.frame(minWidth: 100, maxWidth: .infinity, alignment: .leading).padding([.leading], 30).padding([.top], 0)
                            },
                            alignment: .topTrailing
                        )
                        
                        Spacer()
                        
                        VStack(spacing: 30) {
                            NavigationLink(destination: ScannerView()) {
                                Text("zeskanuj").padding([.leading, .trailing], 40.0)
                                    .padding([.top, .bottom], 10)
                                    .background(ButtonOutline())
                                    .font(.custom("Rubik-Medium", size: 20))
                                    .foregroundColor(.black)
                            }
                            
                            Image("barcode")
                        }
                        
                        Spacer()

                    }.navigationBarTitle("SEGREGOMAT", displayMode: .inline).navigationBarItems(trailing: OptionButton()).accentColor(.black)
                }
            }

        }.dismissKeyboardOnTap()
        
    }
    
    private func performAnim() {
        itemListViewModel.fetchItems()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.isLaunchScreenOn = false
        }
    }
}

struct ListShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let w = rect.size.width
        let h = rect.size.height

        path.move(to: CGPoint(x: 1.5 * w / 16, y: 0))
        path.addLine(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 0, y: h))
        path.addLine(to: CGPoint(x: w, y: h))
        path.addLine(to: CGPoint(x: w, y: 5 * h / 16))

        return path
    }
}

struct ListOutline: View {
    var body: some View {
        ListShape().stroke(style: StrokeStyle(lineWidth: 4)).foregroundColor(.black).cornerRadius(1).frame(width: 327, height: 327, alignment: .center)
    }
}

struct SearchShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let w = rect.size.width
        let h = rect.size.height

        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: w, y: 0))
        path.addLine(to: CGPoint(x: w, y: h))
        path.addLine(to: CGPoint(x: 0, y: h))

        return path
    }
}

struct SearchOutline: View {
    var body: some View {
        SearchShape().stroke(style: StrokeStyle(lineWidth: 4)).foregroundColor(.black).cornerRadius(1).frame(width: 296.34375, height: 51.09375, alignment: .center)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
