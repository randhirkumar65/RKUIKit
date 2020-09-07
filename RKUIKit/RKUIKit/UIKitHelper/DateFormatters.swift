//
//  DateFormatters.swift
//  RKUIKit
//
//  Created by Randhir Kumar on 02/09/20.
//  Copyright © 2020 Randhir kumar. All rights reserved.
//

import Foundation

public enum DateTimeFormatterStyle {
    case numericMonthNumericDay
    case shortMonthShortDayShortYear
    case mediumMonthLongYear
    case longMonthShortDayLongYear
    case mediumMonthShortDayLongYear
    case longMonthLongYear
    case timeOnly
    case shortDayOnly
    case hourOnly
    case shortMonthDay
    case shortMonthDayHour
    case shortMonthOnly
    case longYearOnly
    
    public var dateFormatter: DateFormatter {
        switch self {
        case .numericMonthNumericDay: return CommonDateTimeFormatters.numericMonthNumericDayDateFormatter
        case .shortMonthShortDayShortYear: return CommonDateTimeFormatters.shortMonthShortDayShortYearDateFormatter
        case .mediumMonthLongYear: return CommonDateTimeFormatters.mediumMonthLongYearDateFormatter
        case .longMonthShortDayLongYear: return CommonDateTimeFormatters.longMonthShortDayLongYearDateFormatter
        case .mediumMonthShortDayLongYear: return CommonDateTimeFormatters.mediumMonthShortDayLongYearDateFormatter
        case .longMonthLongYear: return CommonDateTimeFormatters.longMonthLongYearDateFormatter
        case .timeOnly: return CommonDateTimeFormatters.timeOnlyDateFormatter
        case .shortDayOnly: return CommonDateTimeFormatters.shortDayOnlyDateFormatter
        case .shortMonthDayHour: return CommonDateTimeFormatters.shortMonthDayHourFormatter
        case .hourOnly: return CommonDateTimeFormatters.hourOnlyFormatter
        case .shortMonthDay: return CommonDateTimeFormatters.shortMonthDayFormatter
        case .shortMonthOnly: return CommonDateTimeFormatters.shortMonthOnly
        case .longYearOnly: return CommonDateTimeFormatters.longYearOnly
        }
    }
}

public class CommonDateTimeFormatters {
    
    public class func dateFormatter(style: DateTimeFormatterStyle) -> DateFormatter {
        return style.dateFormatter
    }
    
    public static let timeFormatter: DateFormatter = {
        return DateTimeFormatterStyle.timeOnly.dateFormatter
    }()
    
    fileprivate static let numericMonthNumericDayDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "M/d"
        return formatter
    }()
    
    fileprivate static let shortMonthShortDayShortYearDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "M/dd/yy"
        return formatter
    }()
    
    fileprivate static let mediumMonthLongYearDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM yyyy"
        return formatter
    }()
    
    fileprivate static let longMonthShortDayLongYearDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy"
        return formatter
    }()
    
    fileprivate static let mediumMonthShortDayLongYearDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        return formatter
    }()
    
    fileprivate static let longMonthLongYearDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }()
    
    fileprivate static let timeOnlyDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter
    }()
    
    fileprivate static let shortDayOnlyDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter
    }()
    
    fileprivate static let hourOnlyFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "ha"
        formatter.amSymbol = "am"
        formatter.pmSymbol = "pm"
        return formatter
    }()
    
    fileprivate static let shortMonthDayHourFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd ha"
        formatter.amSymbol = "am"
        formatter.pmSymbol = "pm"
        return formatter
    }()
    
    fileprivate static let shortMonthDayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd"
        return formatter
    }()
    
    fileprivate static let shortMonthOnly: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        return formatter
    }()
    
    fileprivate static let longYearOnly: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter
    }()
}
