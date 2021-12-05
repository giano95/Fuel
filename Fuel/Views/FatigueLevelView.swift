//
//  FatigueLevelView.swift
//  Fuel
//
//  Created by Marco Gianelli on 26/05/2021.
//

import SwiftUI

let fatigueTitles: [Int : String] = [
    -1: "",
    0: "Very low",
    1: "Low",
    2: "Ok",
    3: "High",
    4: "Very High",
    5: "Too high"
]

let fatigueDescriptions: [Int : String] = [
    -1: "Press on the number that matches your fatigue level in this moment.",
    0: "You're not tired, you can focus clearly and you are able to do all your activities",
    1: "You can continue your activities and you can focus for hours before having a break",
    2: "You can do activities that require a minimum effort without breaks, but you need them after a while",
    3: "Every hour you need a break of some minutes before continuing your activity, despite the effort",
    4: "You cannot focus and need to rest frequently to continue your activities",
    5: "You are not able to do your activities any more, your fatigue is too high"
]

struct FatigueLevelView: View {
    
    @EnvironmentObject var measure: Measure
    @State var isSet: Bool = false
    
    // Slide bar stuff
    let idleColor = Color("slide_bar_grey")
    let activeColor = Color("ocean")
    let slideBarSize = (UIScreen.main.bounds.width - 60)
    
    @State var fatigueLevel: Int = -1
    @State var fatigueDescription: String = "Press on the number that matches your fatigue level in this moment."
    
    
    // for override the back button
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var BackButtonView: some View {
        Button(action: { self.presentationMode.wrappedValue.dismiss() }) {
            Image("icon_close")
        }
        .padding(.horizontal, 5)
    }
    
    var FatigueSlider: some View {
        
        VStack (spacing: 0) {
            
            // Horizontal stack of the numbers
            HStack (spacing: 0) {
                
                ForEach (0...5, id: \.self) { i in
                    Group {
                        Text(String(i))
                            .fontWeight(.heavy)
                            .font(.custom("Rubik-Medium", size: fatigueLevel == i ? 26: 20, relativeTo: .headline))
                            .foregroundColor(fatigueLevel == i ? activeColor: idleColor)
                        if i != 5 {
                            Spacer()
                        }
                    }
                }
            }
            .padding(.bottom, 10)
            
            ZStack {
                
                // Horizontal stack of the lines between the circles
                HStack (spacing: 0) {
                    
                    ForEach (1...5, id: \.self) { i in
                        Rectangle()
                            .fill(fatigueLevel >= i ? activeColor: idleColor)
                            .frame(width: slideBarSize / 5, height: 3)
                    }
                }
                
                // Horizontal stack of the circles
                HStack (spacing: 0) {
                    
                    ForEach (0...5, id: \.self) { i in
                        Group {
                            Circle()
                                .fill(fatigueLevel >= i ? activeColor: idleColor)
                                .frame(
                                    width: fatigueLevel == i ? 13: 9,
                                    height: fatigueLevel == i ? 13: 9
                                )
                                .gesture(DragGesture(minimumDistance: 0).onChanged { _ in fatigueLevel = i
                                    
                                    // Set the actual fatigueLevel
                                    measure.fatigueLevel = fatigueLevel
                                })
                            if i != 5 {
                                Spacer()
                            }
                        }
                    }
                }
            }
            .frame(width: (UIScreen.main.bounds.width - 60), height: 15)
        }
        .padding(.bottom, 30)
    }
    
    func getTitle(fatigue: Int) -> String {
        return ""
    }
    
    var body: some View {
        
        VStack {
            
            // for white background & top padding
            HStack {
                Spacer()
            }.frame(height: 150)
            
            Text("My fatigue is...")
                .fontWeight(.heavy)
                .font(.custom("Rubik-Medium", size: 28.0, relativeTo: .headline))
                .foregroundColor(Color("dark"))
                .padding(.bottom, 50)
            FatigueSlider
            Text(fatigueTitles[fatigueLevel]!)
                .fontWeight(.heavy)
                .font(.custom("Rubik-Medium", size: 19.0, relativeTo: .headline))
                .foregroundColor(Color("dark"))
                .padding(.bottom, 1)
            Text(fatigueDescriptions[fatigueLevel]!)
                .fontWeight(.bold)
                .font(.custom("Rubik-Regular", size: 19.0, relativeTo: .body))
                .foregroundColor(Color("slate"))
                .multilineTextAlignment(.center)
            Spacer()
            if fatigueLevel != -1 {
                NavigationLink(
                    destination: TestFinishedView().environmentObject(measure),
                    label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 15.0, style: .continuous)
                                .fill(Color("slate"))
                                .frame(width: 210, height: 60)
                            Text("Confirm status")
                                .fontWeight(.heavy)
                                .font(.custom("Rubik-Medium", size: 20.0, relativeTo: .headline))
                                .foregroundColor(Color("white"))
                        }
                    })
            }
            Spacer()
        }
        .padding(.horizontal, 30)
        .background(Color("white"))
        .edgesIgnoringSafeArea(.top)
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(trailing: self.BackButtonView)
    }
}

struct FatigueLevelView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FatigueLevelView().environmentObject(Measure())
        }
    }
}
