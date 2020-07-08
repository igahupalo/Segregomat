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
    @EnvironmentObject var session: FirebaseSession
    @State private var textInput = ""
    @State private var isSearchFieldEdited = false
    @State private var animationState: AnimationState = .launching
    @State private var chosenItem: Item? = nil
    @State private var isLoaded = false

    let searchFieldHint = "wyszukaj swój śmieć..."

    var body: some View {
        
        NavigationView {
            ZStack {
                Color("colorBackground").edgesIgnoringSafeArea(.all)

                self.chosenItem.map { chosenItem in
                    NavigationLink(destination: self.chosenItem!.category == "pszok" ? AnyView(PszokView(item: self.chosenItem!)) : AnyView(ClassifiedView(item: self.chosenItem!)), isActive: $isLoaded) {
                        EmptyView()
                    }
                }

                if(animationState != .none) {
                    SwiftUIGIFPlayerView(gifName: animationState == .launching ? "animationTitled" : "animation")
                        .onAppear(perform: performAnim)
                        .navigationBarTitle("")
                        .navigationBarHidden(true)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 375, height: 667, alignment: .center)
                } else {
                    VStack(alignment: .center) {

                        Spacer()
                        ListOutline().overlay(
                            VStack(alignment: .trailing, spacing: 0) {
                                SearchOutline().overlay(
                                    HStack(alignment: .center, spacing: 0) {
                                        ZStack(alignment: .leading) {
                                            Text(textInput == "" && isSearchFieldEdited == false ? searchFieldHint : "")
                                                .font(.custom("Rubik-Medium", size: 20))
                                                .foregroundColor(.black)
                                                .padding(0)
                                            
                                            TextField("", text: $textInput, onEditingChanged: {
                                                (editingChanged) in if editingChanged {
                                                    self.isSearchFieldEdited = true
                                                } else {
                                                    self.isSearchFieldEdited = false
                                                }
                                                
                                            }).font(.custom("Rubik-Medium", size: 20))
                                                .autocapitalization(.none)
                                            
                                            
                                        }
                                    }
                                )
                                
                                ScrollView(showsIndicators: false) {
                                    VStack{
                                        
                                        ForEach(getMatchingItems(textInput: textInput)) { (item) in
                                            ListPosition(item: item, textInput: self.textInput, animationState: self.$animationState, chosenItem: self.$chosenItem)
                                        }
                                        HStack {
                                            Spacer()
                                        }
                                    }.padding([.top], 5)
                                }.frame(minWidth: 100, maxWidth: .infinity, alignment: .leading)
                                    .padding([.leading], 30)
                                    .padding([.top], 0)
                            }, alignment: .topTrailing
                        )
                        
                        Spacer()
                        
                        VStack(spacing: 30) {
                            NavigationLink(destination: ScannerView()) {
                                Text("zeskanuj")
                                    .padding([.leading, .trailing], 40.0)
                                    .padding([.top, .bottom], 10)
                                    .background(ButtonOutline())
                                    .font(.custom("Rubik-Medium", size: 20))
                                    .foregroundColor(.black)
                            }
                            
                            Image("barcode")
                        }
                        
                        Spacer()
                        
                    }.navigationBarTitle("SEGREGOMAT", displayMode: .inline)
                        .navigationBarItems(trailing: OptionButton())
                        .accentColor(.black)
                }
            }.onDisappear(perform: {
                self.animationState = .none
            })
            
        }.dismissKeyboardOnTap()
    }

    private func performAnim() {
        if(self.animationState == .launching) {
            self.session.getItems()
            self.session.getPszoks()
            self.session.getBarcodes()
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.animationState = .none
            }
        } else if(self.animationState == .loading) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.isLoaded.toggle()
            }
        }
    }
    
    private func getMatchingItems(textInput: String) -> [Item] {
        var itemList = [Item]()
        for item in session.items {
            if(item.name.contains(textInput.lowercased())) {
                itemList.append(item)
            }
        }
        
        for child in itemList {
            print(child.name)
        }
        
        return itemList
    }
}

enum AnimationState {
    case launching, loading, none
}

private struct ListShape: Shape {
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

private struct ListOutline: View {
    var body: some View {
        ListShape().stroke(style: StrokeStyle(lineWidth: 4)).foregroundColor(.black).cornerRadius(1).frame(width: 327, height: 327, alignment: .center)
    }
}

private struct SearchShape: Shape {
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

private struct SearchOutline: View {
    var body: some View {
        SearchShape().stroke(style: StrokeStyle(lineWidth: 4)).foregroundColor(.black).cornerRadius(1).frame(width: 296.34375, height: 51.09375, alignment: .center)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
