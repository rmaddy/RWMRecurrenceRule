//
//  RWMRuleIterator.swift
//  RWMRecurrenceRule
//
//  Created by Andrey Gordeev on 17/11/2018.
//

import Foundation

/// Used to enumerate through recurrence rule occurrences.
public typealias EnumerationBlock = (_ date: Date?, _ stop: inout Bool) -> Void

/// An abstract iterator.
protocol RWMRuleIterator {
    /// Dates that will be excluded from enumeration.
    var exclusionDates: [Date]? { get }
    func enumerateDates(with rule: RWMRecurrenceRule, startingFrom start: Date, calendar: Calendar, using block: EnumerationBlock)
}

extension RWMRuleIterator {
    /// Determines whether a given date is exclusion date.
    func isExclusionDate(date: Date, calendar: Calendar) -> Bool {
        guard let exclusionDates = exclusionDates else { return false }
        for exdate in exclusionDates {
            if calendar.isDate(date, equalTo: exdate, toGranularity: .day) {
                return true
            }
        }
        return false
    }
}
