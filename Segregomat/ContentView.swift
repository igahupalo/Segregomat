//
//  ContentView.swift
//  Segregomat
//
//  Created by Iga Hupalo on 02/05/2020.
//  Copyright © 2020 Iga Hupalo. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var productName = ""
    let searchFieldHint = "wyszukaj swój śmieć..."
    @State private var isSearchFieldEdited = false

    
    init() {
        
    }
    var body: some View {
        
        NavigationView {
            ZStack {
                Color("colorBackground").edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .center) {

                    Spacer()
                    
                    Image("dropDownList").overlay(
                        VStack(alignment: .trailing) {
                            Image("searchField").overlay(
                                HStack(alignment: .center, spacing: 0) {
                                    ZStack(alignment: .leading) {
                                        Text(productName == "" && isSearchFieldEdited == false ? searchFieldHint : "").font(.custom("Rubik-Medium", size: 20))
                                            .foregroundColor(.black)
                                            .padding(0)
                                        
                                        TextField("", text: $productName, onEditingChanged: {
                                            (editingChanged) in if editingChanged {
                                                self.isSearchFieldEdited = true
                                            } else {
                                                self.isSearchFieldEdited = false
                                            }
                                            
                                        }).font(.custom("Rubik-Medium", size: 20))
                                        
                                    }
                                }
                            )
                            if(productName != "") {
                                MatchingTrash().padding([.leading], 25).padding([.top], 35)
                            }
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
    }
}

// tu się dzieją ciekawe barowe rzeczy
extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        //określenie stylu bara
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.configureWithTransparentBackground()
        standardAppearance.titleTextAttributes = [.font : UIFont(name: "Rubik-Medium", size: 12)!]
        
        let scrollEdgeAppearance = UINavigationBarAppearance()
        scrollEdgeAppearance.configureWithTransparentBackground()
        scrollEdgeAppearance.titleTextAttributes = [.font : UIFont(name: "Rubik-Medium", size: 12)!]

        let compactAppearance = UINavigationBarAppearance()
        compactAppearance.configureWithTransparentBackground()
        compactAppearance.titleTextAttributes = [.font : UIFont(name: "Rubik-Medium", size: 12)!]

        
        navigationBar.standardAppearance = standardAppearance
        navigationBar.scrollEdgeAppearance = scrollEdgeAppearance
        navigationBar.compactAppearance = compactAppearance
        
        //od tego momentu w dół - swipe to dismiss
        interactivePopGestureRecognizer?.delegate = self
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}


struct ButtonShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let w = rect.size.width
        let h = rect.size.height

        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: w, y: 0))
        path.addLine(to: CGPoint(x: w, y: h/3))
        path.move(to: CGPoint(x: w, y: 2*h/3))
        path.addLine(to: CGPoint(x: w, y: h))
        path.addLine(to: CGPoint(x: 0, y: h))
        path.addLine(to: CGPoint(x: 0, y: 0))

                
        return path
    }
}

struct ButtonOutline: View {
    var body: some View {
        ButtonShape().stroke(style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round))
        .foregroundColor(.black)
        .cornerRadius(1)
            .frame(alignment: .center)
    }
}


struct MatchingTrash: View {
    var body: some View {
        ScrollView {

            MatchingItem(productName: "Puszka", trashcanType: "plastic")
            MatchingItem(productName: "Słoik dżemu", trashcanType: "glass")
            MatchingItem(productName: "Żelazko", trashcanType: "pszok")
            MatchingItem(productName: "Dezodorant Rexona", trashcanType: "mixed")
            MatchingItem(productName: "Wczorajsza gazeta", trashcanType: "paper")
            MatchingItem(productName: "Meduza", trashcanType: "")


        }.frame(minWidth: 100, maxWidth: .infinity, alignment: .leading)
    }
}

// tak tutaj sobie hardkoduję ten typ kosza, ale potem to można wywalić, żeby z bazy tego nie pobierać
struct MatchingItem: View {
    
    private var productName: String
    private var trashcanType: String
    private var destination: AnyView
    
    
    init(productName: String, trashcanType: String) {
        self.productName = productName
        self.trashcanType = trashcanType
        
        switch trashcanType {
        case "pszok":
            destination = AnyView(PszokView())
        case "":
            destination = AnyView(NoTrashcanView())
        default:
            destination = AnyView(TrashcanView(trashcanType: trashcanType))
        }
    }
    
    var body: some View {
        NavigationLink(destination: destination) {
            Text(productName).foregroundColor(.black)
                .font(.custom("Rubik-Light", size: 20))
                .padding([.trailing, .top, .bottom], 8)
                .frame(minWidth: 100, maxWidth: .infinity, alignment: .leading)
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
