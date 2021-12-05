//
//  Utils.swift
//  Fuel
//
//  Created by Marco Gianelli on 27/04/2021.
//

import Foundation
import SwiftUI
import UIKit
import SwiftUIKitView

// Change placeholder Text on TextField
extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

// Navigate to a view programatically (kind of)
extension View {
    func navigate<NewView: View>(to view: NewView, when binding: Binding<Bool>) -> some View {
        NavigationView {
            ZStack {
                self
                    .navigationBarTitle("")
                    .navigationBarHidden(true)

                NavigationLink(
                    destination: view
                        .navigationBarTitle("")
                        .navigationBarHidden(true),
                    isActive: binding
                ) {
                    EmptyView()
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}

open class Utils {

    static func hideMidChars(_ value: String) -> String {
       return String(value.enumerated().map { index, char in
          return [0, 1, value.count - 1, value.count - 2].contains(index) ? char : "*"
       })
    }

    static func maskEmail(email: String) -> String {
        let components = email.components(separatedBy: "@")
        return hideMidChars(components.first!) + "@" + components.last!
    }
    
    static func wrapImage(name: String, geometry: GeometryProxy) -> some View {
        return Image(name)
            .resizable()
            .scaledToFill()
            .frame(width: geometry.size.width, height: geometry.size.height)
            .clipped()
    }
    
    static func getCurrentTime() -> Int {
        return Int(DispatchTime.now().uptimeNanoseconds / 1_000_000)
    }
}

struct UIViewConverter: View {
    
    var _UIView: UIView
    
    var body: some View {
        _UIView.swiftUIView(layout: .intrinsic)
    }
}

