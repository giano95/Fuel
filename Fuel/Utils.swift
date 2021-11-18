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

