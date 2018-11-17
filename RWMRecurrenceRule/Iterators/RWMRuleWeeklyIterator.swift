//
//  RWMRuleWeeklyIterator.swift
//  RWMRecurrenceRule
//
//  Created by Andrey Gordeev on 17/11/2018.
//

import Foundation

class RWMRuleWeeklyIterator: RWMRuleIterator {
    let exclusionDates: [Date]?
    let mode: RWMRuleScheduler.Mode

    init(exclusionDates: [Date]?, mode: RWMRuleScheduler.Mode) {
        self.exclusionDates = exclusionDates
        self.mode = mode
    }

    func enumerateDates(with rule: RWMRecurrenceRule, startingFrom start: Date, calendar: Calendar, using block: EnumerationBlock) {
        var result = start // first result is the start date
        let startWeekday = calendar.component(.weekday, from: start)

        var weekdays = [Int]() // 0-6 representing the required week days. 0 is WKST/Calendar.firstWeekday
        let daysOfTheWeek: [Int]
        if let days = rule.daysOfTheWeek {
            daysOfTheWeek = days.map { $0.dayOfTheWeek.rawValue }
        } else {
            daysOfTheWeek = [ startWeekday ]
        }

        var sow: Date
        if mode == .standard {
            let sowcomps = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear, .hour, .minute, .second], from: start)
            sow = calendar.date(from: sowcomps)! // First day of the week containing the start date

            // The rule includes specific weekdays. Based on the rule's WKST (or Calendar.firstWeekday if WKST is 0),
            // we need to convert the chosen BYDAY weekdays into indexes 0 - 6 where 0 is the determined first day of the week.
            // Examples:
            // If WKST is Sunday then index 0=Sun, 1=Mon, 2=Tue, ..., 6=Sat
            // If WKST is Monday then index 0=Mon, 1=Tue, 2=Wed, ..., 6=Sun
            let firstDayOfTheWeek = rule.firstDayOfTheWeek?.rawValue ?? calendar.firstWeekday
            // Convert the standard 1=Sun,2=Mon,...,7=Sat values into the associated weekday index based on the first day of the week
            for wd in firstDayOfTheWeek..<(firstDayOfTheWeek + 7) {
                if daysOfTheWeek.first(where: { $0 == wd % 7 }) != nil {
                    weekdays.append(wd - firstDayOfTheWeek)
                }
            }
        } else {
            sow = start

            for wd in 0..<7 {
                if daysOfTheWeek.contains(((startWeekday + wd - 1) % 7) + 1) {
                    weekdays.append(wd)
                }
            }
        }

        var weekDates = [Date]()
        var dateIndex = 0

        // 7 days per interval
        let interval = (rule.interval ?? 1) * 7
        var count = 0
        var done = false
        repeat {
            if dateIndex < weekDates.count {
                result = weekDates[dateIndex]
                dateIndex += 1
            } else {
                var attempts = 0
                weekDates = []
                while weekDates.count == 0 && attempts < 50 {
                    for weekday in weekdays {
                        if let date = calendar.date(byAdding: .day, value: weekday, to: sow) {
                            weekDates.append(date)
                        }
                    }

                    if let months = rule.monthsOfTheYear {
                        weekDates = weekDates.filter {
                            let month = calendar.component(.month, from: $0)
                            return months.contains(month)
                        }
                    }

                    if count == 0 {
                        weekDates = weekDates.filter { $0 > start }
                        weekDates.insert(start, at: 0)
                    }

                    weekDates.sort()
                    if let poss = rule.setPositions {
                        var matches = Set<Date>()
                        for pos in poss {
                            let index = pos > 0 ? pos - 1 : weekDates.count + pos
                            if index >= 0 && index < weekDates.count {
                                matches.insert(weekDates[index])
                            }
                        }

                        weekDates = matches.sorted()
                    }

                    sow = calendar.date(byAdding: .day, value: interval, to: sow)!
                    attempts += 1
                }

                if weekDates.count == 0 {
                    done = true
                    break
                } else {
                    result = weekDates[0]
                    dateIndex = 1
                }
            }

            // Check if we are past the end date or we have returned the desired count
            if let stopDate = rule.recurrenceEnd?.endDate {
                if result > stopDate {
                    done = true
                    break
                }
            }

            // Send the current result
            var stop = false
            if !isExclusionDate(date: result, calendar: calendar) {
                block(result, &stop)
            }
            if (stop) {
                done = true
            }
            count += 1

            if let stopCount = rule.recurrenceEnd?.count, stopCount > 0 {
                if count >= stopCount {
                    done = true
                }
            }
        } while !done
    }
}
