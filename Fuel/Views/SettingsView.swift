//
//  SettingsView.swift
//  Fuel
//
//  Created by Marco Gianelli on 04/08/2021.
//

import SwiftUI


struct SettingsView: View {
    
    @EnvironmentObject var session: SessionStore
    
    func logOut() {
        session.signOut()
    }
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                VStack {
                    // Title
                    HStack {
                        Text("Settings")
                            .fontWeight(.heavy)
                            .font(.custom("Rubik-Medium", size: 32.0, relativeTo: .headline))
                            .foregroundColor(Color("dark"))
                            .padding(.top, 100)
                            .padding(.bottom, 25)
                        Spacer()
                    }
                    // Profile
                    NavigationLink(destination: TestView()) {
                        VStack {
                            HStack {
                                Text("Profile")
                                    .fontWeight(.heavy)
                                    .font(.custom("Rubik-Medium", size: 20.0, relativeTo: .headline))
                                    .foregroundColor(Color("slate"))
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(Color("light_dark"))
                            }
                            .padding(.horizontal, 6)
                            .padding(.vertical, 8)
                            Rectangle()
                                .fill(Color("light_grey"))
                                .frame(width: .infinity, height: 2)
                        }
                    }
                    // Account
                    NavigationLink(destination: TestView()) {
                        VStack {
                            HStack {
                                Text("Account")
                                    .fontWeight(.heavy)
                                    .font(.custom("Rubik-Medium", size: 20.0, relativeTo: .headline))
                                    .foregroundColor(Color("slate"))
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(Color("light_dark"))
                            }
                            .padding(.horizontal, 6)
                            .padding(.vertical, 8)
                            Rectangle()
                                .fill(Color("light_grey"))
                                .frame(width: .infinity, height: 2)
                        }
                    }
                    // Notifications
                    NavigationLink(destination: TestView()) {
                        VStack {
                            HStack {
                                Text("Notifications")
                                    .fontWeight(.heavy)
                                    .font(.custom("Rubik-Medium", size: 20.0, relativeTo: .headline))
                                    .foregroundColor(Color("slate"))
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(Color("light_dark"))
                            }
                            .padding(.horizontal, 6)
                            .padding(.vertical, 8)
                            Rectangle()
                                .fill(Color("light_grey"))
                                .frame(width: .infinity, height: 2)
                        }
                    }
                    // App & Devices
                    NavigationLink(destination: TestView()) {
                        VStack {
                            HStack {
                                Text("App & Devices")
                                    .fontWeight(.heavy)
                                    .font(.custom("Rubik-Medium", size: 20.0, relativeTo: .headline))
                                    .foregroundColor(Color("slate"))
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(Color("light_dark"))
                            }
                            .padding(.horizontal, 6)
                            .padding(.vertical, 8)
                            Rectangle()
                                .fill(Color("light_grey"))
                                .frame(width: .infinity, height: 2)
                        }
                    }
                    // Send us notifications
                    NavigationLink(destination: TestView()) {
                        VStack {
                            HStack {
                                Text("Notifications")
                                    .fontWeight(.heavy)
                                    .font(.custom("Rubik-Medium", size: 20.0, relativeTo: .headline))
                                    .foregroundColor(Color("slate"))
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(Color("light_dark"))
                            }
                            .padding(.horizontal, 6)
                            .padding(.vertical, 8)
                            Rectangle()
                                .fill(Color("light_grey"))
                                .frame(width: .infinity, height: 2)
                        }
                    }
                }
                .padding(.horizontal, 20)
                Spacer()
                // Bottom NavBar
                ZStack {
                    Rectangle()
                        .fill(Color("light_grey"))
                        .frame(width: .infinity, height: 2)
                        .padding(.bottom, 60)
                    HStack(alignment: .top) {
                        Spacer()
                        
                        // How to
                        NavigationLink(destination: HowToView()) {
                            VStack {
                                Spacer()
                                Image("icon_how_to_unselected")
                                Text("How to")
                                    .fontWeight(.heavy)
                                    .font(.custom("Rubik-Regular", size: 16.0, relativeTo: .headline))
                                    .foregroundColor(Color("black_40"))
                                    .padding(.bottom, 20)
                            }.frame(width: 70, height: 130)
                        }
                        Spacer()
                        
                        // Take Test
                        NavigationLink(destination: RegistrationView()) {
                            VStack {
                                Spacer()
                                Image("icon_test_unselected")
                                Text("Take Test")
                                    .fontWeight(.heavy)
                                    .font(.custom("Rubik-Regular", size: 16.0, relativeTo: .headline))
                                    .foregroundColor(Color("black_40"))
                                    .padding(.bottom, 20)
                            }.frame(width: 70, height: 130)
                        }
                        Spacer()
                        
                        // Settings (dumb button)
                        VStack {
                            Spacer()
                            Image("icon_settings_selected")
                            Text("Settings")
                                .fontWeight(.heavy)
                                .font(.custom("Rubik-Regular", size: 16.0, relativeTo: .headline))
                                .foregroundColor(Color("black_40"))
                                .padding(.bottom, 20)
                        }.frame(width: 70, height: 130)
                        .onTapGesture {
                            logOut() 
                        }
                        Spacer()
                        
                        // How to
                        VStack {
                            Image("fab_enabled")
                            Spacer()
                        }.frame(width: 70, height: 130)
                        Spacer()
                    }
                }
                
            }
            .background(Color("white"))
            .edgesIgnoringSafeArea(.top)
            .edgesIgnoringSafeArea(.bottom)
        }.navigationBarBackButtonHidden(true)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingsView()
        }
    }
}
