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
    
    var ref: DatabaseReference!
    
    private init() {
        ref = Database.database(url: "https://fuel-d0b5e-default-rtdb.europe-west1.firebasedatabase.app").reference()
    }
    
    var didChange = PassthroughSubject<SessionStore, Never>()
    var handle: AuthStateDidChangeListenerHandle?
    @Published var user: User? { didSet { self.didChange.send(self) }}
    
    // fb login stuff
    var manager = LoginManager()
    
    func listen () {
        handle = Auth.auth().addStateDidChangeListener({ (auth, user) in
            if let user = user {
                
                self.user = User(uid: user.uid, email: user.email)
                
                self.ref.child("users").child(user.uid).observeSingleEvent(of: .value, with: { (snapshot) in
                    
                    let value = snapshot.value as? NSDictionary
                    
                    // Check if the User have the parameters on the DB
                    if value?["name"] != nil {
                        self.user?.name = value?["name"] as? String
                    }
                    if value?["sex"] != nil {
                        self.user?.toggleRegistred()    // If the user have this par then is registred
                        self.user?.sex = value?["sex"] as? String
                    }
                    if value?["age"] != nil {
                        self.user?.age = value?["age"] as? Int
                    }
                    if value?["weight"] != nil {
                        self.user?.weight = value?["weight"] as? Float
                    }
                    if value?["height"] != nil {
                        self.user?.height = value?["height"] as? Float
                    }
                    if value?["patientType"] != nil {
                        self.user?.patientType = value?["patientType"] as? String
                    }
                    
                })
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
                        
                        // Save the user data accordingly to the database tree
                        Database.database(url: "https://fuel-d0b5e-default-rtdb.europe-west1.firebasedatabase.app").reference()
                            .child("users")
                            .child(uid)
                            .setValue(["name": name])
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
    
    var isRegistred: Bool
    
    // From the SignUp View
    var uid: String
    var email: String?
    var name: String?
    // From the registration View
    var sex: String?
    var age: Int?
    var weight: Float?
    var height: Float?
    var patientType: String?
    
    init(uid: String, email: String?) {
        self.uid = uid
        self.email = email
        self.isRegistred = false
    }
    init(uid: String, email: String?, name: String?) {
        self.uid = uid
        self.email = email
        self.name = name
        self.isRegistred = false
    }
    init(uid: String, email: String?, name: String?, sex: String?, age: Int?, weight: Float?, height: Float?, patientType: String?) {
        self.uid = uid
        self.email = email
        self.name = name
        self.sex = sex
        self.age = age
        self.weight = weight
        self.height = height
        self.patientType = patientType
        self.isRegistred = true
    }
    
    mutating func toggleRegistred() {self.isRegistred = !self.isRegistred}
}
