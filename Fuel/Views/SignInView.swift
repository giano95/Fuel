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
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var backButton: some View {
        Button(action: { self.presentationMode.wrappedValue.dismiss() }) {
            Image("icon_arrow_backward")
        }
    }
    
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
            
            // top padding
            HStack {
                Spacer()
            }.frame(height: 100)
            
            Text("Welcome Back!")
                .fontWeight(.black)
                .font(.custom("Rubik-Medium", size: 30.0, relativeTo: .headline))
                .foregroundColor(Color("dark"))
                .padding(.bottom, 10)
            TextField("Email", text: $email)
                .placeholder(when: email.isEmpty) {
                    Text("Email").foregroundColor(Color("lighter_slate"))
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("slate"), lineWidth: 3)
                )
                .padding(.bottom, 10)
                .foregroundColor(Color("dark"))
            SecureField("Password", text: $password)
                .placeholder(when: password.isEmpty) {
                    Text("Password").foregroundColor(Color("lighter_slate"))
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("slate"), lineWidth: 3)
                )
                .padding(.bottom, 10)
                .foregroundColor(Color("dark"))
            Button(action: { signIn() }, label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10.0, style: .continuous)
                        .fill(Color("slate"))
                        .frame(width: .infinity, height: 60)
                    Text("Sign in")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .font(.custom("Rubik-Medium", size: 20.0, relativeTo: .headline))
                }
                .padding(.bottom, 20)
            })
            
            if error != "" {
                Text(error)
                .fontWeight(.black)
                .font(.custom("Rubik-Medium", size: 20.0, relativeTo: .headline))
                .foregroundColor(Color("red_error"))
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
        .background(Color("white"))
        .edgesIgnoringSafeArea(.bottom)
        .edgesIgnoringSafeArea(.top)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: self.backButton)
    }
}


struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SignInView().environmentObject(SessionStore.shared)
        }
    }
}
