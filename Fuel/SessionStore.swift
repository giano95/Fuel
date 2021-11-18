//
//  SessionStore.swift
//  Fuel
//
//  Created by Marco Gianelli on 19/04/2021.
//

import SwiftUI
import Foundation
import Combine
import Firebase
import FBSDKLoginKit
import GoogleSignIn


class SessionStore: ObservableObject {
    
    static let shared = SessionStore()
    
    private init() {}
    
    var didChange = PassthroughSubject<SessionStore, Never>()
    var handle: AuthStateDidChangeListenerHandle?
    @Published var user: User? { didSet { self.didChange.send(self) }}
    
    // fb login stuff
    var manager = LoginManager()
    
    func listen () {
        handle = Auth.auth().addStateDidChangeListener({ (auth, user) in
            if let user = user {
                self.user = User(uid: user.uid, email: user.email, name: user.displayName)
            } else {
                self.user = nil
            }
        })
    }
    
    func setUpGID() {
        GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.shared.windows.first?.rootViewController
    }
    
    func signUp(email: String, password: String, completion: @escaping AuthDataResultCallback) {
        Auth.auth().createUser(withEmail: email, password: password, completion: completion)
    }
    
    func googleSignUp() {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    func facebookSignUp() {
        
        manager.logIn(permissions: ["public_profile", "email"], from: nil) {
            (result, error) in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            // checking if user press "cancel"
            if !result!.isCancelled {
                
                if AccessToken.current != nil {
                    
                    let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
                    Auth.auth().signIn(with: credential) {
                        (result ,  error) in
                        
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
    
    func signIn(email: String, password: String, completion: @escaping AuthDataResultCallback) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    func signIn(credential: AuthCredential, completion: @escaping AuthDataResultCallback) {
        Auth.auth().signIn(with: credential, completion: completion)
    }
    
    func googleSignIn() {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    func facebookSignIn() {
        
        manager.logIn(permissions: ["public_profile", "email"], from: nil) {
            (result, error) in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            // checking if user press "cancel"
            if !result!.isCancelled {
                
                if AccessToken.current != nil {
                    
                    let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
                    Auth.auth().signIn(with: credential) {
                        (result ,  error) in
                        
                        if let error = error {
                            print(error.localizedDescription)
                            return
                        }

                        print("FB auth SUCCES! ")
                    }
                }
            }
        }
    }
    
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.user = nil
        } catch let signOutError as NSError {
            print(signOutError)
        }
    }
    
    func sendPasswordResetEmail(email: String, completion: @escaping SendPasswordResetCallback) {
        Auth.auth().sendPasswordReset(withEmail: email, completion: completion)
    }
    
    func unbind() {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
    deinit {
        unbind()
    }
    
}

struct User {
    var uid: String
    var email: String?
    var name: String?
    
    init(uid: String, email: String?, name: String? = nil) {
        self.uid = uid
        self.email = email
        self.name = name
    }
}
