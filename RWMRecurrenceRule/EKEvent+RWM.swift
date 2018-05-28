//
//  EKEvent+RWM.swift
//  RWMRecurrenceRule
//
//  Created by Richard W Maddy on 5/21/18.
//  Copyright © 2018 Maddysoft. All rights reserved.
//

import Foundation
import EventKit

public extension EKEvent {
    /// Provides the sequence of dates provided by this event. If the event has no recurrence then only the event's
    /// start date is returned. If the event has a recurrence rule, that rule is used to generate the recurring dates.
    /// The closure is called once for each date until the either the last date is returned or the enumeration is
    /// stopped. If there are no dates from the recurrence rule, then the closed will not be called at all.
    ///
    /// If the event has a recurrence rule, the event's `startDate` is used as the basis for the resulting dates.
    ///
    /// The enumeration can be stopped before the event's last recurring date by setting `stop` to `true` in the closure
    /// and returning. It is not necessary to set `stop` to `false` to keep the enumeration going.
    ///
    /// **Note:** EventKit does not provide an API to get its determination of recurring dates from the event. These
    /// dates are calculated separately based on the event's recurrence rule.
    ///
    /// - Parameter block: A closure that is called with each event date
    public func enumerateDates(using block: (_ date: Date?, _ stop: inout Bool) -> Void) {
        // According to the EventKit documentation, an event can only have 0 or 1 recurrence rules. This logic follows
        // that assumption.
        if let rules = self.recurrenceRules, rules.count > 0 {
            if let rule = RWMRecurrenceRule(recurrenceWith: rules[0]) {
                let scheduler = RWMRuleScheduler()
                scheduler.mode = .eventKit
                scheduler.enumerateDates(with: rule, startingFrom: self.startDate) { (date, stop) in
                    block(date, &stop)
                }
            }
        } else {
            // There is no recurrence rule so return just the event's start date.
            var stop = false
            block(self.startDate, &stop)
        }
    }

    /// Returns the next possible event date after the supplied date. If there are no recurrences after the date,
    /// the result is `nil`.
    ///
    /// - Parameter date: The date used to find the next occurrence.
    /// - Returns: The next recurrence date or `nil` if there are none after the supplied date.
    public func nextRecurrence(after date: Date = Date()) -> Date? {
        var result: Date? = nil

        self.enumerateDates { (rdate, stop) in
            if let rdate = rdate, rdate > date {
                result = rdate
                stop = true
            }
        }

        return result
    }

    /// Checks to see if the supplied date is among the recurring dates of the event.
    ///
    /// - Parameters:
    ///   - date: The date to check for.
    ///   - exact: `true` if the full date and time must match, `false` if the time is ignored.
    /// - Returns: `true` if the date is part of the event, `false` if not.
    public func includes(date: Date, exact: Bool = false) -> Bool {
        var result = false

        self.enumerateDates { (rdate, stop) in
            if let rdate = rdate {
                if (exact && rdate == date) || (!exact && Calendar.current.isDate(rdate, inSameDayAs: date)) {
                    result = true
                    stop = true
                } else if rdate > date {
                    stop = true
                }
            }
        }

        return result
    }
}
