//
//  PasswordResetView.swift
//  Fuel
//
//  Created by Marco Gianelli on 27/04/2021.
//

import SwiftUI
import Foundation

struct PasswordResetView: View {
    
    @State var error = ""
    @State var email = ""
    @State var success = false
    @EnvironmentObject var session: SessionStore
    
    func passwordReset() {
    
        session.sendPasswordResetEmail(email: email) { (error) in
            
            if let error = error {
                self.error = error.localizedDescription
            } else {
                self.success = true
                print("mail send successfully")
            }
        }
    }
    
    var body: some View {
        VStack {
            if !success {
                Image("illustration_password_01")
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width, height: 260, alignment: .top)
                    .clipped()
                    .padding(.bottom, 10)
                Text("Password reset")
                    .fontWeight(.black)
                    .font(.custom("Rubik-Medium", size: 32.0, relativeTo: .headline))
                    .foregroundColor(Color("dark"))
                    .padding(.bottom, 2)
                Text("Enter your email address to receive the password reset instructions.")
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.horizontal, 30)
                    .multilineTextAlignment(.center)
                    .font(.custom("Rubik-Regular", size: 19.0, relativeTo: .body))
                    .foregroundColor(Color("slate"))
                    .padding(.bottom, 20)
                TextField("Email", text: $email)
                    .padding()
                    .border(Color.black, width: 2)
                    .padding(.bottom, 10)
                    .padding(.horizontal, 20.0)
                Button(action: { passwordReset() }, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10.0, style: .continuous)
                            .fill(Color("slate"))
                            .frame(maxWidth: .infinity, maxHeight: 60)
                        Text("Send it")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .font(.custom("Rubik-Medium", size: 20.0, relativeTo: .headline))
                    }
                    .padding(.bottom, 40)
                    .padding(.horizontal, 20.0)
                })
                if error != "" {
                    Text(error)
                }
                Spacer()
            } else {
                Image("illustration_email_sent")
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width, height: 260, alignment: .top)
                    .clipped()
                    .padding(.bottom, 10)
                Text("Success!")
                    .fontWeight(.black)
                    .font(.custom("Rubik-Medium", size: 32.0, relativeTo: .headline))
                    .foregroundColor(Color("dark"))
                    .padding(.bottom, 2)
                Text("A link to reset your password was sent to your email address.")
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.horizontal, 30)
                    .multilineTextAlignment(.center)
                    .font(.custom("Rubik-Regular", size: 19.0, relativeTo: .body))
                    .foregroundColor(Color("slate"))
                    .padding(.bottom, 20)
                Spacer()
            }
            
        }
        .padding()
    }
}

struct PasswordResetView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PasswordResetView().environmentObject(SessionStore.shared)
        }

    }
}
