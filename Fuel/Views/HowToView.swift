//
//  HowToView.swift
//  Fuel
//
//  Created by Marco Gianelli on 11/05/2021.
//

import SwiftUI



struct HowToView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var backButton: some View {
        Button(action: { self.presentationMode.wrappedValue.dismiss() }) {
            Image("icon_close")
        }
    }
    
    var body: some View {
        
        VStack {
            GeometryReader { geometry in
                ImageCarouselView(
                    numberOfImages: 4,
                    titles: [
                        "How does the Fuel test work?",
                        "How does the Fuel test work?",
           	             "How does the Fuel test work?",
                        "How does the Fuel test work?"
                    ],
                    descriptions: [
                        "It’s easy! First, a green square will appear on the screen. You have to press your finger in the center of this square.",
                        "When the square turns into a circle, you have to take your finger off the screen as fast as possible! Easy-peasy ;)",
                        "We will then ask you to tell us what you were doing by just selecting an option we already provide to you.",
                        "Finally, we will ask you to tell us how tired you are feeling, by again just selecting one of the options we provide to you."
                    ],
                    images: {
                        Utils.wrapImage(name: "illustration_how_to_01", geometry: geometry)
                        Utils.wrapImage(name: "illustration_how_to_02", geometry: geometry)
                        Utils.wrapImage(name: "illustration_how_to_03", geometry: geometry)
                        Utils.wrapImage(name: "illustration_how_to_04", geometry: geometry)
                    }
                )
            }
            .frame(width: UIScreen.main.bounds.width, height: 280, alignment: .top)
            .padding(.top, 100)
            Spacer()
        }
        .edgesIgnoringSafeArea(.top)
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(trailing: self.backButton)
    }
}

struct HowToView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HowToView()
        }
    }
}
