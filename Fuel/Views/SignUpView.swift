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
    
    func signUp() {
        session.signUp(email: email, password: password) {
            (result, error) in
            if let error = error {
                self.error = error.localizedDescription
            } else {
                print("user created successfully")
                
                session.user?.name = name
                
                let uid = String(result!.user.uid)
                
//                Firestore.firestore()
//                    .collection("users")
//                    .document(uid)
//                    .setData([
//                        "id": uid,
//                        "name": name
//                    ]) { (error) in
//                    if let error = error {
//                        print("an error occur while saving the user database info")
//                        print(error.localizedDescription)
//                    }
//                }
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
            Text("Thank you for your help!")
                .fontWeight(.black)
                .font(.custom("Rubik-Medium", size: 30.0, relativeTo: .headline))
                .foregroundColor(Color("dark"))
                .padding(.bottom, 10)
            TextField("Name", text: $name)
                .padding()
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 2)
                .padding(.bottom, 10)
            TextField("Email", text: $email)
                .padding()
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 2)
                .padding(.bottom, 10)
            SecureField("Password", text: $password)
                .padding()
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 2)
                .padding(.bottom, 10)
            Button(action: { signUp() }, label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10.0, style: .continuous)
                        .fill(Color("slate"))
                        .frame(maxWidth: .infinity, maxHeight: 60)
                    Text("Sign up")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .font(.custom("Rubik-Medium", size: 20.0, relativeTo: .headline))
                }
                .padding(.bottom, 40)
            })
            if error != "" {
                Text(error)
            }
            Text("- or sign up with -")
                .font(.custom("Rubik-Regular", size: 20.0, relativeTo: .body))
                .foregroundColor(Color("slate"))
                .padding(.bottom, 30)
            HStack {
                Button(action: { session.googleSignUp() }, label: {
                    ZStack {
                        Image("bkg_google")
                        Image("icon_google")
                    }
                })
                .padding(.horizontal, 10)
                Button(action: { session.facebookSignUp() }, label: {
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

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SignUpView().environmentObject(SessionStore.shared)
        }
    }
}
