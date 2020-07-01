//
//  DetailsButton.swift
//  Segregomat
//
//  Created by Iga Hupalo on 30/06/2020.
//  Copyright © 2020 Iga Hupalo. All rights reserved.
//

import SwiftUI

struct DetailsButton: View {
    @State var isDetailsActive = false
//    var betterOptionButtonText = "MOŻNA LEPIEJ?"
    var details: String
    
    init(details: String, isDetailsActive: Bool) {
        self.details = details
        self.isDetailsActive = isDetailsActive
    }
    
    var body: some View {
        Button(action: {
            withAnimation {
                self.isDetailsActive.toggle()
            }
        }) {
            ZStack {
                if(!self.isDetailsActive) {
                    Text("MOŻNA LEPIEJ?").padding([.leading, .trailing], 15).padding([.top, .bottom],25).font(.custom("Rubik-Bold", size: 17)).foregroundColor(.black)
                } else {
                    ScrollView {
                        Text(details).padding([.leading, .trailing], 15).padding([.top, .bottom],25).font(.custom("Rubik-Light", size: 17)).foregroundColor(.black)
                    }
                }
            }.background(DetailsButtonOutline(gap: !self.isDetailsActive ? 3 : 5))
                //.transition(.move(edge: .top)).animation(.linear)
        }.padding()
    }
}

struct DetailsButtonShape: View {
    @State private var scale: CGFloat = 1
    
    var body: some View {
        Text("")
    }

    static var customTransition: AnyTransition {
        let insertion = AnyTransition.move(edge: .top)
            .combined(with: .scale(scale: 0.2, anchor: .topTrailing))
            .combined(with: .opacity)
        let removal = AnyTransition.move(edge: .top)
        return .asymmetric(insertion: insertion, removal: removal)
    }

}

struct DetailsButtonOutline: View {
    private var gap: CGFloat
    
    init(gap: CGFloat) {
        self.gap = gap
    }
    var body: some View {
        DetailsShape(gap: gap).stroke(style: StrokeStyle(lineWidth: 4)).foregroundColor(.black).cornerRadius(1).frame(alignment: .center)
    }
}

struct DetailsShape: Shape {
    private var gap: CGFloat
    
    init(gap: CGFloat) {
        self.gap = gap
    }
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let w = rect.size.width
        let h = rect.size.height

        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: w, y: 0))
        path.addLine(to: CGPoint(x: w, y: h/gap))
        path.move(to: CGPoint(x: w, y: 2*h/gap))
        path.addLine(to: CGPoint(x: w, y: h))
        path.addLine(to: CGPoint(x: 0, y: h))
        path.addLine(to: CGPoint(x: 0, y: 0))

                
        return path
    }
}

