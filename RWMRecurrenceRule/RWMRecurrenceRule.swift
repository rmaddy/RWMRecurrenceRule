//
//  RWMRRule.swift
//  RWMRecurrenceRule
//
//  Created by Richard W Maddy on 5/13/18.
//  Copyright © 2018 Maddysoft. All rights reserved.
//

import Foundation

/// Defines frequencies for recurrence rules.
///
/// - daily: Indicates a daily recurrence rule.
/// - weekly: Indicates a weekly recurrence rule.
/// - monthly: Indicates a monthly recurrence rule.
/// - yearly: Indicates a yearly recurrence rule.
public enum RWMRecurrenceFrequency: Int {
    case daily = 0
    case weekly = 1
    case monthly = 2
    case yearly = 3
}

/// The RWMRecurrenceEnd struct defines the end of a recurrence rule defined by an RWMRecurrenceRule object.
/// The recurrence end can be specified by a date (date-based) or by a maximum count of occurrences (count-based).
/// An event which is set to never end should have its RWMRecurrenceEnd set to nil.
public struct RWMRecurrenceEnd: Equatable {
    /// The end date of the recurrence end, or `nil` if the recurrence end is count-based.
    public let endDate: Date?
    /// The occurrence count of the recurrence end, or `0` if the recurrence end is date-based.
    public let count: Int

    /// Initializes and returns a date-based recurrence end with a given end date.
    ///
    /// - Parameter end: The end date.
    public init(end: Date) {
        self.endDate = end
        self.count = 0
    }

    /// Initializes and returns a count-based recurrence end with a given maximum occurrence count.
    ///
    /// - Parameter occurrenceCount: The maximum occurrence count.
    public init(occurrenceCount: Int) {
        self.endDate = nil
        if occurrenceCount > 0 {
            self.count = occurrenceCount
        } else {
            fatalError("occurrenceCount must be > 0")
        }
    }

    public static func==(lhs: RWMRecurrenceEnd, rhs: RWMRecurrenceEnd) -> Bool {
        if let ldate = lhs.endDate {
            if let rdate = rhs.endDate {
                return ldate == rdate // both are dates
            } else {
                return false // one date and one count
            }
        } else {
            if rhs.endDate != nil {
                return false // one date and one count
            } else {
                return lhs.count == rhs.count // both are counts
            }
        }
    }
}

public enum RWMWeekday: Int {
    case sunday = 1
    case monday = 2
    case tuesday = 3
    case wednesday = 4
    case thursday = 5
    case friday = 6
    case saturday = 7
}

/// The `RWMRecurrenceDayOfWeek` struct represents a day of the week for use with an `RWMRecurrenceRule` object.
/// A day of the week can optionally have a week number, indicating a specific day in the recurrence rule’s frequency.
/// For example, a day of the week with a day value of `Tuesday` and a week number of `2` would represent the second
/// Tuesday of every month in a monthly recurrence rule, and the second Tuesday of every year in a yearly recurrence
/// rule. A day of the week with a week number of `0` ignores its week number.
public struct RWMRecurrenceDayOfWeek: Equatable {
    /// The day of the week.
    public let dayOfTheWeek: RWMWeekday
    /// The week number of the day of the week.
    ///
    /// Values range from `-53` to `53`. A negative value indicates a value from the end of the range. `0` indicates the week number is irrelevant.
    public let weekNumber: Int

    /// Initializes and returns a day of the week with a given day and week number.
    ///
    /// - Parameters:
    ///   - dayOfTheWeek: The day of the week.
    ///   - weekNumber: The week number.
    public init(dayOfTheWeek: RWMWeekday, weekNumber: Int) {
        self.dayOfTheWeek = dayOfTheWeek
        if weekNumber < -53 || weekNumber > 53 {
            fatalError("weekNumber must be -53 to 53")
        } else {
            self.weekNumber = weekNumber
        }
    }

    /// Creates and returns a day of the week with a given day.
    ///
    /// - Parameter dayOfTheWeek: The day of the week.
    public init(_ dayOfTheWeek: RWMWeekday) {
        self.init(dayOfTheWeek: dayOfTheWeek, weekNumber: 0)
    }

    /// Creates and returns an autoreleased day of the week with a given day and week number.
    ///
    /// - Parameters:
    ///   - dayOfTheWeek: The day of the week.
    ///   - weekNumber: The week number.
    public init(_ dayOfTheWeek: RWMWeekday, weekNumber: Int) {
        self.init(dayOfTheWeek: dayOfTheWeek, weekNumber: weekNumber)
    }

    public static func==(lhs: RWMRecurrenceDayOfWeek, rhs: RWMRecurrenceDayOfWeek) -> Bool {
        return lhs.dayOfTheWeek == rhs.dayOfTheWeek && lhs.weekNumber == rhs.weekNumber
    }
}

/// The `RWMRecurrenceRule` class is used to describe the recurrence pattern for a recurring event.
public struct RWMRecurrenceRule: Equatable {
    /// The frequency of the recurrence rule.
    let frequency: RWMRecurrenceFrequency
    /// Specifies how often the recurrence rule repeats over the unit of time indicated by its frequency. For example, a recurrence rule with a frequency type of `.weekly` and an interval of `2` repeats every two weeks.
    let interval: Int?
    /// Indicates which day of the week the recurrence rule treats as the first day of the week. No value indicates that this property is not set for the recurrence rule.
    let firstDayOfTheWeek: RWMWeekday?
    /// The days of the week associated with the recurrence rule, as an array of `RWMRecurrenceDayOfWeek` objects.
    let daysOfTheWeek: [RWMRecurrenceDayOfWeek]?
    /// The days of the month associated with the recurrence rule, as an array of `Int`. Values can be from 1 to 31 and from -1 to -31. This property value is invalid with a frequency type of `.weekly`.
    let daysOfTheMonth: [Int]?
    /// The days of the year associated with the recurrence rule, as an array of `Int`. Values can be from 1 to 366 and from -1 to -366. This property value is valid only for recurrence rules initialized with a frequency type of `.yearly`.
    let daysOfTheYear: [Int]?
    /// The weeks of the year associated with the recurrence rule, as an array of `Int` objects. Values can be from 1 to 53 and from -1 to -53. This property value is valid only for recurrence rules initialized with specific weeks of the year and a frequency type of `.yearly`.
    let weeksOfTheYear: [Int]?
    /// The months of the year associated with the recurrence rule, as an array of `Int` objects. Values can be from 1 to 12. This property value is valid only for recurrence rules initialized with specific months of the year and a frequency type of `.yearly`.
    let monthsOfTheYear: [Int]?
    /// An array of ordinal numbers that filters which recurrences to include in the recurrence rule’s frequency. For example, a yearly recurrence rule that has a daysOfTheWeek value that specifies Monday through Friday, and a setPositions array containing 2 and -1, occurs only on the second weekday and last weekday of every year.
    let setPositions: [Int]?
    /// Indicates when the recurrence rule ends. This can be represented by an end date or a number of occurrences.
    let recurrenceEnd: RWMRecurrenceEnd?

    /// Initializes and returns a simple recurrence rule with a given frequency, interval, and end.
    ///
    /// - Parameters:
    ///   - type: Initializes and returns a simple recurrence rule with a given frequency, interval, and end.
    ///   - interval: The interval between instances of this recurrence. For example, a weekly recurrence rule with an interval of `2` occurs every other week. Must be greater than `0`.
    ///   - end: The end of the recurrence rule.
    public init?(recurrenceWith type: RWMRecurrenceFrequency, interval: Int?, end: RWMRecurrenceEnd?) {
        self.init(recurrenceWith: type, interval: interval, daysOfTheWeek: nil, daysOfTheMonth: nil, monthsOfTheYear: nil, weeksOfTheYear: nil, daysOfTheYear: nil, setPositions: nil, end: end, firstDay: nil)
    }

    /// Initializes and returns a recurrence rule with a given frequency and additional scheduling information.
    ///
    /// Returns `nil` is any invalid parameters are provided.
    ///
    /// Negative value indicate counting backwards from the end of the recurrence rule's frequency.
    ///
    /// - Parameters:
    ///   - type: The frequency of the recurrence rule. Can be daily, weekly, monthly, or yearly.
    ///   - interval: The interval between instances of this recurrence. For example, a weekly recurrence rule with an interval of `2` occurs every other week. Must be greater than `0`.
    ///   - days: The days of the week that the event occurs, as an array of `RWMRecurrenceDayOfWeek` objects.
    ///   - monthDays: The days of the month that the event occurs, as an array of `Int`. Values can be from 1 to 31 and from -1 to -31. This parameter is not valid for recurrence rules of type `.weekly`.
    ///   - months: The months of the year that the event occurs, as an array of `Int`. Values can be from 1 to 12.
    ///   - weeksOfTheYear: The weeks of the year that the event occurs, as an array of `Int`. Values can be from 1 to 53 and from -1 to -53. This parameter is only valid for recurrence rules of type `.yearly`.
    ///   - daysOfTheYear: The days of the year that the event occurs, as an array of `Int`. Values can be from 1 to 366 and from -1 to -366. This parameter is only valid for recurrence rules of type `.yearly`.
    ///   - setPositions: An array of ordinal numbers that filters which recurrences to include in the recurrence rule’s frequency. See `setPositions` for more information.
    ///   - end: The end of the recurrence rule.
    ///   - firstDay: Indicates what day of the week to be used as the first day of a week. Defaults to Monday.
    public init?(recurrenceWith type: RWMRecurrenceFrequency, interval: Int?, daysOfTheWeek days: [RWMRecurrenceDayOfWeek]?, daysOfTheMonth monthDays: [Int]?, monthsOfTheYear months: [Int]?, weeksOfTheYear: [Int]?, daysOfTheYear: [Int]?, setPositions: [Int]?, end: RWMRecurrenceEnd?, firstDay: RWMWeekday?) {
        // NOTE - See https://icalendar.org/iCalendar-RFC-5545/3-3-10-recurrence-rule.html

        if let interval = interval, interval <= 0 { return nil } // If specified, INTERVAL must be 1 or more
        if let days = days {
            // In daily or weekly mode or in yearly mode with week numbers, the days should not have a week number.
            if (type != .monthly && type != .yearly) || (type == .yearly && weeksOfTheYear != nil) {
                for day in days {
                    if day.weekNumber != 0 { return nil }
                }
            }
        }
        if let daysOfMonth = monthDays {
            guard type != .weekly else { return nil }

            for day in daysOfMonth {
                if day < -31 || day > 31 || day == 0 { return nil }
            }
        }
        if let monthsOfYear = months {
            for month in monthsOfYear {
                if month < 1 || month > 12 { return nil }
            }
        }
        if let weeksOfTheYear = weeksOfTheYear {
            guard type == .yearly else { return nil }

            for week in weeksOfTheYear {
                if week < -53 || week > 53 || week == 0 { return nil }
            }
        }
        if let daysOfTheYear = daysOfTheYear {
            // Also supported by secondly, minutely, and hourly
            guard type == .yearly else { return nil }

            for day in daysOfTheYear {
                if day < -366 || day > 366 || day == 0 { return nil }
            }
        }
        if let setPositions = setPositions {
            for pos in setPositions {
                if pos < -366 || pos > 366 || pos == 0 { return nil }
            }
        }

        self.frequency = type
        self.interval = interval
        self.firstDayOfTheWeek = firstDay
        self.daysOfTheWeek = days
        self.daysOfTheMonth = monthDays
        self.daysOfTheYear = daysOfTheYear
        self.weeksOfTheYear = weeksOfTheYear
        self.monthsOfTheYear = months
        self.setPositions = setPositions
        self.recurrenceEnd = end
    }

    public static func==(lhs: RWMRecurrenceRule, rhs: RWMRecurrenceRule) -> Bool {
        return
            lhs.frequency == rhs.frequency &&
            lhs.interval == rhs.interval &&
            lhs.firstDayOfTheWeek == rhs.firstDayOfTheWeek &&
            lhs.daysOfTheWeek == rhs.daysOfTheWeek &&
            lhs.daysOfTheMonth == rhs.daysOfTheMonth &&
            lhs.daysOfTheYear == rhs.daysOfTheYear &&
            lhs.weeksOfTheYear == rhs.weeksOfTheYear &&
            lhs.monthsOfTheYear == rhs.monthsOfTheYear &&
            lhs.setPositions == rhs.setPositions &&
            lhs.recurrenceEnd == rhs.recurrenceEnd
    }
}
