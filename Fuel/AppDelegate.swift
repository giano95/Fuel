//
//  AppDelegate.swift
//  Fuel
//
//  Created by Marco Gianelli on 17/04/2021.
//

import UIKit
import Foundation
import Firebase
import GoogleSignIn
import FBSDKCoreKit


@main
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Firebase configuration APIs
        FirebaseApp.configure()
        
        // GoogleSignIn stuff: configuration
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        
        // Facebook login stuff: configuration
        ApplicationDelegate.shared.application(
            application,
            didFinishLaunchingWithOptions: launchOptions
        )
        
        return true
    }

    // GoogleSignIn stuff: this method will properly handle the URL that the app receives at the end of the authentication
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any]) -> Bool {
        
        // Facebook login stuff: configuration
        ApplicationDelegate.shared.application(
            application,
            open: url,
            sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
            annotation: options[UIApplication.OpenURLOptionsKey.annotation]
        )
        
        return GIDSignIn.sharedInstance().handle(url)
    }

    // GoogleSignIn stuff: this method will properly handle the URL that the app receives at the end of the authentication
    // For retrocompatibility iOS 8 and older
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return GIDSignIn.sharedInstance().handle(url)
    }

    // GoogleSignIn stuff: handle the sign-in process
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {

        if let error = error {
            // if ann error occur just print it and return
            print(error.localizedDescription)
            return
        }

        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        
        SessionStore.shared.signIn(credential: credential) { (result, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            // perform any operation on the user when signing in here
            print("google signed in correctly perform")
            
            let uid = String(result!.user.uid)
            let name = String(user.profile.name!)
            
            SessionStore.shared.user?.name = name
            
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

    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        print("Google user sign out")

        // perform any operation on the user when signing out here
    }
    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}
