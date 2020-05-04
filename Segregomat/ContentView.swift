//
//  ContentView.swift
//  Segregomat
//
//  Created by Iga Hupalo on 02/05/2020.
//  Copyright © 2020 Iga Hupalo. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        
        Color("colorBackground").edgesIgnoringSafeArea(.all).overlay(
            GeometryReader { geometry in
                VStack(alignment: .center) {
                    HeaderView().padding(.bottom).frame(minWidth: 100, maxWidth: .infinity)

                    Spacer()
                    
                    Image("dropDownList").overlay(
                        VStack(alignment: .trailing) {
                            Image("searchField").overlay(
                                SearchField()
                            )
                            
                            MatchingTrash().padding([.leading], 25)
                        },
                        alignment: .topTrailing
                    )

                    Spacer()

                    
                    Button(action: {
                        print("Hello World tapped!")
                    }) {
                        Text("zeskanuj").padding([.leading, .trailing], 40.0).padding([.top, .bottom], 10).background(ButtonOutline())      .font(.custom("Rubik-Medium", size: 20)).foregroundColor(.black)

                    }
                    
                    Spacer()
                    
                    Image("barcode")
                    
                    Spacer()

                }
                .frame(width: geometry.size.width,
                       height: geometry.size.height, alignment: .top)
            }
        )
        
    }
}

struct HeaderView: View {
    var body: some View {
        HStack(alignment: .center) {
            Button(action: {
                print("Hello World tapped!")
            }) {
                Image("backIcon").foregroundColor(.black).padding(10.0)
            }
            
            Spacer()
            
            Text("SEGREGOMAT")
                .font(.custom("Rubik-Medium", size: 12))
            
            Spacer()

            
            Button(action: {
                print("Hello World tapped!")
            }) {
                Image("optionIcon").foregroundColor(.black).padding(10)
            }
        }
    }
}

struct ButtonOutline: View {
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let w = geometry.size.width
                let h = geometry.size.height

                path.move(to: CGPoint(x: 0, y: 0))
                path.addLine(to: CGPoint(x: w, y: 0))
                path.addLine(to: CGPoint(x: w, y: h/3))
                path.move(to: CGPoint(x: w, y: 2*h/3))
                path.addLine(to: CGPoint(x: w, y: h))
                path.addLine(to: CGPoint(x: 0, y: h))
                path.addLine(to: CGPoint(x: 0, y: 0))

                }.stroke(style: StrokeStyle(lineWidth: 4, lineCap: .round)).foregroundColor(.black).cornerRadius(1).frame(alignment: .center)
        }
    }
}

struct SearchField: View {
    @State private var productName = "wyszukaj swój śmieć..."
    @State var isOpen: Bool = false

    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            TextField("wyszukaj swój śmieć", text: $productName).font(.custom("Rubik-Medium", size: 20))


            Button(action: {
                self.isOpen = true
            }) {
                Image("checkIcon").foregroundColor(.black).padding(15)
            }.sheet(isPresented: $isOpen, content: {
                TrashcanView()
                })
        }
    }
}

struct MatchingTrash: View {
    var body: some View {
        ScrollView {
            ForEach(0..<10) {_ in
                MatchingItem()
            }
        }.frame(minWidth: 100, maxWidth: .infinity, alignment: .leading)
    }
}

struct MatchingItem: View {
    let itemName = "nazwa"
    var body: some View {
        Text(itemName).foregroundColor(.black).font(.custom("Rubik-Regular", size: 20)).padding([.trailing, .top, .bottom], 8).frame(minWidth: 100, maxWidth: .infinity, alignment: .leading)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
