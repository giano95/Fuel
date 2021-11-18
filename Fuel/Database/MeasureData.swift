//
//  MeasureData.swift
//  Fuel
//
//  Created by Marco Gianelli on 18/05/2021.
//

import Foundation

public class Measure: ObservableObject {
        
    public var tests: [Test] = []
    public var failedTests: Int = 0
    public var activity: String = ""
    public var fatigueLevel: Int = 0
    
    init(tests: [Test] = [], failedTests: Int = 0, activity: String = "", fatigueLevel: Int = 0) {
        self.tests = tests
        self.failedTests = failedTests
        self.activity = activity
        self.fatigueLevel = fatigueLevel
    }
    
    // Save a Measure in the Firestore DB
    public func toData() -> [String: Any] {
        
        var arr: [[String: Any]] = []
        for test in tests {
            arr.append(test.toData())
        }
        
        return [
            "tests": arr,
            "failedsTests": failedTests,
            "activity": activity,
            "fatigueLevel": fatigueLevel
        ]
    }
}
