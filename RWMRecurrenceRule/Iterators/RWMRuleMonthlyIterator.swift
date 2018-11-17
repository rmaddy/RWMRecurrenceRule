//
//  RWMRuleMonthlyIterator.swift
//  RWMRecurrenceRule
//
//  Created by Andrey Gordeev on 17/11/2018.
//

import Foundation

class RWMRuleMonthlyIterator: RWMRuleIterator {
    let exclusionDates: [Date]?

    init(exclusionDates: [Date]?) {
        self.exclusionDates = exclusionDates
    }

    func enumerateDates(with rule: RWMRecurrenceRule, startingFrom start: Date, calendar: Calendar, using block: EnumerationBlock) {
        var result = start
        var weekdays = [RWMRecurrenceDayOfWeek]()
        var monthDays = [Int]()
        var monthDates = [Date]()
        let monthsOfYear = rule.monthsOfTheYear ?? Array(1...12)
        var dateIndex = 0
        if let daysOfTheMonth = rule.daysOfTheMonth {
            monthDays = daysOfTheMonth
        }
        if let daysOfTheWeek = rule.daysOfTheWeek {
            for dayOfTheWeek in daysOfTheWeek {
                weekdays.append(dayOfTheWeek)
            }
        }

        var comps = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: start)
        comps.day = 1
        var som = calendar.date(from: comps)! // Start of month

        let interval = (rule.interval ?? 1)
        var count = 0

        repeat {
            if weekdays.count > 0 || monthDays.count > 0 {
                if dateIndex < monthDates.count {
                    result = monthDates[dateIndex]
                    guard !isExclusionDate(date: result, calendar: calendar) else { continue }
                    dateIndex += 1
                } else {
                    var attempts = 0
                    monthDates = []
                    while monthDates.count == 0 && attempts < 100 {
                        var monthComps = calendar.dateComponents([.year, .month, .hour, .minute, .second], from: som)
                        if monthsOfYear.contains(monthComps.month!) {
                            let range = calendar.range(of: .day, in: .month, for: som)!
                            let lastDay = range.count

                            if monthDays.count > 0 {
                                // First get all the dates for the supplied days of the month
                                for day in monthDays {
                                    if range.contains(day) {
                                        monthComps.day = day
                                    } else if -day >= 1 && -day < lastDay {
                                        monthComps.day = lastDay + day + 1
                                    } else {
                                        continue
                                    }

                                    if let date = calendar.date(from: monthComps) {
                                        if calendar.date(date, matchesComponents: monthComps) {
                                            monthDates.append(date)
                                        }
                                    }
                                }

                                // If specific days of the week have been provided, filter out the dates that don't match
                                if weekdays.count > 0 {
                                    let wds: [Int] = weekdays.compactMap { $0.weekNumber == 0 ? $0.dayOfTheWeek.rawValue : nil }
                                    let mds: [Int] = weekdays.compactMap {
                                        if $0.weekNumber != 0 {
                                            let comps = DateComponents(year: monthComps.year!, month: monthComps.month!, weekday: $0.dayOfTheWeek.rawValue, weekdayOrdinal: $0.weekNumber)
                                            let date = calendar.date(from: comps)!
                                            return calendar.component(.day, from: date)
                                        } else {
                                            return nil
                                        }
                                    }
                                    monthDates = monthDates.filter {
                                        let wcomps = calendar.dateComponents([ .weekday, .day ], from: $0)
                                        if wds.contains(wcomps.weekday!) {
                                            return true
                                        }
                                        if mds.contains(wcomps.day!) {
                                            return true
                                        }
                                        return false
                                    }
                                }
                            } else {
                                // Just specific weekdays
                                var partialComps = calendar.dateComponents([.year, .month, .hour, .minute, .second], from: som)
                                for weekday in weekdays {
                                    let weekdayStart: Int
                                    let weekdayEnd: Int
                                    if weekday.weekNumber == 0 {
                                        weekdayStart = 1
                                        weekdayEnd = 5
                                    } else {
                                        weekdayStart = weekday.weekNumber
                                        weekdayEnd = weekdayStart
                                    }

                                    partialComps.weekday = weekday.dayOfTheWeek.rawValue
                                    for wd in stride(from: weekdayStart, through: weekdayEnd, by: 1) {
                                        partialComps.weekdayOrdinal = wd

                                        if let date = calendar.date(from: partialComps) {
                                            if calendar.date(date, matchesComponents: monthComps) {
                                                monthDates.append(date)
                                            }
                                        }
                                    }
                                }
                            }

                            monthDates.sort()
                            if let poss = rule.setPositions {
                                var matches = [Date]()
                                for pos in poss {
                                    let index = pos > 0 ? pos - 1 : monthDates.count + pos
                                    if index >= 0 && index < monthDates.count {
                                        matches.append(monthDates[index])
                                    }
                                }

                                monthDates = matches.sorted()
                            }

                            if count == 0 {
                                monthDates = monthDates.filter { $0 > start }
                                monthDates.insert(start, at: 0)
                                monthDates.sort()
                            }
                        }

                        som = calendar.date(byAdding: .month, value: interval, to: som)!
                        attempts += 1
                    }

                    if monthDates.count == 0 {
                        break
                    } else {
                        result = monthDates[0]
                        guard !isExclusionDate(date: result, calendar: calendar) else { continue }
                        dateIndex = 1
                    }
                }
            } else if count > 0 {
                var found = false
                var base = result
                var tries = 0
                while !found && tries < 12 {
                    tries += 1
                    if let date = calendar.date(byAdding: .month, value: interval, to: base) {
                        let m = calendar.component(.month, from: date)
                        if monthsOfYear.contains(m) {
                            result = date
                            found = true
                        } else {
                            base = date
                        }
                    } else {
                        break
                    }
                }
                if !found {
                    break
                }
            }

            // Check if we are past the end date or we have returned the desired count
            if let stopDate = rule.recurrenceEnd?.endDate {
                if result > stopDate {
                    break
                }
            }

            // Send the current result
            var stop = false
            block(result, &stop)
            if (stop) {
                break
            }
            count += 1

            if let stopCount = rule.recurrenceEnd?.count, stopCount > 0 {
                if count >= stopCount {
                    break
                }
            }
        } while true
    }
}
