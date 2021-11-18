//
//  TestData.swift
//  Fuel
//
//  Created by Marco Gianelli on 13/05/2021.
//

import Foundation


public struct Test {
    
    public var delay: Int = 0
    public var reaction: Int = 0
    public var timeBeforeTest: Int = 0
   
    init(delay: Int = 0, reaction: Int = 0, timebeforeTest: Int = 0) {
        self.delay = delay
        self.reaction = reaction
        self.timeBeforeTest = timebeforeTest
    }

    // Save a Test in the Firestore DB
    public func toData() -> [String: Any] {
        return [
            "delay": delay,
            "reaction": reaction,
            "timeBeforeTest": timeBeforeTest
        ]
    }
}
