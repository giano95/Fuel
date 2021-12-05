//
//  SignUpView.swift
//  Fuel
//
//  Created by Marco Gianelli on 07/05/2021.
//

import SwiftUI
import SwiftUIKitView
import Foundation
import Firebase


struct SignUpView: View {
    
    @State var name = ""
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
    
    func signUp() {
        session.signUp(email: email, password: password) {
            (result, error) in
            if let error = error {
                self.error = error.localizedDescription
            } else {
                print("user created successfully")
                
                session.user?.name = name
                
                let uid = String(result!.user.uid)
                
                // Save the user data accordingly to the database tree
                Database.database(url: "https://fuel-d0b5e-default-rtdb.europe-west1.firebasedatabase.app").reference()
                    .child("users")
                    .child(uid)
                    .setValue(["name": name])
            }
        }
    }
   
    
    var body: some View {
        
        VStack {
            
            // top padding
            HStack {
                Spacer()
            }.frame( height: 100)
            
            Text("Thank you for your help!")
                .fontWeight(.black)
                .font(.custom("Rubik-Medium", size: 30.0, relativeTo: .headline))
                .foregroundColor(Color("dark"))
                .padding(.bottom, 12)
            TextField("", text: $name)
                .placeholder(when: name.isEmpty) {
                    Text("Name").foregroundColor(Color("lighter_slate"))
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("slate"), lineWidth: 3)
                )
                .padding(.bottom, 12)
                .foregroundColor(Color("dark"))
            TextField("", text: $email)
                .placeholder(when: name.isEmpty) {
                    Text("Email").foregroundColor(Color("lighter_slate"))
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("slate"), lineWidth: 3)
                )
                .padding(.bottom, 12)
                .foregroundColor(Color("dark"))
            SecureField("", text: $password)
                .placeholder(when: name.isEmpty) {
                    Text("Password").foregroundColor(Color("lighter_slate"))
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("slate"), lineWidth: 3)
                )
                .padding(.bottom, 12)
                .foregroundColor(Color("dark"))
            Button(action: { signUp() }, label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10.0, style: .continuous)
                        .fill(Color("slate"))
                        .frame(width: .infinity, height: 60)
                    Text("Sign up")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .font(.custom("Rubik-Medium", size: 20.0, relativeTo: .headline))
                }
                .padding(.bottom, 40)
            })
            if error != "" {
                Text(error)
                .fontWeight(.black)
                .font(.custom("Rubik-Medium", size: 20.0, relativeTo: .headline))
                .foregroundColor(Color("red_error"))
            }
            Text("- or sign up with -")
                .font(.custom("Rubik-Regular", size: 20.0, relativeTo: .body))
                .foregroundColor(Color("slate"))
                .padding(.bottom, 30)
            HStack {
                Spacer()
                Button(action: { session.googleSignUp() }, label: {
                    ZStack {
                        Image("bkg_google")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 95, height: 95)
                            .clipped()
                        Image("icon_google")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 40)
                            .clipped()
                    }
                })
                .padding(.horizontal, 12)
                Button(action: { session.facebookSignUp() }, label: {
                    ZStack {
                        Image("bkg_facebook")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 95, height: 95)
                            .clipped()
                        Image("icon_facebook")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 40)
                            .clipped()
                    }
                })
                .padding(.horizontal, 12)
                Spacer()
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

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SignUpView().environmentObject(SessionStore.shared)
        }
    }
}
