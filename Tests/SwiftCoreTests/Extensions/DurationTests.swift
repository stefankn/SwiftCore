//
//  DurationTests.swift
//  
//
//  Created by Stefan Klein Nulent on 11/12/2022.
//

import XCTest

final class DurationTests: XCTestCase {

    // MARK: - Functions
    
    func testNanoseconds() {
        let duration = Duration.seconds(2.56)
        
        XCTAssertEqual(2_560_000_000, duration.nanoseconds)
    }
    
    func testMicroSeconds() {
        let duration = Duration.seconds(2.56)
        
        XCTAssertEqual(2_560_000, duration.microseconds)
    }
    
    func testMilliSeconds() {
        let duration = Duration.seconds(2.56)
        
        XCTAssertEqual(2560, duration.milliseconds)
    }

    func testSeconds() throws {
        let duration = Duration.seconds(2.56)
        
        XCTAssertEqual(2.56, duration.seconds)
    }

}
