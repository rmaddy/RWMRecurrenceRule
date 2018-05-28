//
//  Calendar+RWM.swift
//  RWMRecurrenceRule
//
//  Created by Richard W Maddy on 5/19/18.
//  Copyright © 2018 Maddysoft. All rights reserved.
//

import Foundation

public extension Calendar {
    /// Returns the range of the given weekday for the supplied year or month of year.
    ///
    ///  Examples:
    ///    - To find out how many Tuesdays there are in 2018, pass in `3` for the `weekday` and `2018` for the `year` and the default of `0` for the `month`.
    ///    - To find out how many Saturdays there are in May of 2018, pass in `7` for the `weekday`, `2018` for the `year`, and `5` for the `month`.
    ///    - To find out how many Mondays there are in the last month of 2018, pass in `2` for the `weekday`, `2018` for the `year`, and `-1` for the `month`.
    ///
    /// - Parameters:
    ///   - weekday: The day of the week. Values range from 1 to 7, with Sunday being 1.
    ///   - year: A calendar year.
    ///   - month: A month within the calendar year. The value of `0` means the month is ignored. Negative values start from the last month of the year. `-1` is the last month. `-2` is the next-to-last month, etc.
    /// - Returns: A range from `1` through `n` where `n` is the number of times the given weekday appears in the year or month of the year. If `month` is out of range for the year, the result is `nil`.
    public func range(of weekday: Int, in year: Int, month: Int = 0) -> ClosedRange<Int>? {
        if month > 0 {
            let comps = DateComponents(year: year, month: month, weekday: weekday, weekdayOrdinal: -1)
            if let date = self.date(from: comps) {
                let count = self.component(.weekdayOrdinal, from: date)

                return 1...count
            }
        } else {
            // Get first day of year for the given weekday
            let startComps = DateComponents(year: year, month: 1, weekday: weekday, weekdayOrdinal: 1)
            // Get last day of year for the given weekday
            let finishComps = DateComponents(year: year, month: 12, weekday: weekday, weekdayOrdinal: -1)
            if let startDate = self.date(from: startComps), let finishDate = self.date(from: finishComps) {
                // Get the number of days between the two dates
                let days = self.dateComponents([.day], from: startDate, to: finishDate).day!

                return 1...(days / 7 + 1)
            }
        }

        return nil
    }

    /// Converts relative components to normalized components.
    ///
    /// The following relative components are normalized:
    ///   - year set, month set, weekday set, weekday ordinal set to +/- instance of weekday within month
    ///   - year set, no month, weekday set, weekday ordinal set to +/- instance of weekday within year
    ///   - year set, month set, day set to +/- day of month
    ///   - year set, no month, day set to +/- day of year
    ///
    /// All other components are returned as-is.
    ///
    /// - Parameter components: The relative date components.
    /// - Returns: The normalized date components.
    func relativeComponents(from components: DateComponents) -> DateComponents {
        var newComponents = components

        if let year = components.year {
            if let weekday = components.weekday, let ordinal = components.weekdayOrdinal {
                if ordinal < 0 {
                    if let month = components.month {
                        if let rng = self.range(of: weekday, in: year, month: month) {
                            newComponents.weekdayOrdinal = rng.count + ordinal + 1
                        }
                    } else {
                        if let rng = self.range(of: weekday, in: year) {
                            newComponents.weekdayOrdinal = rng.count + ordinal + 1
                        }
                    }
                } else {
                    // Calendar already handles positive weekdayOrdinal
                }
            } else if let day = components.day {
                if components.weekday == nil {
                    if let month = components.month {
                        if day < 0 {
                            if let startOfMonth = self.date(from: DateComponents(year: year, month: month, day: 1)),
                                let daysInMonth = self.range(of: .day, in: .month, for: startOfMonth)?.count {
                                newComponents.day = daysInMonth + day + 1
                            }
                        } else {
                            // Calendar already handles positive day
                        }
                    } else {
                        if day < 0 {
                            if let startOfYear = self.date(from: DateComponents(year: year, month: 1, day: 1)),
                                let daysInYear = self.range(of: .day, in: .year, for: startOfYear)?.count {
                                newComponents.day = daysInYear + day + 1
                            }
                        } else {
                            // Calendar already handles positive day
                        }
                    }
                }
            }
        }

        return newComponents
    }

    public func date(fromRelative components: DateComponents) -> Date? {
        return self.date(from: self.relativeComponents(from: components))
    }

    public func date(_ date: Date, matchesRelativeComponents components: DateComponents) -> Bool {
        return self.date(date, matchesComponents: self.relativeComponents(from: components))
    }
}
