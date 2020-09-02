//
//  Date+Extensions.swift
//  RKUIKit
//
//  Created by Randhir Kumar on 02/09/20.
//  Copyright © 2020 Randhir kumar. All rights reserved.
//

import Foundation

extension Date {

    /// Returns a Date that represents the start of the current week using Calendar.current
    public func startOfWeek() -> Date? {
        let calendar = Calendar.current
        return calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))
    }
    
    /// Returns a Date that represents the start of the current month using Calendar.current
    public func startOfMonth() -> Date? {
        let calendar = Calendar.current
        return calendar.date(from: calendar.dateComponents([.year, .month], from: self))
    }

    /// Returns a Date that represents the start of the current year using Calendar.current
    public func startOfYear() -> Date? {
        let calendar = Calendar.current
        return calendar.date(from: calendar.dateComponents([.year], from: self))
    }
}
