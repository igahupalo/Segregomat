//
//  TrashcanView.swift
//  Segregomat
//
//  Created by Iga Hupalo on 02/05/2020.
//  Copyright © 2020 Iga Hupalo. All rights reserved.
//

import SwiftUI

struct TrashcanView: View {
    private let trashcanType: String
    var trashcanText: String
    @State var isBetterOptionActive = false
    @State var betterOptionButtonText = "MOŻNA LEPIEJ?"
    private let betterOptionDetails = "zamiast kupować dżem truskawkowy, możesz zrobić go bardzo łatwo w domu, wystarczy:\n\nskładniki na około 1,5 słoiczka:\n\n1 kg truskawek\n300 g cukru\n1 – 2 łyżeczki pasty waniliowej lub nasionka z 1 laski wanilii\n1 łyżeczka otartej skórki z cytryny\n2 łyżki soku z cytryny\n1 – 2 łyżeczki masła (niekoniecznie, by nie podczas smażenia nie powstawała piana)\n\ntruskawki odszypułkować, umyć, wrzucić do garnka z grubszym dnem razem z pozostałymi składnikami. postawić na palnik, cały czas mieszając doprowadzić do wrzenia.\n\ngotować przez kilka godzin, na małej mocy palnika, bez pokrywki, aż truskawki zaczną się rozpadać a woda odparuje na tyle, że konfitura będzie miała odpowiednią konsystencję. najkorzystniej gotowanie konfitury rozłożyć na 3 dni, np.  po 1 godzinie dziennie.\n\njak sprawdzić, czy dżem jest gotowy? do zamrażarki włożyć talerzyk. na zamrożony wylać łyżkę gorącego dżemu. jeśli zastygnie, a na powierzchni utworzy się skórka, która przy dotyku się pomarszczy – wystarczy już gotowania.\n\nsłoiki wyparzyć (wrzącą wodą lub w piekarniku nagrzanym do 100ºc). przelać dżem, dobrze zakręcić. odstawić.\n\npasteryzacja:\n\nspory garnek z szerokim dnem wyłożyć ręcznikami kuchennymi. włożyć słoiki, jeden obok drugiego, nalać wrzątku do 3/4 wysokości słoików, doprowadzić do wrzenia (temperatura wlewanej wody musi się zgadzać z temperaturą słoików, nie może to być np. zimna woda wlewana na gorące słoiki, by nie pękły). zmniejszyć moc palnika, przykryć i gotować około 20 minut. po tym czasie słoiki wyjąć i zostawić do całkowitego wystudzenia. niektóre osoby dodatkowo odwracają słoiki do góry dnem i owijają kocami, tak zostawiając do wystudzenia na całą noc.\n\n* jeśli chcemy otrzymać większą ilość dżemu i w krótszym czasie, wystarczy po niedługim gotowaniu dodać pektyny; jest to naturalna substancja, która zagęszcza dżemy (używamy jej wedle instrukcji na opakowaniu)."


    
    init() {
        //robię śmieci jakieś ale ustalmy że domyślny kosz jest mieszany
        self.trashcanType = "mixed"
        trashcanText = "ZMIESZANE"
    }
    
    init(trashcanType: String) {
        self.trashcanType = trashcanType
        
        switch self.trashcanType {
            case "plastic":
                trashcanText = "PLASTIK I METAL"
            case "glass":
                trashcanText = "SZKŁO"
            case "paper":
                trashcanText = "PAPIER"
            default:
                trashcanText = "ZMIESZANE"
        }
    }

    var body: some View {
        
        ZStack {
            Color("colorBackground").edgesIgnoringSafeArea(.all)

                VStack(alignment: .center) {
                    if(!self.isBetterOptionActive) {
                        Spacer()

                        VStack {
                            Image(trashcanType)
                            Text(trashcanText).font(.custom("Rubik-Bold", size: 20))
                        }.animation(.easeInOut)
                            Spacer()
                    }
                     
                    //betterOptionButton
                    Button(action: {
                        withAnimation {
                            self.isBetterOptionActive.toggle()
                        }
                    }) {
                        ZStack {
                            if(!self.isBetterOptionActive) {
                                Text(betterOptionButtonText).padding([.leading, .trailing], 15).padding([.top, .bottom],25).font(.custom("Rubik-Bold", size: 17)).foregroundColor(.black).animation(.easeInOut)
                            } else {
                                ScrollView {
                                    Text(betterOptionDetails).padding([.leading, .trailing], 15).padding([.top, .bottom],25).font(.custom("Rubik-Light", size: 17)).foregroundColor(.black).animation(.easeInOut)
                                }
                            }
                        }.background(ButtonOutline())

                    }.padding()
                    
                    Spacer()
                 }.navigationBarBackButtonHidden(true).navigationBarItems(leading: BackButton(), trailing: OptionButton()).navigationBarTitle("SEGREGOMAT", displayMode: .inline)
        }
    }
}

struct TrashcanView_Previews: PreviewProvider {
    static var previews: some View {
        TrashcanView()
    }
}

struct BackButton: View {
@Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image("backIcon").foregroundColor(.black).padding([.top, .bottom, .trailing], 15)
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

struct BetterOptionButton: View {
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



