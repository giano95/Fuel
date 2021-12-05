//
//  ActivityView.swift
//  Fuel
//
//  Created by Marco Gianelli on 20/05/2021.
//

import SwiftUI


struct ActivityView: View {
    
    
    @EnvironmentObject var measure: Measure
    @State var isSet: Bool = false
    
    
    // for override the back button
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var BackButtonView: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Image("icon_close")
        }
        .padding(.horizontal, 5)
    }
    
    private func setActivity(activity: String) {
        measure.activity = activity
        self.isSet = true
    }
    
    var body: some View {
        
        VStack() {
            
            // for white background
            HStack {
                Spacer()
            }.frame(height: 1)
            
            Spacer()
            
            Text("I've just been...")
                .fontWeight(.heavy)
                .font(.custom("Rubik-Medium", size: 32.0, relativeTo: .headline))
                .foregroundColor(Color("dark"))
                .padding(.bottom, 20)
            
            // It means that the rows of the grid have 2 elements
            let columns = [
                GridItem(.flexible()),
                GridItem(.flexible()),
            ]
            
            // The actual grid
            LazyVGrid(columns: columns, spacing: 15) {
                
                // Resting Button
                Button(action: { setActivity(activity: "resting") }, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15.0, style: .continuous)
                            .stroke(Color("light_grey"), lineWidth: 3)
                            .frame(width: .infinity, height: 120)
                        VStack() {
                            ZStack {
                                RoundedRectangle(cornerRadius: 13.0, style: .continuous)
                                    .fill(Color("pale_grey"))
                                    .frame(width: 45, height: 45)
                                Image(systemName: "bed.double")
                                    .font(.system(size: 24, weight: .regular))
                                    .foregroundColor(Color("ocean"))
                            }
                            Spacer()
                            Text("Resting")
                                .font(.custom("Rubik-Medium", size: 21.0, relativeTo: .headline))
                                .fontWeight(.heavy)
                                .foregroundColor(Color("slate"))
                        }
                        .padding(.horizontal, 15)
                        .padding(.vertical, 17)
                    }
                    .padding(.trailing, 4)
                })
                
                // Exercising Button
                Button(action: { setActivity(activity: "exercise") }, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15.0, style: .continuous)
                            .stroke(Color("light_grey"), lineWidth: 3)
                            .frame(width: .infinity, height: 120)
                        VStack() {
                            ZStack {
                                RoundedRectangle(cornerRadius: 13.0, style: .continuous)
                                    .fill(Color("pale_grey"))
                                    .frame(width: 45, height: 45)
                                Image(systemName: "figure.wave")
                                    .font(.system(size: 24, weight: .regular))
                                    .foregroundColor(Color("ocean"))
                            }
                            Spacer()
                            Text("Exercising")
                                .font(.custom("Rubik-Medium", size: 21.0, relativeTo: .headline))
                                .fontWeight(.heavy)
                                .foregroundColor(Color("slate"))
                        }
                        .padding(.horizontal, 15)
                        .padding(.vertical, 17)
                    }
                    .padding(.leading, 4)
                })
                
                // On a screen Button
                Button(action: { setActivity(activity: "screen") }, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15.0, style: .continuous)
                            .stroke(Color("light_grey"), lineWidth: 3)
                            .frame(width: .infinity, height: 120)
                        VStack() {
                            ZStack {
                                RoundedRectangle(cornerRadius: 13.0, style: .continuous)
                                    .fill(Color("pale_grey"))
                                    .frame(width: 45, height: 45)
                                Image(systemName: "display")
                                    .font(.system(size: 24, weight: .regular))
                                    .foregroundColor(Color("ocean"))
                            }
                            Spacer()
                            Text("On a screen")
                                .font(.custom("Rubik-Medium", size: 21.0, relativeTo: .headline))
                                .fontWeight(.heavy)
                                .foregroundColor(Color("slate"))
                        }
                        .padding(.horizontal, 15)
                        .padding(.vertical, 17)
                    }
                    .padding(.trailing, 4)
                })
                
                // Walking Button
                Button(action: { setActivity(activity: "walking") }, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15.0, style: .continuous)
                            .stroke(Color("light_grey"), lineWidth: 3)
                            .frame(width: .infinity, height: 120)
                        VStack() {
                            ZStack {
                                RoundedRectangle(cornerRadius: 13.0, style: .continuous)
                                    .fill(Color("pale_grey"))
                                    .frame(width: 45, height: 45)
                                Image(systemName: "figure.walk")
                                    .font(.system(size: 24, weight: .regular))
                                    .foregroundColor(Color("ocean"))
                            }
                            Spacer()
                            Text("Walking")
                                .font(.custom("Rubik-Medium", size: 21.0, relativeTo: .headline))
                                .fontWeight(.heavy)
                                .foregroundColor(Color("slate"))
                        }
                        .padding(.horizontal, 15)
                        .padding(.vertical, 17)
                    }
                    .padding(.leading, 4)
                })
                
                // Eating Button
                Button(action: { setActivity(activity: "eating") }, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15.0, style: .continuous)
                            .stroke(Color("light_grey"), lineWidth: 3)
                            .frame(width: .infinity, height: 120)
                        VStack() {
                            ZStack {
                                RoundedRectangle(cornerRadius: 13.0, style: .continuous)
                                    .fill(Color("pale_grey"))
                                    .frame(width: 45, height: 45)
                                Image(systemName: "house")
                                    .font(.system(size: 24, weight: .regular))
                                    .foregroundColor(Color("ocean"))
                            }
                            Spacer()
                            Text("Eating")
                                .font(.custom("Rubik-Medium", size: 21.0, relativeTo: .headline))
                                .fontWeight(.heavy)
                                .foregroundColor(Color("slate"))
                        }
                        .padding(.horizontal, 15)
                        .padding(.vertical, 17)
                    }
                    .padding(.trailing, 4)
                })
                
                // Other Button
                Button(action: { setActivity(activity: "other") }, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15.0, style: .continuous)
                            .stroke(Color("light_grey"), lineWidth: 3)
                            .frame(width: .infinity, height: 120)
                        VStack() {
                            ZStack {
                                RoundedRectangle(cornerRadius: 13.0, style: .continuous)
                                    .fill(Color("pale_grey"))
                                    .frame(width: 45, height: 45)
                                Image(systemName: "plus")
                                    .font(.system(size: 24, weight: .regular))
                                    .foregroundColor(Color("ocean"))
                            }
                            Spacer()
                            Text("Other")
                                .font(.custom("Rubik-Medium", size: 21.0, relativeTo: .headline))
                                .fontWeight(.heavy)
                                .foregroundColor(Color("slate"))
                        }
                        .padding(.horizontal, 15)
                        .padding(.vertical, 17)
                    }
                    .padding(.leading, 4)
                })
                
                // Hidden NavLink
                NavigationLink(
                    destination: FatigueLevelView().environmentObject(measure),
                    isActive: $isSet
                ) {}.hidden()
            }
            Spacer()
        }
        .padding()
        .background(Color("white"))
        .edgesIgnoringSafeArea(.bottom)
        .edgesIgnoringSafeArea(.top)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(trailing: self.BackButtonView)
    }
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ActivityView().environmentObject(Measure())
        }
    }
}
