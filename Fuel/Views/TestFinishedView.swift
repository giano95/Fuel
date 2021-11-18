//
//  TestFinishedView.swift
//  Fuel
//
//  Created by Marco Gianelli on 31/05/2021.
//

import SwiftUI
import Firebase


struct TestFinishedView: View {
    
    @EnvironmentObject var measure: Measure
    
    // for override the back button
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var backButton: some View {
        Button(action: { self.presentationMode.wrappedValue.dismiss() }) {
            Image("icon_close")
        }
    }

    
    var body: some View {
        
        VStack {
            
            Text("Thank you for your help! See you later")
                .fontWeight(.heavy)
                .font(.custom("Rubik-Medium", size: 27.0, relativeTo: .headline))
                .foregroundColor(Color("dark"))
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
                .padding(.top, 160)
            Image("illustration_demo_05")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width, height: 260, alignment: .top)
                .clipped()
                .padding(.top, 40)
            Spacer()
        }
        .edgesIgnoringSafeArea(.top)
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(trailing: self.backButton)
        .onAppear(perform:
            {
                if let user = SessionStore.shared.user {
                    
                    // Get the current date and time as a string
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy:MM:dd"
                    let date = formatter.string(from: Date())
                    formatter.dateFormat = "HH:mm"
                    let time = formatter.string(from: Date())
                    
                    // Save the measure data accordingly to the database tree
                    Database.database(url: "https://fuel-d0b5e-default-rtdb.europe-west1.firebasedatabase.app").reference()
                        .child("data")
                        .child(user.uid)
                        .child(date)
                        .child("test")
                        .child(time)
                        .setValue(measure.toData())
                    
                    
                } else {
                    print("Error: trying to save a test but the user is not authenticathed")
                }
            }
        )
    }
}

struct TestFinishedView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TestFinishedView().environmentObject(Measure())
        }
    }
}
