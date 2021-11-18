//
//  FBLoginViewController.swift
//  Fuel
//
//  Created by Marco Gianelli on 22/04/2021.
//

import SwiftUI
import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import Firebase


struct LoginView : UIViewRepresentable {
    func makeCoordinator() -> LoginView.Coordinator {
        return LoginView.Coordinator()
    }

    func makeUIView(context: UIViewRepresentableContext<LoginView>) -> FBLoginButton {
        let button = FBLoginButton()
        button.permissions = ["email", "public_profile"]
        button.delegate = context.coordinator
        return button
    }

    func updateUIView(_ uiView: FBLoginButton, context: UIViewRepresentableContext<LoginView>) {
        
    }

    class Coordinator : NSObject, ObservableObject, LoginButtonDelegate{

        func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
            try! Auth.auth().signOut()
            print("Did logout")
        }

        func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {

            if error != nil  {
                print((error?.localizedDescription)!)
                return
            }
            
            if AccessToken.current != nil {
                
                
                let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
                Auth.auth().signIn(with: credential) {(result ,  error) in

                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }

                    print("FB auth SUCCES! ")
                    
                    let uid = String(result!.user.uid)
                    let name = String(result!.user.displayName ?? "missing__name")
                    
                    Firestore.firestore().collection("users").document(uid).setData([
                        "id": uid,
                        "name": name
                    ], merge: true) { (error) in
                        if let error = error {
                            print("an error occur while saving the user database info")
                            print(error.localizedDescription)
                        }
                    }
                }
            }
        }
    }
}

