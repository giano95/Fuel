//
//  SignInView.swift
//  Fuel
//
//  Created by Marco Gianelli on 19/04/2021.
//

import SwiftUI
import SwiftUIKitView
import Foundation
import Firebase
import GoogleSignIn
import FBSDKLoginKit



struct AuthView: View {
    
    var body: some View {
        
        VStack {
            GeometryReader { geometry in
                ImageCarouselView(
                    numberOfImages: 5,
                    titles: [
                        "Welcome to Fuel!",
                        "Welcome to Fuel!",
                        "Welcome to Fuel!",
                        "Welcome to Fuel!",
                        "Welcome to Fuel!"
                    ],
                    descriptions: [
                        "An app designed to help multiple sclerosis and oncology patients beat fatigue!",
                        "But for this to come true, we first need to gather information on how tiredness works.",
                        "This is were you come in! Three times a day, we will ask for you to perform a 3 minutes test.",
                        "While you do the test, we will also measure your eye-blinking rate with your phone's camera.",
                        "Donate 15 minutes of your time per day for 10 days and help thousands of patients!"
                    ],
                    images: {
                        Utils.wrapImage(name: "illustration_demo_01", geometry: geometry)
                        Utils.wrapImage(name: "illustration_demo_02", geometry: geometry)
                        Utils.wrapImage(name: "illustration_demo_03", geometry: geometry)
                        Utils.wrapImage(name: "illustration_demo_04", geometry: geometry)
                        Utils.wrapImage(name: "illustration_demo_05", geometry: geometry)
                    }
                )
            }
            .frame(width: UIScreen.main.bounds.width, height: 280, alignment: .top)
            Spacer()
            NavigationLink(destination: SignUpView().environmentObject(SessionStore.shared)) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10.0, style: .continuous)
                        .fill(Color("slate"))
                        .frame(maxWidth: 200, maxHeight: 60)
                    Text("Get Started")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .font(.custom("Rubik-Medium", size: 20.0, relativeTo: .headline))
                }
            }
            .padding(.bottom, 10)
            HStack {
                Text("Already have an account?")
                    .font(.custom("Rubik-Regular", size: 18.0, relativeTo: .body))
                    .foregroundColor(Color("slate"))
                NavigationLink(destination: SignInView().environmentObject(SessionStore.shared)) {
                    Text("Log in")
                        .font(.custom("Rubik-Regular", size: 18.0, relativeTo: .body))
                        .foregroundColor(Color("dark"))
                        .underline()
                }
            }
            .padding(.bottom, 80)
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AuthView().environmentObject(SessionStore.shared)
        }
    }
}
