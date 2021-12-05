//
//  WelcomeView.swift
//  Fuel
//
//  Created by Marco Gianelli on 17/04/2021.
//


import SwiftUI
import Foundation
import Firebase


struct HomeView: View {
    
    @State var label = ""
    @State var authenticated: Bool = false
    @EnvironmentObject var session: SessionStore
    
    func getUser() {
        session.listen()
    }
    
    var body: some View {
        
        NavigationView {
            
            Group {
                
                // User fully authenticathed
                if session.user != nil && Auth.auth().currentUser != nil && session.user?.isRegistred == true {
                
                    if let user = session.user {

                        VStack(alignment: .leading) {
                            
                            // left alignment
                            HStack {
                                Spacer()
                            }.frame(height: 100)
                            
                            // content
                            Text("Hello,")
                                .fontWeight(.heavy)
                                .font(.custom("Rubik-Medium", size: 34.0, relativeTo: .headline))
                                .foregroundColor(Color("dark"))
                            Text(user.name ?? "name" + "!")
                                .font(.custom("Rubik-Medium", size: 34.0, relativeTo: .headline))
                                .fontWeight(.heavy)
                                .foregroundColor(Color("dark"))
                            Text("Select what you want to do")
                                .font(.custom("Rubik-Regular", size: 21.0, relativeTo: .body))
                                .foregroundColor(Color("slate"))
                                .padding(.bottom, 20)
                            let columns = [
                                GridItem(.flexible()),
                                GridItem(.flexible()),
                            ]
                            LazyVGrid(columns: columns, spacing: 20) {
                                
                                // Test Button
                                NavigationLink(destination: TestView()) {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 13.0, style: .continuous)
                                            .fill(Color("light_blue_grey"))
                                            .frame(width: .infinity, height: 120)
                                        VStack(alignment: .leading) {
                                            HStack {
                                                Spacer()
                                            }.frame(height: 10)
                                            ZStack {
                                                RoundedRectangle(cornerRadius: 15.0, style: .continuous)
                                                    .fill(Color("pale_grey"))
                                                    .frame(width: 40, height: 40)
                                                Image("icon_fuel_alert_unselected")
                                            }
                                            Spacer()
                                            Text("Take the test")
                                                .font(.custom("Rubik-Medium", size: 20.0, relativeTo: .headline))
                                                .fontWeight(.heavy)
                                                .foregroundColor(Color("light_dark"))
                                                .padding(.bottom, 15)
                                        }
                                        .padding(.horizontal, 15)
                                    }
                                }
                                
                                // Record Button
                                ZStack {
                                    RoundedRectangle(cornerRadius: 15.0, style: .continuous)
                                        .fill(Color("light_blue_grey"))
                                        .frame(width: .infinity, height: 120)
                                    VStack(alignment: .leading) {
                                        HStack {
                                            Spacer()
                                        }.frame(height: 10)
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 13.0, style: .continuous)
                                                .fill(Color("pale_grey"))
                                                .frame(width: 40, height: 40)
                                            Image(systemName: "plus.app")
                                                .font(.system(size: 27, weight: .regular))
                                                .foregroundColor(Color("ocean"))
                                        }
                                        Spacer()
                                        Text("Record Fatigue")
                                            .font(.custom("Rubik-Medium", size: 20.0, relativeTo: .headline))
                                            .fontWeight(.heavy)
                                            .foregroundColor(Color("light_dark"))
                                            .padding(.bottom, 15)
                                    }
                                    .padding(.horizontal, 15)
                                }
                                
                                // How To Button
                                NavigationLink(destination: HowToView()) {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 15.0, style: .continuous)
                                            .fill(Color("light_blue_grey"))
                                            .frame(width: .infinity, height: 120)
                                        VStack(alignment: .leading) {
                                            HStack {
                                                Spacer()
                                            }.frame(height: 10)
                                            ZStack {
                                                RoundedRectangle(cornerRadius: 13.0, style: .continuous)
                                                    .fill(Color("pale_grey"))
                                                    .frame(width: 40, height: 40)
                                                Image(systemName: "info.circle")
                                                    .font(.system(size: 27, weight: .regular))
                                                    .foregroundColor(Color("ocean"))
                                            }
                                            Spacer()
                                            Text("Test how-to")
                                                .font(.custom("Rubik-Medium", size: 20.0, relativeTo: .headline))
                                                .fontWeight(.heavy)
                                                .foregroundColor(Color("light_dark"))
                                                .padding(.bottom, 15)
                                        }
                                        .padding(.horizontal, 15)
                                    }
                                }
                                
                                // Settings Button
                                NavigationLink(destination: SettingsView()) {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 15.0, style: .continuous)
                                            .fill(Color("light_blue_grey"))
                                            .frame(width: .infinity, height: 120)
                                        VStack(alignment: .leading) {
                                            HStack {
                                                Spacer()
                                            }.frame(height: 10)
                                            ZStack {
                                                RoundedRectangle(cornerRadius: 13.0, style: .continuous)
                                                    .fill(Color("pale_grey"))
                                                    .frame(width: 40, height: 40)
                                                Image(systemName: "gearshape")
                                                    .font(.system(size: 27, weight: .regular))
                                                    .foregroundColor(Color("ocean"))
                                            }
                                            Spacer()
                                            Text("Settings")
                                                .font(.custom("Rubik-Medium", size: 20.0, relativeTo: .headline))
                                                .fontWeight(.heavy)
                                                .foregroundColor(Color("light_dark"))
                                                .padding(.bottom, 15)
                                        }
                                        .padding(.horizontal, 15)
                                    }
                                }
                            }
                                
                            Spacer()
                        }
                        .padding()
                        .padding(.horizontal, 20)
                        .background(Color("pale_grey"))
                        .edgesIgnoringSafeArea(.top)
                        .edgesIgnoringSafeArea(.bottom)
                    }
                    
                // User authenticated but not registred
                } else if session.user != nil && Auth.auth().currentUser != nil && session.user?.isRegistred == false {
                    RegistrationView().environmentObject(SessionStore.shared)
                // User not autheticated at all
                } else {
                    AuthView().environmentObject(SessionStore.shared)
                }
            }
        }
        .onAppear(perform: getUser)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(SessionStore.shared)
    }
}
