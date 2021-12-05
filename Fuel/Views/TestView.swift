//
//  TestView.swift
//  Fuel
//
//  Created by Marco Gianelli on 13/05/2021.
//

import SwiftUI
import Firebase

enum ButtonShape {
    case rect
    case circle
}

protocol TimerObserver {
    func timerFinish()
}

class TestTimer {
    
    private var timer:Timer?
    private var observers = [TimerObserver]()
    
    public var startTime: Int?
    public var endTime: Int?

    public func registerObserver(observer: TimerObserver) {
        observers.append(observer)
    }
    
    public func start(timeInterval: TimeInterval) {
        
        guard timer == nil else { return }
        
        startTime = Utils.getCurrentTime()
        
        timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: false) {_ in
            self.endTime = Utils.getCurrentTime()
            for observer in self.observers {
                observer.timerFinish()
            }
        }
    }
    
    public func reset() {
        timer?.invalidate()
        timer = nil
    }
    
    init() {}
}

struct TestView: View, TimerObserver {
    
    // for override the back button
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    // Graphic stuff
    @State var title = "Ready?"
    @State var description = "Press on the green square now"
    @State var buttonShape = "square"
    
    // Test stuff
    @State var timer = TestTimer()
    @State var test: Test?
    @StateObject var measure: Measure = Measure()
    @State var testCount = 0
    @State var isTestFinish: Bool = false
    
    var TestCountView: some View {
        VStack(alignment: .leading) {
            // left alignment
            HStack {
                Spacer()
            }

            Text("Rounds to go")
                .font(.custom("Rubik-Medium", size: 18.0, relativeTo: .headline))
                .fontWeight(.bold)
                .foregroundColor(Color("slate"))
            Text(String(testCount) + " / 5")
                .font(.custom("Rubik-Medium", size: 18.0, relativeTo: .headline))
                .fontWeight(.bold)
                .foregroundColor(Color("dark"))
        }
        .padding(.horizontal, 7)
    }
    
    var BackButtonView: some View {
        Button(action: { self.presentationMode.wrappedValue.dismiss() }) {
            Image("icon_close")
        }
        .padding(.horizontal, 5)
    }
    
    func timerFinish() {
        buttonShape = "circle"
        self.title = "Stop!"
        self.description = "Now take your finger off"
    }
    
    func isPressed() {
        
        // Change the output text
        self.title = "Hold!"
        self.description = "Don't take your finger off"
        
        // Initialize all the Test Data
        test = Test(
            delay: 2000 + Int.random(in: 100...2000),
            reaction: -1,
            timebeforeTest: (testCount == 0) ? 0: Utils.getCurrentTime() - timer.startTime!
        )
        
        // Start the timer
        timer.start(timeInterval: Double(test!.delay) / 1000.0)
    }
    
    func isRealesed() {
        
        // Firest reset the timer in order to prevent overlapping
        timer.reset()
        
        let realeseTime = Utils.getCurrentTime()
        
        if (realeseTime - timer.startTime!) >= test!.delay
            && test != nil
            && timer.startTime != nil {
            // the user realesed the button after the timer run out
            // --> GOOD
            
            test!.reaction = realeseTime - timer.endTime!
            
            measure.tests.append(test!)
            testCount += 1
            
            if testCount == 5 {
                self.isTestFinish = true
            }
            
            // Change the output text
            self.title = "Ready?"
            self.description = "Press on the green square now"
            self.buttonShape = "square"

        } else {
            // the user realesed the button before the timer run out
            // --> BAD
            
            measure.failedTests += 1
            
            // Change the output text
            self.title = "Too early!"
            self.description = "Press the button until it turns yellow"
            self.buttonShape = "square"
            
            
        }
    }
    
    var body: some View {
        
        VStack {
            Spacer()
            Text(title)
                .fontWeight(.black)
                .font(.custom("Rubik-Medium", size: 32.0, relativeTo: .headline))
                .foregroundColor(Color("dark"))
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 45)
                .padding(.bottom, 2)
            Text(description)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.horizontal, 80)
                .multilineTextAlignment(.center)
                .font(.custom("Rubik-Regular", size: 20.0, relativeTo: .body))
                .foregroundColor(Color("slate"))
                .padding(.bottom, 60)
                .lineSpacing(4)
            Image(buttonShape)
                .resizable()
                .scaledToFill()
                .frame(width: 180, height: 180)
                .clipped()
                .gesture(
                    DragGesture(minimumDistance: 0, coordinateSpace: .global)
                        .onChanged { _ in
                            isPressed()
                        }
                        .onEnded{ _ in
                            isRealesed()
                        }
                )
            NavigationLink(destination: ActivityView().environmentObject(measure), isActive: $isTestFinish) {}
                .hidden()
            
            // bottom padding
            HStack {
                Spacer()
            }.frame(height: 180)
        }
        .onAppear {
            timer.registerObserver(observer: self)
        }
        .padding()
        .background(Color("white"))
        .edgesIgnoringSafeArea(.bottom)
        .edgesIgnoringSafeArea(.top)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: self.TestCountView, trailing: self.BackButtonView)
    }
}

//struct TestView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            TestView()
//        }
//    }
//}
