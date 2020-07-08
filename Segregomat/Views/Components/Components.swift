//
//  Components.swift
//  Segregomat
//
//  Created by Iga Hupalo on 28/06/2020.
//  Copyright © 2020 Iga Hupalo. All rights reserved.
//

import Foundation
import SwiftUI



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
        ButtonShape().stroke(style: StrokeStyle(lineWidth: 4)).foregroundColor(.black).cornerRadius(1).frame(alignment: .center)
    }
}


struct BackButton: View {
    var presentationMode: Binding<PresentationMode>
    var icon: IconType
    var color: Color = .black

    enum IconType {
        case arrow, cross
    }

    init(presentationMode: Binding<PresentationMode>) {
        self.presentationMode = presentationMode
        self.icon = .arrow
    }
    init(presentationMode: Binding<PresentationMode>, icon: IconType) {
        self.presentationMode = presentationMode
        self.icon = icon

    }

    init(presentationMode: Binding<PresentationMode>, icon: IconType, color: Color) {
        self.presentationMode = presentationMode
        self.icon = icon
        self.color = color

    }
    var body: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(self.icon == .arrow ? "backIcon" : "crossIcon")
                    .foregroundColor(self.color)
                    .padding([.top, .bottom, .trailing], 15)
            }
        }
    }
}

struct OptionButton: View {
    var body: some View {
        NavigationLink(destination: AuthorsView()) {
            Image("optionIcon").foregroundColor(.black)
        }
    }
}


