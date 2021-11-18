//
//  ButtonStyles.swift
//  Fuel
//
//  Created by Marco Gianelli on 28/04/2021.
//

import Foundation
import SwiftUI

struct greenCapsuleButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal, 60)
            .padding(.vertical, 15)
            .background(Color("ocean"))
            .clipShape(Capsule())
            .foregroundColor(.white)
    }
}
