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

                        Image("dropDownList").overlay(
                            VStack(alignment: .trailing) {
                                Image("searchField").overlay(
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
                                
                                ScrollView {
                                    VStack{
                                        HStack {
                                            Spacer()
                                        }
                                        ForEach(itemListViewModel.getMatchingItems(textInput: textInput)) { (item) in
                                            ListPosition(item: item, textInput: self.textInput)
                                        }
                                    }
                                }.frame(minWidth: 100, maxWidth: .infinity, alignment: .leading).padding([.leading], 25).padding([.top], 35)
                            },
                            alignment: .topTrailing
                        )
                        
                        Spacer()
                        
                        VStack(spacing: 30) {
                            Button(action: {
                                print("Hello World tapped!")
                            }) {
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
