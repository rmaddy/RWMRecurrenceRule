//
//  RWMRuleYearlyIterator.swift
//  RWMRecurrenceRule
//
//  Created by Andrey Gordeev on 17/11/2018.
//

import Foundation

class RWMRuleYearlyIterator: RWMRuleIterator {
    let exclusionDates: [Date]?

    init(exclusionDates: [Date]?) {
        self.exclusionDates = exclusionDates
    }

    func enumerateDates(with rule: RWMRecurrenceRule, startingFrom start: Date, calendar: Calendar, using block: EnumerationBlock) {
        var result = start
        var yearDates = [Date]()
        var dateIndex = 0

        let startComps = calendar.dateComponents([ .year, .month, .day ], from: start)
        let startDay = startComps.day!
        var year = startComps.year!

        let interval = (rule.interval ?? 1)
        // Gets incremented on each iteration
        var iterationCount = 0
        // Gets incremented when callback block is executed
        var recurrenceCount = 0

        var daysOfTheMonth = rule.daysOfTheMonth
        var monthsOfTheYear = rule.monthsOfTheYear

        if rule.daysOfTheMonth == nil && rule.daysOfTheWeek == nil && rule.daysOfTheYear == nil && rule.monthsOfTheYear == nil && rule.weeksOfTheYear == nil {
            daysOfTheMonth = [ startDay ]
            monthsOfTheYear = [ startComps.month! ]
        }

        repeat {
            if dateIndex < yearDates.count {
                result = yearDates[dateIndex]
                dateIndex += 1
            } else {
                var attempts = 0
                yearDates = []
                while yearDates.count == 0 && attempts < 50 {
                    var yearComps = calendar.dateComponents([.year, .hour, .minute, .second], from: start)
                    yearComps.year = year
                    let startOfYear = calendar.date(from: DateComponents(year: year, month: 1, day: 1, hour: yearComps.hour!, minute: yearComps.minute!, second: yearComps.second!))!

                    if let weekNos = rule.weeksOfTheYear {
                        let lastDayOfYear = calendar.date(from: DateComponents(year: year, month: 12, day: 31))!
                        let lastWeek = calendar.component(.weekOfYear, from: lastDayOfYear)
                        let weeksRange = calendar.range(of: .weekOfYear, in: .yearForWeekOfYear, for: startOfYear)!
                        let weeksInYear = lastWeek == 1 ? CountableRange(weeksRange).last! : lastWeek
                        var weekComps = DateComponents(/*year: year, */hour: yearComps.hour!, minute: yearComps.minute!, second: yearComps.second!, yearForWeekOfYear: year)
                        weekComps.weekday = rule.firstDayOfTheWeek?.rawValue ?? calendar.firstWeekday
                        for weekNo in weekNos {
                            weekComps.weekOfYear = weekNo > 0 ? weekNo : weekNo + 1 + weeksInYear
                            if let startOfWeek = calendar.date(from: weekComps) {
                                //if let startOfWeek = self.nextDate(after: startOfYear, matching: weekComps, matchingPolicy: .strict) {
                                if calendar.date(startOfWeek, matchesComponents: yearComps) {
                                    yearDates.append(startOfWeek)
                                    for inc in 1...6 {
                                        if let nextDate = calendar.date(byAdding: .day, value: inc, to: startOfWeek) {
                                            if calendar.date(nextDate, matchesComponents: yearComps) {
                                                yearDates.append(nextDate)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }

                    var someDatesAdded = yearDates.count > 0

                    if let yearDays = rule.daysOfTheYear {
                        var dayOfYearDates = [Date]()
                        var comps = yearComps
                        for yearDay in yearDays {
                            comps.day = yearDay
                            if let date = calendar.date(fromRelative: comps) {
                                if calendar.date(date, matchesComponents: yearComps) {
                                    dayOfYearDates.append(date)
                                }
                            }
                        }
                        if yearDates.count > 0 {
                            yearDates = yearDates.filter { dayOfYearDates.contains($0) }
                        } else {
                            yearDates.append(contentsOf: dayOfYearDates)
                        }

                        someDatesAdded = someDatesAdded || yearDates.count > 0
                    }

                    if let months = monthsOfTheYear ?? (daysOfTheMonth != nil ? Array(1...12) : nil) {
                        if yearDates.count > 0 {
                            // filter existing dates
                            let days: [Int]
                            if let daysOfTheMonth = daysOfTheMonth {
                                days = daysOfTheMonth
                                //} else if rule.daysOfTheWeek == nil {
                                //    days = [startDay]
                            } else {
                                days = Array(1...31)
                            }
                            let filtered = yearDates.filter {
                                let comps = calendar.dateComponents([.month, .day], from: $0)
                                return months.contains(comps.month!) && days.contains(comps.day!)
                            }
                            yearDates = filtered
                        } else if !someDatesAdded {
                            // create dates for every day of each month
                            for month in months {
                                var monthComps = yearComps
                                monthComps.month = month
                                monthComps.day = 1
                                if let startOfMonth = calendar.date(from: monthComps) {
                                    let days: [Int]
                                    if let daysOfTheMonth = rule.daysOfTheMonth {
                                        let range = calendar.range(of: .day, in: .month, for: startOfMonth)!
                                        days = daysOfTheMonth.map { $0 > 0 ? $0 : range.count + $0 + 1 }.filter { range.contains($0) }
                                    } else if rule.daysOfTheWeek == nil {
                                        days = [startDay]
                                    } else {
                                        let range = calendar.range(of: .day, in: .month, for: startOfMonth)!
                                        days = Array(CountableRange(range).indices)
                                    }
                                    for day in days {
                                        monthComps.day = day
                                        if let nextDate = calendar.date(from: monthComps) {
                                            yearDates.append(nextDate)
                                        }
                                    }
                                }
                            }

                            someDatesAdded = someDatesAdded || yearDates.count > 0
                        }
                    }

                    if let daysOfTheWeek = rule.daysOfTheWeek {
                        if yearDates.count > 0 {
                            let filtered = yearDates.filter {
                                let comps = calendar.dateComponents([.year, .month, .weekday, .weekdayOrdinal ], from: $0)
                                var numWeeksComps = comps
                                numWeeksComps.weekdayOrdinal = -1
                                let lastWeekDate = calendar.date(from: numWeeksComps)!
                                let numWeeks = calendar.component(.weekdayOrdinal, from: lastWeekDate)
                                for dayOfTheWeek in daysOfTheWeek {
                                    if dayOfTheWeek.weekNumber == 0 {
                                        if comps.weekday! == dayOfTheWeek.dayOfTheWeek.rawValue {
                                            return true
                                        }
                                    } else {
                                        let weekNo = dayOfTheWeek.weekNumber > 0 ? dayOfTheWeek.weekNumber : dayOfTheWeek.weekNumber + numWeeks + 1
                                        if comps.weekday! == dayOfTheWeek.dayOfTheWeek.rawValue && comps.weekdayOrdinal! == weekNo {
                                            return true
                                        }
                                    }
                                }

                                return false
                            }
                            yearDates = filtered
                        } else if !someDatesAdded {
                            var partialComps = calendar.dateComponents([.year, .hour, .minute, .second], from: startOfYear)
                            for weekday in daysOfTheWeek {
                                let weekdayStart: Int
                                let weekdayEnd: Int
                                if weekday.weekNumber == 0 {
                                    weekdayStart = 1
                                    weekdayEnd = 54
                                } else {
                                    weekdayStart = weekday.weekNumber
                                    weekdayEnd = weekdayStart
                                }

                                partialComps.weekday = weekday.dayOfTheWeek.rawValue
                                for wd in stride(from: weekdayStart, through: weekdayEnd, by: 1) {
                                    var date: Date?
                                    if wd > 0 {
                                        partialComps.weekdayOrdinal = wd
                                        date = calendar.date(from: partialComps)
                                    } else {
                                        var lastComps = partialComps
                                        lastComps.month = 12
                                        lastComps.weekdayOrdinal = -1
                                        let lastDay = calendar.date(from: lastComps)!
                                        date = calendar.date(byAdding: .day, value: (wd + 1) * 7, to: lastDay)
                                    }

                                    if let date = date {
                                        if calendar.date(date, matchesComponents: yearComps) {
                                            yearDates.append(date)
                                        }
                                    }
                                }
                            }
                        }

                        //someDatesAdded = someDatesAdded || yearDates.count > 0
                    }

                    yearDates.sort()
                    if let poss = rule.setPositions {
                        var matches = [Date]()
                        for pos in poss {
                            let index = pos > 0 ? pos - 1 : yearDates.count + pos
                            if index >= 0 && index < yearDates.count {
                                matches.append(yearDates[index])
                            }
                        }

                        yearDates = matches.sorted()
                    }

                    if iterationCount == 0 {
                        yearDates = yearDates.filter { $0 > start }
                        yearDates.insert(start, at: 0)
                        yearDates.sort()
                    }

                    year += interval
                    attempts += 1
                }

                if yearDates.count == 0 {
                    break
                } else {
                    result = yearDates[0]
                    dateIndex = 1
                }
            }

            // Check if we are past the end date or we have returned the desired count
            if let stopDate = rule.recurrenceEnd?.endDate {
                if result > stopDate {
                    break
                }
            }

            if !isExclusionDate(date: result, calendar: calendar) {
                // Send the current result
                var stop = false
                block(result, &stop)
                if (stop) {
                    break
                }
                recurrenceCount += 1
            }
            iterationCount += 1

            if let expectedStopCount = rule.recurrenceEnd?.count, expectedStopCount > 0 {
                if recurrenceCount >= expectedStopCount {
                    break
                }
            }
        } while true
    }
}
