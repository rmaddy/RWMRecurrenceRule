//
//  EKRecurrenceRule+RWM.swift
//  RWMRecurrenceRule
//
//  Created by Richard W Maddy on 5/13/18.
//  Copyright © 2018 Maddysoft. All rights reserved.
//

import Foundation
import EventKit

public extension EKRecurrenceRule {
    /// This convenience initializer allows you to create an EKRecurrenceRule from a standard iCalendar RRULE
    /// string. Please see https://icalendar.org/iCalendar-RFC-5545/3-3-10-recurrence-rule.html for a reference
    /// to the RRULE syntax.
    /// Only frequencies of DAILY, WEEKLY, MONTHLY, and YEARLY are supported. Also note that there are many valid
    /// RRULE strings that will parse but EventKit may not process correctly.
    ///
    /// If `rrule` is an invalid RRULE, the result is `nil`.
    ///
    /// See `RWMRecurrenceRule isEventKitSafe` for details about RRULE values safe to be used with Event Kit.
    ///
    /// - Parameter rrule: The RRULE string in the form RRULE:FREQUENCY=...
    public convenience init?(recurrenceWith rrule: String) {
        if let rule = RWMRuleParser().parse(rule: rrule) {
            self.init(recurrenceWith: rule)
        } else {
            return nil
        }
    }

    /// Creates a new EKRecurrenceRule from a RWMRecurrenceRule. If `rule` can't be converted, the result is `nil`.
    ///
    /// Note that Event Kit may not properly process some recurrence rules.
    ///
    /// - Parameter rule: The RWMRecurrenceRule.
    public convenience init?(recurrenceWith rule: RWMRecurrenceRule) {
        var daysOfTheWeek: [EKRecurrenceDayOfWeek]?
        if let dows = rule.daysOfTheWeek {
            daysOfTheWeek = []
            for dow in dows {
                if let ekwd = EKWeekday(rawValue: dow.dayOfTheWeek.rawValue) {
                    daysOfTheWeek?.append(EKRecurrenceDayOfWeek(dayOfTheWeek: ekwd, weekNumber: dow.weekNumber))
                } else {
                    return nil
                }
            }
        }

        let end: EKRecurrenceEnd?
        if let rend = rule.recurrenceEnd {
            if let date = rend.endDate {
                end = EKRecurrenceEnd(end: date)
            } else {
                end = EKRecurrenceEnd(occurrenceCount: rend.count)
            }
        } else {
            end = nil
        }

        if let frequency = EKRecurrenceFrequency(rawValue: rule.frequency.rawValue) {
            self.init(recurrenceWith: frequency, interval: rule.interval ?? 1, daysOfTheWeek: daysOfTheWeek, daysOfTheMonth: rule.daysOfTheMonth as [NSNumber]?, monthsOfTheYear: rule.monthsOfTheYear as [NSNumber]?, weeksOfTheYear: rule.weeksOfTheYear as [NSNumber]?, daysOfTheYear: rule.daysOfTheYear as [NSNumber]?, setPositions: rule.setPositions as [NSNumber]?, end: end)
        } else {
            return nil
        }
    }

    /// Returns the RRULE representation. If the sender can't be processed, the result is `nil`.
    public var rrule: String? {
        if let rule = RWMRecurrenceRule(recurrenceWith: self) {
            let parser = RWMRuleParser()

            return parser.rule(from: rule)
        } else {
            return nil
        }
    }
}

public extension RWMRecurrenceRule {
    /// Creates a new RWMRecurrenceRule from an EKRecurrenceRule. If `rule` can't be converted, the result is `nil`.
    ///
    /// - Parameter rule: The EKRecurrenceRule
    public init?(recurrenceWith rule: EKRecurrenceRule) {
        var daysOfTheWeek: [RWMRecurrenceDayOfWeek]?
        if let dows = rule.daysOfTheWeek {
            daysOfTheWeek = []
            for dow in dows {
                if let rwmwd = RWMWeekday(rawValue: dow.dayOfTheWeek.rawValue) {
                    daysOfTheWeek?.append(RWMRecurrenceDayOfWeek(dayOfTheWeek: rwmwd, weekNumber: dow.weekNumber))
                } else {
                    return nil
                }
            }
        }

        let end: RWMRecurrenceEnd?
        if let rend = rule.recurrenceEnd {
            if let date = rend.endDate {
                end = RWMRecurrenceEnd(end: date)
            } else {
                end = RWMRecurrenceEnd(occurrenceCount: rend.occurrenceCount)
            }
        } else {
            end = nil
        }

        if let frequency = RWMRecurrenceFrequency(rawValue: rule.frequency.rawValue) {
            // For weekly recurrence rules with days of the week set, set the rule's firstDay if the current calendar
            // starts its week on a day other than Monday.
            var firstDay: RWMWeekday? = nil
            if frequency == .weekly && daysOfTheWeek != nil && Calendar.current.firstWeekday != 2 {
                firstDay = RWMWeekday(rawValue: Calendar.current.firstWeekday)
            }

            self.init(recurrenceWith: frequency, interval: rule.interval == 1 ? nil : rule.interval, daysOfTheWeek: daysOfTheWeek, daysOfTheMonth: rule.daysOfTheMonth as! [Int]?, monthsOfTheYear: rule.monthsOfTheYear as! [Int]?, weeksOfTheYear: rule.weeksOfTheYear as! [Int]?, daysOfTheYear: rule.daysOfTheYear as! [Int]?, setPositions: rule.setPositions as! [Int]?, end: end, firstDay: firstDay)
        } else {
            return nil
        }
    }

    /*
     Sample events created through the iOS Calendar app
     A - RRULE FREQ=DAILY;INTERVAL=1;UNTIL=20180629T055959Z
     B - RRULE FREQ=WEEKLY;INTERVAL=1;UNTIL=20180822T055959Z
     C - RRULE FREQ=WEEKLY;INTERVAL=2;UNTIL=20180922T055959Z
     D - RRULE FREQ=MONTHLY;INTERVAL=1;UNTIL=20200522T055959Z
     E - RRULE FREQ=YEARLY;INTERVAL=1;UNTIL=20230521T180000Z
     F - RRULE FREQ=DAILY;INTERVAL=3;UNTIL=20180722T055959Z
     G - RRULE FREQ=WEEKLY;INTERVAL=2;UNTIL=20180822T055959Z;BYDAY=SU,WE,SA;WKST=SU
     H - RRULE FREQ=MONTHLY;INTERVAL=2;UNTIL=20190622T055959Z;BYMONTHDAY=10,15,20
     I - RRULE FREQ=MONTHLY;INTERVAL=3;UNTIL=20190622T055959Z;BYDAY=TU;BYSETPOS=2
     J - RRULE FREQ=MONTHLY;INTERVAL=1;BYDAY=SU,MO,TU,WE,TH,FR,SA;BYSETPOS=-1
     K - RRULE FREQ=MONTHLY;INTERVAL=1;UNTIL=20190622T055959Z;BYDAY=SU,SA;BYSETPOS=3
     L - RRULE FREQ=YEARLY;INTERVAL=2;UNTIL=20230622T055959Z;BYMONTH=9,10,11
     M - RRULE FREQ=YEARLY;INTERVAL=1;UNTIL=20190622T055959Z;BYMONTH=5,7;BYDAY=1WE
     */

    /// Indicates whether the recurrence rule is safe to use with Event Kit and EKRecurrenceRule. Event Kit and the
    /// Calendar apps of iOS and macOS provide support for a subset of the possible iCalendar RRULE possibilties.
    /// A return value of `true` indicates that this recurrence rule is safe to use with Event Kit. A return value of
    /// `false` means the recurrence rule may or may not result in recurring events supported by Event Kit.
    ///
    /// Event Kit is known to support the following possible types of recurrence rules:
    /// Daily with an interval. Example: `RRULE:FREQ=DAILY;INTERVAL=1`
    /// Weekly with an interval. Example: `RRULE:FREQ=WEEKLY;INTERVAL=1`
    /// Weekly with an interval and specific days of the week. Example: `RRULE:FREQ=WEEKLY;INTERVAL=2;BYDAY=SU,WE,SA`
    /// Monthly with an interval. Example: `RRULE:FREQ=MONTHLY;INTERVAL=1`
    /// Monthly with an interval and specific days of the month. Example: `RRULE:FREQ=MONTHLY;INTERVAL=2;BYMONTHDAY=10,15,20`
    /// Monthly with an interval and 1st, 2nd, 3rd, 4th, 5th, or last day of the week. Example: `RRULE:FREQ=MONTHLY;INTERVAL=3;BYDAY=TU;BYSETPOS=2`
    /// Monthly with an interval and 1st, 2nd, 3rd, 4th, 5th, or last day. Example: `RRULE:FREQ=MONTHLY;INTERVAL=3;BYDAY=SU,MO,TU,WE,TH,FR,SA;BYSETPOS=-1`
    /// Monthly with an interval and 1st, 2nd, 3rd, 4th, 5th, or last weekday. Example: `RRULE:FREQ=MONTHLY;INTERVAL=3;BYDAY=MO,TU,WE,TH,FR;BYSETPOS=-1`
    /// Monthly with an interval and 1st, 2nd, 3rd, 4th, 5th, or last weekend. Example: `RRULE:FREQ=MONTHLY;INTERVAL=3;BYDAY=SU,SA;BYSETPOS=3`
    /// Yearly with an interval. Example: `RRULE:FREQ=YEARLY;INTERVAL=1`
    /// Yearly with an interval and specific months. Example: `RRULE:FREQ=YEARLY;INTERVAL=1;BYMONTH=9,10,11`
    /// Yearly with an interval, specific months, and 1st, 2nd, 3rd, 4th, 5th, or last day of the week. Example: `RRULE:FREQ=YEARLY;INTERVAL=1;BYMONTH=9,10,11;BYDAY=1WE`
    /// Yearly with an interval, specific months, and 1st, 2nd, 3rd, 4th, 5th, or last day. Example: `RRULE:FREQ=YEARLY;INTERVAL=1;BYMONTH=9,10,11;BYDAY=SU,MO,TU,WE,TH,FR,SA;BYSETPOS=2`
    /// Yearly with an interval, specific months, and 1st, 2nd, 3rd, 4th, 5th, or last weekday. Example: `RRULE:FREQ=YEARLY;INTERVAL=1;BYMONTH=9,10,11;BYDAY=MO,TU,WE,TH,FR;BYSETPOS=2`
    /// Yearly with an interval, specific months, and 1st, 2nd, 3rd, 4th, 5th, or last weekend. Example: `RRULE:FREQ=YEARLY;INTERVAL=1;BYMONTH=9,10,11;BYDAY=SU,SA;BYSETPOS=-1`
    public var isEventKitSafe: Bool {
        get {
            switch frequency {
            case .daily:
                // Only allow an interval
                if daysOfTheWeek != nil || daysOfTheMonth != nil || daysOfTheYear != nil || weeksOfTheYear != nil || monthsOfTheYear != nil || setPositions != nil {
                    return false
                }
            case .weekly:
                // Only allow interval and daysOfTheWeek
                if daysOfTheMonth != nil || daysOfTheYear != nil || weeksOfTheYear != nil || monthsOfTheYear != nil || setPositions != nil {
                    return false
                }
            case .monthly:
                // Allow interval, daysOfTheWeek, and daysOfTheMonth
                if daysOfTheYear != nil || weeksOfTheYear != nil || monthsOfTheYear != nil {
                    return false
                }
                // If daysOfTheWeek is set, ensure no week numbers are set. Also ensure the days represent either a
                // single day, all days (SU-SA), all weekdays (MO-FR), or the weekend (SA and SU).
                if let days = daysOfTheWeek {
                    var weekdays = Set<RWMWeekday>()
                    for day in days {
                        if day.weekNumber != 0 {
                            return false
                        }
                        weekdays.insert(day.dayOfTheWeek)
                    }

                    if weekdays.count == 5 {
                        if weekdays.contains(.saturday) || weekdays.contains(.sunday) {
                            return false
                        }
                    } else if weekdays.count == 2 {
                        if !(weekdays.contains(.saturday) && weekdays.contains(.sunday)) {
                            return false
                        }
                    } else if weekdays.count != 1 && weekdays.count != 7 {
                        return false
                    }
                }
                // If setPositions is set, only allow 1 value and make sure it is -1, 1, 2, 3, 4, or 5.
                // Only allow setPositions if there are days of the week.
                if let poss = setPositions {
                    let daysCount = daysOfTheWeek?.count ?? 0
                    if poss.count > 1 || daysCount == 0 {
                        return false
                    } else {
                        if poss[0] < -1 || poss[0] > 5 {
                            return false
                        }
                    }
                }
            case .yearly:
                // Allow interval, daysOfTheWeek, and monthsOfTheYear
                if daysOfTheMonth != nil || daysOfTheYear != nil || weeksOfTheYear != nil {
                    return false
                }
                // If daysOfTheWeek is set, ensure no week numbers are set unless for a single weekday. Also ensure the
                // days represent either a single day, all days (SU-SA), all weekdays (MO-FR), or the weekend (SA and SU).
                if let days = daysOfTheWeek {
                    var weekdays = Set<RWMWeekday>()
                    for day in days {
                        if day.weekNumber != 0 && days.count != 1 {
                            return false
                        }
                        weekdays.insert(day.dayOfTheWeek)
                    }

                    if weekdays.count == 5 {
                        if weekdays.contains(.saturday) || weekdays.contains(.sunday) {
                            return false
                        }
                    } else if weekdays.count == 2 {
                        if !(weekdays.contains(.saturday) && weekdays.contains(.sunday)) {
                            return false
                        }
                    } else if weekdays.count != 1 && weekdays.count != 7 {
                        return false
                    }
                }
                // If setPositions is set, only allow 1 value and make sure it is -1, 1, 2, 3, 4, or 5.
                // Only allow setPositions if there is more than one day of the week.
                if let poss = setPositions {
                    let daysCount = daysOfTheWeek?.count ?? 0
                    if poss.count > 1 || daysCount <= 1 {
                        return false
                    } else {
                        if poss[0] < -1 || poss[0] > 5 {
                            return false
                        }
                    }
                }
            }

            return true
        }
    }
}
