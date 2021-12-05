//
//  RegistrationView.swift
//  Fuel
//
//  Created by Marco Gianelli on 01/10/2021.
//


import SwiftUI
import SwiftUIKitView
import Foundation
import Firebase



struct CustomTextField: View {
    var placeholder: Text
    @Binding var text: String
    var editingChanged: (Bool) ->() = { _ in}
    var commit: () ->() = {}
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                placeholder
                    .foregroundColor(Color("lighter_slate"))
                    .font(.custom("Rubik-Regular", size: 18.0, relativeTo: .body))
            }
            TextField(
                "",
                text: $text,
                onEditingChanged: editingChanged,
                onCommit: commit
            )
            .foregroundColor(Color("dark"))
            .font(.custom("Rubik-Regular", size: 18.0, relativeTo: .body))
        }
    }
}

struct AlertError: Identifiable {
    var id: String { field }
    let field: String
}

struct RegistrationView: View {
    
    
    @EnvironmentObject var session: SessionStore
    
    @State private var age: String = ""
    @State private var weight: String = ""
    @State private var height: String = ""
    @State private var sex: String = ""
    @State private var patientType: String = ""
    @State private var error: AlertError?
    
    func logOut() {
        session.signOut()
    }

    func register() {
        
        // Check the Sex field
        if self.sex == "" {
            self.error = AlertError(field: "The sex field is required")
            return
        }
        // Check the Age field
        let age = Int(self.age)
        if age == nil {
            self.age = ""
            self.error = AlertError(field: "Age must be an integer value!")
            return
        }
        // Check the Weight field
        let weight = Float(self.weight)
        if weight == nil {
            self.weight = ""
            self.error = AlertError(field: "Weight must be a number!")
            return
        }
        // Check the Height field
        let height = Float(self.height)
        if height == nil {
            self.height = ""
            self.error = AlertError(field: "Height must be a number!")
            return
        }
        // Check the PatientType field
        if self.patientType == "" {
            self.error = AlertError(field: "The patient type field is required")
            return
        }
        
        if let user = SessionStore.shared.user {
            
            // Save the user data accordingly to the database tree
            Database.database(url: "https://fuel-d0b5e-default-rtdb.europe-west1.firebasedatabase.app").reference()
                .child("users")
                .child(user.uid)
                .updateChildValues([
                    "sex": self.sex,
                    "age": self.age,
                    "weight": self.weight,
                    "height": self.height,
                    "patientType": self.patientType
                ])
            session.user?.toggleRegistred()
            
        } else {
            print("Error: trying to save a test but the user is not authenticathed")
        }
    }
    
    var body: some View {
            
        VStack(alignment: .leading) {
            
            // Title
            Group {
                Text("Before we start")
                    .fontWeight(.heavy)
                    .font(.custom("Rubik-Medium", size: 33.0, relativeTo: .headline))
                    .foregroundColor(Color("dark"))
                    .padding(.bottom, 0)
                    .padding(.top, 100)
                Text("Tell us about yourself!")
                    .font(.custom("Rubik-Regular", size: 21.0, relativeTo: .body))
                    .foregroundColor(Color("slate"))
                    .padding(.bottom, 0)
            }
            
            // Sex form
            Group {
                Text("Sex:")
                    .fontWeight(.heavy)
                    .font(.custom("Rubik-Medium", size: 20.0, relativeTo: .headline))
                    .foregroundColor(Color("dark"))
                    .padding(.top, 30)
                
                // Female Toggle
                HStack {
                    Image(sex == "female" ? "radio_selector_on" : "radio_selector_off")
                        .resizable()
                        .frame(width: 22, height: 22)
                    Text("Female")
                        .font(.custom("Rubik-Regular", size: 20.0, relativeTo: .body))
                        .foregroundColor(sex == "female" ? Color("ocean") : Color("slate"))
                        .padding(.leading, 10)
                    Spacer()
                }
                .padding(.top, 6)
                .onTapGesture {
                    sex = "female"
                }
                
                // Male Toggle
                HStack {
                    Image(sex == "male" ? "radio_selector_on" : "radio_selector_off")
                        .resizable()
                        .frame(width: 22, height: 22)
                    Text("Male")
                        .font(.custom("Rubik-Regular", size: 20.0, relativeTo: .body))
                        .foregroundColor(sex == "male" ? Color("ocean") : Color("slate"))
                        .padding(.leading, 10)
                    Spacer()
                }
                .padding(.top, 6)
                .onTapGesture {
                    sex = "male"
                }
                
                // Other Toggle
                HStack {
                    Image(sex == "other" ? "radio_selector_on" : "radio_selector_off")
                        .resizable()
                        .frame(width: 22, height: 22)
                    Text("Prefer not to say")
                        .font(.custom("Rubik-Regular", size: 20.0, relativeTo: .body))
                        .foregroundColor(sex == "other" ? Color("ocean") : Color("slate"))
                        .padding(.leading, 10)
                    Spacer()
                }
                .padding(.top, 6)
                .padding(.bottom, 15)
                .onTapGesture {
                    sex = "other"
                }
            }
            
            // Age Form
            Group {
                Text("Age:")
                    .fontWeight(.heavy)
                    .font(.custom("Rubik-Medium", size: 20.0, relativeTo: .headline))
                    .foregroundColor(Color("dark"))
                    .padding(.bottom, 2)
                CustomTextField(
                    placeholder: Text("Your age"),
                    text: $age
                )
                Rectangle()
                    .fill(Color("light_grey"))
                    .frame(width: 290, height: 2)
                    .padding(.bottom, 15)
            }
            
            HStack {
                
                // Weight Form
                VStack(alignment: .leading) {
                    Text("Weight:")
                        .fontWeight(.heavy)
                        .font(.custom("Rubik-Medium", size: 20.0, relativeTo: .headline))
                        .foregroundColor(Color("dark"))
                        .padding(.bottom, 2)
                    HStack {
                        CustomTextField(
                            placeholder: Text("Your weight"),
                            text: $weight
                        ).frame(width: 110)
                        Text("kg")
                            .fontWeight(.heavy)
                            .font(.custom("Rubik-Medium", size: 20.0, relativeTo: .headline))
                            .foregroundColor(Color("dark"))
                        Spacer()
                    }
                    Rectangle()
                        .fill(Color("light_grey"))
                        .frame(width: 110, height: 2)
                }
                Spacer()
                
                // Height Form
                VStack(alignment: .leading) {
                    Text("Height:")
                        .fontWeight(.heavy)
                        .font(.custom("Rubik-Medium", size: 20.0, relativeTo: .headline))
                        .foregroundColor(Color("dark"))
                        .padding(.bottom, 2)
                    HStack {
                        CustomTextField(
                            placeholder: Text("Your height"),
                            text: $height
                        ).frame(width: 110)
                        Text("cm")
                            .fontWeight(.heavy)
                            .font(.custom("Rubik-Medium", size: 20.0, relativeTo: .headline))
                            .foregroundColor(Color("dark"))
                        Spacer()
                    }
                    Rectangle()
                        .fill(Color("light_grey"))
                        .frame(width: 110, height: 2)
                }
            }.padding(.bottom, 15)
            
            // Patient form
            Group {
                Text("What kind of patient you are?")
                    .fontWeight(.heavy)
                    .font(.custom("Rubik-Medium", size: 20.0, relativeTo: .headline))
                    .foregroundColor(Color("dark"))
                
                // MS Patient Toggle
                HStack {
                    Image(patientType == "sclerosis" ? "radio_selector_on" : "radio_selector_off")
                        .resizable()
                        .frame(width: 22, height: 22)
                    Text("An MS patient")
                        .font(.custom("Rubik-Regular", size: 20.0, relativeTo: .body))
                        .foregroundColor(patientType == "sclerosis" ? Color("ocean") : Color("slate"))
                        .padding(.leading, 10)
                    Spacer()
                }
                .padding(.top, 6)
                .onTapGesture {
                    patientType = "sclerosis"
                }
                
                // Oncology Patient Toggle
                HStack {
                    Image(patientType == "cancer" ? "radio_selector_on" : "radio_selector_off")
                        .resizable()
                        .frame(width: 22, height: 22)
                    Text("An oncology patient")
                        .font(.custom("Rubik-Regular", size: 20.0, relativeTo: .body))
                        .foregroundColor(patientType == "cancer" ? Color("ocean") : Color("slate"))
                        .padding(.leading, 10)
                    Spacer()
                }
                .padding(.top, 6)
                .onTapGesture {
                    patientType = "cancer"
                }
                
                // No PatientToggle
                HStack {
                    Image(patientType == "other" ? "radio_selector_on" : "radio_selector_off")
                        .resizable()
                        .frame(width: 22, height: 22)
                    Text("Not a patient")
                        .font(.custom("Rubik-Regular", size: 20.0, relativeTo: .body))
                        .foregroundColor(patientType == "other" ? Color("ocean") : Color("slate"))
                        .padding(.leading, 10)
                    Spacer()
                }
                .padding(.top, 6)
                .padding(.bottom, 15)
                .onTapGesture {
                    patientType = "other"
                }
            }
            Spacer()
            
            // Register Button
            Button(action: { register() }, label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 12.0, style: .continuous)
                        .fill(Color("slate"))
                        .frame(width: .infinity, height: 50)
                    Text("I'm all set")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .font(.custom("Rubik-Medium", size: 20.0, relativeTo: .headline))
                }
            })
            .padding(.bottom, 100)
            .alert(item: $error) { error in
                Alert(
                    title: Text("Error"),
                    message: Text(error.field),
                    dismissButton: .cancel()
                )
            }
        }
        .padding(.horizontal, 20)
        .background(Color("white"))
        .edgesIgnoringSafeArea(.top)
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarBackButtonHidden(true)
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RegistrationView().environmentObject(SessionStore.shared)
        }
    }
}
