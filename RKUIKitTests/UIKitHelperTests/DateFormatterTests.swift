//
//  DateFormatterTests.swift
//  RKUIKitTests
//
//  Created by Randhir Kumar on 02/09/20.
//  Copyright © 2020 Randhir kumar. All rights reserved.
//

import XCTest
@testable import RKUIKit

class DateFormatterTests: XCTestCase {

    var sampleDate: Date!
    
    override func setUp() {
        super.setUp()
        
        // initializing sample date with 26-Aug-2020
        sampleDate = Calendar.current.date(from:
        DateComponents(year: 2020, month: 08, day: 26, hour: 2, minute: 02, second: 12))
    }
    
    override func tearDown() {
        sampleDate = nil
        super.tearDown()
    }
    
    func testDateTimeFormatters() {
        
        let expectedNumericMonthDay = "8/26"
        let expectedShortMonthShortDayShortYear = "8/26/20"
        let expectedMediumMonthLongYear = "Aug 2020"
        let expectedMediumMonthShortDayLongYear = "Aug 26, 2020"
        let expectedLongMonthShortDayLongYear = "August 26, 2020"
        let expectedLongMonthLongYear = "August 2020"
        let expectedMonthDayHour = "Aug 26 2am"
        let expectedHour = "2am"
        let expectedLongYear = "2020"
        let expectedMonthDay = "Aug 26"
        let expectedShortDay = "26"
        let expectedMonthOnly = "Aug"
        let expectedTimeOnly = "2:02 AM"
        
        // Testing sample date
        XCTAssertNotNil(sampleDate)
        
        // Testing Date Formatters
        XCTAssertEqual(CommonDateTimeFormatters.dateFormatter(style: .numericMonthNumericDay).string(from: sampleDate), expectedNumericMonthDay)
        XCTAssertEqual(CommonDateTimeFormatters.dateFormatter(style: .shortMonthShortDayShortYear).string(from: sampleDate), expectedShortMonthShortDayShortYear)
        XCTAssertEqual(CommonDateTimeFormatters.dateFormatter(style: .mediumMonthLongYear).string(from: sampleDate), expectedMediumMonthLongYear)
        XCTAssertEqual(CommonDateTimeFormatters.dateFormatter(style: .longMonthShortDayLongYear).string(from: sampleDate), expectedLongMonthShortDayLongYear)
        XCTAssertEqual(CommonDateTimeFormatters.dateFormatter(style: .mediumMonthShortDayLongYear).string(from: sampleDate), expectedMediumMonthShortDayLongYear)
        XCTAssertEqual(CommonDateTimeFormatters.dateFormatter(style: .longMonthLongYear).string(from: sampleDate), expectedLongMonthLongYear)
        XCTAssertEqual(CommonDateTimeFormatters.dateFormatter(style: .shortDayOnly).string(from: sampleDate), expectedShortDay)
        XCTAssertEqual(CommonDateTimeFormatters.dateFormatter(style: .hourOnly).string(from: sampleDate), expectedHour)
        XCTAssertEqual(CommonDateTimeFormatters.dateFormatter(style: .shortMonthDay).string(from: sampleDate), expectedMonthDay)
        XCTAssertEqual(CommonDateTimeFormatters.dateFormatter(style: .shortMonthDayHour).string(from: sampleDate), expectedMonthDayHour)
        XCTAssertEqual(CommonDateTimeFormatters.dateFormatter(style: .shortMonthOnly).string(from: sampleDate), expectedMonthOnly)
        XCTAssertEqual(CommonDateTimeFormatters.dateFormatter(style: .longYearOnly).string(from: sampleDate), expectedLongYear)
        XCTAssertEqual(CommonDateTimeFormatters.dateFormatter(style: .timeOnly).string(from: sampleDate), expectedTimeOnly)
        
        // Testing Time Formatters
        XCTAssertEqual(CommonDateTimeFormatters.timeFormatter.string(from: sampleDate), expectedTimeOnly)

    }

}
