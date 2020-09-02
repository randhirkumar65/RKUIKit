//
//  DateExtensionsTests.swift
//  RKUIKitTests
//
//  Created by Randhir Kumar on 02/09/20.
//  Copyright © 2020 Randhir kumar. All rights reserved.
//

import XCTest
@testable import RKUIKit

class DateExtensionsTests: XCTestCase {

    var sampleDate: Date!

    override func setUp() {
        super.setUp()
        
        // initializing sample date with 20-Aug-2020
        sampleDate = Calendar.current.date(from:
            DateComponents(year: 2020, month: 08, day: 20, hour: 0, minute: 0, second: 0))
    }
    
    override func tearDown() {
        sampleDate = nil
        super.tearDown()
    }
    
    func testStartOfWeek() {
        let expectedMiddleStartOfWeek = Calendar.current.date(from:
        DateComponents(year: 2020, month: 08, day: 16, hour: 0, minute: 0, second: 0))
        
        XCTAssertNotNil(sampleDate)
        
        guard let startOfWeek = sampleDate.startOfWeek() else {
            XCTFail("startOfWeek() returns an empty value")
            return
        }
        
        // checking for middle of the week i.e 20,Aug,2020
        XCTAssertEqual(startOfWeek, expectedMiddleStartOfWeek)
        
        // checking for First of the week
        XCTAssertEqual(Calendar.current.date(from:
            DateComponents(year: 2020, month: 08, day: 16, hour: 8, minute: 30, second: 0))?.startOfWeek(), Calendar.current.date(from:
        DateComponents(year: 2020, month: 08, day: 16, hour: 0, minute: 0, second: 0)))
        
        // checking for Last of the week
        XCTAssertEqual(Calendar.current.date(from:
            DateComponents(year: 2020, month: 08, day: 29, hour: 8, minute: 30, second: 0))?.startOfWeek(), Calendar.current.date(from:
        DateComponents(year: 2020, month: 08, day: 23, hour: 0, minute: 0, second: 0)))
        
        // checking for Last Second of the week
        XCTAssertEqual(Calendar.current.date(from:
            DateComponents(year: 2020, month: 08, day: 28, hour: 8, minute: 30, second: 0))?.startOfWeek(), Calendar.current.date(from:
        DateComponents(year: 2020, month: 08, day: 23, hour: 0, minute: 0, second: 0)))

        // checking for First second of the week
        XCTAssertEqual(Calendar.current.date(from:
            DateComponents(year: 2020, month: 08, day: 30, hour: 8, minute: 30, second: 0))?.startOfWeek(), Calendar.current.date(from:
        DateComponents(year: 2020, month: 08, day: 30, hour: 0, minute: 0, second: 0)))
    }
    
    func testStartOfMonth() {
        let expectedStartOfMonth = Calendar.current.date(from:
            DateComponents(year: 2020, month: 08, day: 1, hour: 0, minute: 0, second: 0))
        
        XCTAssertNotNil(sampleDate)
        
        guard let startOfMonth = sampleDate.startOfMonth() else {
            XCTFail("startOfMonth() returns an empty value")
            return
        }
        
        // checking for middle of the Month i.e 20,Aug,2020
        XCTAssertEqual(startOfMonth, expectedStartOfMonth)
        
        // checking for First of the Month
        XCTAssertEqual(Calendar.current.date(from:
            DateComponents(year: 2020, month: 08, day: 1, hour: 8, minute: 30, second: 0))?.startOfMonth(), expectedStartOfMonth)
        
        // checking for Last of the Month
        XCTAssertEqual(Calendar.current.date(from:
            DateComponents(year: 2020, month: 08, day: 29, hour: 8, minute: 30, second: 0))?.startOfMonth(), expectedStartOfMonth)
        
        // checking for Last Second of the Month
        XCTAssertEqual(Calendar.current.date(from:
            DateComponents(year: 2020, month: 08, day: 28, hour: 8, minute: 30, second: 0))?.startOfMonth(), expectedStartOfMonth)
        
        // checking for First second of the Month
        XCTAssertEqual(Calendar.current.date(from:
            DateComponents(year: 2020, month: 08, day: 30, hour: 8, minute: 30, second: 0))?.startOfMonth(), expectedStartOfMonth)
    }
    
    func testStartOfYear() {
        let expectedStartOfYear = Calendar.current.date(from:
            DateComponents(year: 2020, month: 01, day: 1, hour: 0, minute: 0, second: 0))
        
        XCTAssertNotNil(sampleDate)
        
        guard let startOfYear = sampleDate.startOfYear() else {
            XCTFail("startOfYear() returns an empty value")
            return
        }
        
        // checking for middle of the Year i.e 20,Aug,2020
        XCTAssertEqual(startOfYear, expectedStartOfYear)
        
        // checking for First of the Year
        XCTAssertEqual(Calendar.current.date(from:
            DateComponents(year: 2020, month: 08, day: 1, hour: 8, minute: 30, second: 0))?.startOfYear(), expectedStartOfYear)
        
        // checking for Last of the Year
        XCTAssertEqual(Calendar.current.date(from:
            DateComponents(year: 2020, month: 08, day: 29, hour: 8, minute: 30, second: 0))?.startOfYear(), expectedStartOfYear)
        
        // checking for Last Second of the Year
        XCTAssertEqual(Calendar.current.date(from:
            DateComponents(year: 2020, month: 08, day: 28, hour: 8, minute: 30, second: 0))?.startOfYear(), expectedStartOfYear)
        
        // checking for First second of the Year
        XCTAssertEqual(Calendar.current.date(from:
            DateComponents(year: 2020, month: 08, day: 30, hour: 8, minute: 30, second: 0))?.startOfYear(), expectedStartOfYear)
    }

}
