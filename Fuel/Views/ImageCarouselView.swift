//
//  ImageCarouselView.swift
//  Fuel
//
//  Created by Marco Gianelli on 29/04/2021.
//

import Foundation
import SwiftUI
import Combine

struct ImageCarouselView<Image: View>: View {
    
    private var numberOfImages: Int
    private var images: Image
    private var titles: [String]
    private var descriptions: [String]

    @State private var currentIndex: Int = 0
    
    private let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()

    init(numberOfImages: Int, titles: [String], descriptions: [String], @ViewBuilder images: () -> Image) {
        self.numberOfImages = numberOfImages
        self.images = images()
        self.titles = titles
        self.descriptions = descriptions
    }

    var body: some View {
        GeometryReader { geometry in
            VStack {
                
                // Carousel Images
                HStack(spacing: 0) {
                    self.images
                }
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .leading)
                .offset(x: CGFloat(self.currentIndex) * -geometry.size.width, y: 0)
                .animation(.spring())
                .onReceive(self.timer) { _ in
                    self.currentIndex = (self.currentIndex + 1) % numberOfImages
                }
                .padding(.bottom, 25)
                .padding(.top, 30)
                
                // Title
                Text(titles[self.currentIndex])
                    .fontWeight(.black)
                    .font(.custom("Rubik-Medium", size: 30.0, relativeTo: .headline))
                    .foregroundColor(Color("dark"))
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 45)
                    .padding(.bottom, 10)
                
                // Description
                Text(descriptions[self.currentIndex])
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.horizontal, 35)
                    .multilineTextAlignment(.center)
                    .font(.custom("Rubik-Regular", size: 20.0, relativeTo: .body))
                    .foregroundColor(Color("slate"))
                    .padding(.bottom, 20)
                    .lineSpacing(4)
                
                // Page indicator circle
                HStack(spacing: 9) {
                    ForEach(0..<self.numberOfImages, id: \.self) { index in
                        Circle()
                            .frame(width: index == self.currentIndex ? 10: 8, height: index == self.currentIndex ? 10: 8)
                            .foregroundColor(index == self.currentIndex ? Color("ocean"): Color("slate_grey"))
                            .animation(.spring())
                    }
                }
            }
        }
    }
}

struct ImageCarousel_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            GeometryReader { geometry in
                ImageCarouselView(
                    numberOfImages: 5,
                    titles: [
                        "Welcome to Fuel!",
                        "Welcome to Fuel!",
                        "Welcome to Fuel!",
                        "Welcome to Fuel!",
                        "Welcome to Fuel!"
                    ],
                    descriptions: [
                        "An app designed to help multiple sclerosis and oncology patients beat fatigue!",
                        "But for this to come true, we first need to gather information on how tiredness works.",
                        "This is were you come in! Three times a day, we will ask for you to perform a 3 minutes test.",
                        "While you do the test, we will also measure your eye-blinking rate with your phone's camera.",
                        "Donate 15 minutes of your time per day for 10 days and help thousands of patients!"
                    ],
                    images: {
                        Utils.wrapImage(name: "illustration_demo_01", geometry: geometry)
                        Utils.wrapImage(name: "illustration_demo_02", geometry: geometry)
                        Utils.wrapImage(name: "illustration_demo_03", geometry: geometry)
                        Utils.wrapImage(name: "illustration_demo_04", geometry: geometry)
                        Utils.wrapImage(name: "illustration_demo_05", geometry: geometry)
                    }
                )
            }
            .frame(width: UIScreen.main.bounds.width, height: 280, alignment: .top)
            Spacer()
        }
    }
}
