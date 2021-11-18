//
//  SignInView.swift
//  Fuel
//
//  Created by Marco Gianelli on 07/05/2021.
//

import SwiftUI
import SwiftUIKitView
import Foundation
import Firebase


struct SignInView: View {
    
    @State var email = ""
    @State var password = ""
    @State var error = ""
    @EnvironmentObject var session: SessionStore
    
    
    func signIn() {
        session.signIn(email: email, password: password) {
            (result, error) in
            if let error = error {
                self.error = error.localizedDescription
            } else {
                print("user authenticated successfully")
            }
        }
    }
    
    var body: some View {
        VStack {
            Text("Welcome Back!")
                .fontWeight(.black)
                .font(.custom("Rubik-Medium", size: 30.0, relativeTo: .headline))
                .foregroundColor(Color("dark"))
                .padding(.bottom, 10)
            TextField("Email", text: $email)
                .padding()
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 2)
                .padding(.bottom, 10)
            SecureField("Password", text: $password)
                .padding()
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 2)
                .padding(.bottom, 10)
            Button(action: { signIn() }, label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10.0, style: .continuous)
                        .fill(Color("slate"))
                        .frame(maxWidth: .infinity, maxHeight: 60)
                    Text("Sign in")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .font(.custom("Rubik-Medium", size: 20.0, relativeTo: .headline))
                }
                .padding(.bottom, 20)
            })
            
            if error != "" {
                Text(error)
            }

            NavigationLink(destination: PasswordResetView()) {
                Text("Forgot your password?")
                    .font(.custom("Rubik-Regular", size: 18.0, relativeTo: .body))
                    .foregroundColor(Color("dark"))
                    .underline()
                    .padding(.bottom, 30)
            }
            Text("- or sign in with -")
                .font(.custom("Rubik-Regular", size: 20.0, relativeTo: .body))
                .foregroundColor(Color("slate"))
                .padding(.bottom, 30)
            HStack {
                Button(action: { session.googleSignIn() }, label: {
                    ZStack {
                        Image("bkg_google")
                        Image("icon_google")
                    }
                })
                .padding(.horizontal, 10)
                Button(action: { session.facebookSignIn() }, label: {
                    ZStack {
                        Image("bkg_facebook")
                        Image("icon_facebook")
                    }
                })
                .padding(.horizontal, 10)
            }
            Spacer()
        }
        .onAppear(perform: { session.setUpGID() })
        .padding()
    }
}


struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SignInView().environmentObject(SessionStore.shared)
        }
    }
}
