//
//  RWMRuleDailyIterator.swift
//  RWMRecurrenceRule
//
//  Created by Andrey Gordeev on 17/11/2018.
//

import Foundation

class RWMRuleDailyIterator: RWMRuleIterator {
    let exclusionDates: [Date]?

    init(exclusionDates: [Date]?) {
        self.exclusionDates = exclusionDates
    }

    func enumerateDates(with rule: RWMRecurrenceRule, startingFrom start: Date, calendar: Calendar, using block: EnumerationBlock) {
        // TODO - support BYSETPOS
        var result = start // first result is the start date
        let interval = rule.interval ?? 1
        var count = 0
        var done = false
        var daysOfTheWeek: [Int]? = nil
        if let days = rule.daysOfTheWeek {
            daysOfTheWeek = days.map { $0.dayOfTheWeek.rawValue }
        }

        repeat {
            // Check if we are past the end date or we have returned the desired count
            if let stopDate = rule.recurrenceEnd?.endDate {
                if result > stopDate {
                    break
                }
            } else if let stopCount = rule.recurrenceEnd?.count {
                if count >= stopCount {
                    break
                }
            }

            // send current result
            var stop = false
            if !isExclusionDate(date: result, calendar: calendar) {
                block(result, &stop)
            } else {
                count -= 1
            }
            if (stop) {
                break
            }

            var attempts = 0
            while attempts < 1000 {
                attempts += 1
                // Calculate the next date by adding "interval" days
                if let date = calendar.date(byAdding: .day, value: interval, to: result) {
                    result = date
                    guard !isExclusionDate(date: result, calendar: calendar) else { continue }

                    if let months = rule.monthsOfTheYear {
                        let rmonth = calendar.component(.month, from: result)
                        if !months.contains(rmonth) {
                            continue
                        }
                    }
                    if let monthDays = rule.daysOfTheMonth {
                        var found = false
                        let rday = calendar.component(.day, from: result)
                        for monthDay in monthDays {
                            if monthDay > 0 {
                                if monthDay == rday {
                                    found = true
                                    break
                                }
                            } else {
                                let range = calendar.range(of: .day, in: .month, for: result)!
                                let lastDay = range.count
                                if lastDay + monthDay + 1 == rday {
                                    found = true
                                    break
                                }
                            }
                        }
                        if !found {
                            continue
                        }
                    }
                    if let days = daysOfTheWeek {
                        let rdow = calendar.component(.weekday, from: result)
                        if !days.contains(rdow) {
                            continue
                        }
                    }

                    count += 1
                    break
                } else {
                    // This shouldn't happen since we should always be able to add x days to the current result
                    done = true
                    break
                }
            }
        } while !done
    }
}
