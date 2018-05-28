//
//  RWMRecurrenceRuleBase.swift
//  RWMRecurrenceRuleTests
//
//  Created by Richard W Maddy on 5/13/18.
//  Copyright © 2018 Maddysoft. All rights reserved.
//

import XCTest
import EventKit

// Helpful site to verify results: http://worthfreeman.com/projects/online-icalendar-recurrence-event-parser/

class RWMRecurrenceRuleBase: XCTestCase {
    let calendar = Calendar(identifier: .gregorian)
    let scheduler = RWMRuleScheduler()
    let formatter: DateFormatter = {
        let res = DateFormatter()
        res.locale = Locale(identifier: "en_US_POSIX")
        res.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"

        return res
    }()

    func run(rule: String, start: Date, max: Int = 200, results: [String]) {
        run(rule: rule) { (rule) in
            var dates = [Date]()
            scheduler.enumerateDates(with: rule, startingFrom: start, using: { (date, stop) in
                if let date = date {
                    dates.append(date)
                    if dates.count >= max {
                        stop = true
                    }
                }
            })

            let list = dates.map { formatter.string(from: $0) }
            XCTAssert(list == results, "Incorrect results. Expected \(results), generated \(list)")
        }
    }

    func run(rule: String, start: Date, last: Date? = nil, count: Int, max: Int = 200) {
        run(rule: rule) { (rule) in
            var dates = [Date]()
            scheduler.enumerateDates(with: rule, startingFrom: start, using: { (date, stop) in
                if let date = date {
                    dates.append(date)
                    if dates.count >= max {
                        stop = true
                    }
                }
            })

            XCTAssert(dates.count == count, "Should be \(count) dates - \(dates.count)")
            XCTAssert(dates.first == start, "Wrong first date")
            if let last = last {
                XCTAssert(dates.last == last, "Wrong last date \(dates.last?.description ?? "??"), expected \(last)")
            }

            let list = dates.map { formatter.string(from: $0) }
            print("Results: [\(list.map { "\"\($0)\"" }.joined(separator: ", "))]")
        }
    }

    func run(rule: String, valid: (RWMRecurrenceRule) -> ()) {
        let parser = RWMRuleParser()
        if let rules = parser.parse(rule: rule) {
            let str = parser.rule(from: rules)
            if parser.compare(rule: rule, to: str) {
                valid(rules)
            } else {
                XCTAssert(false, "\(str) doesn't match \(rule)")
            }

            if let ekrule = EKRecurrenceRule(recurrenceWith: rule) {
                if let _/*rwmrule*/ = RWMRecurrenceRule(recurrenceWith: ekrule) {
                    // TODO - for now any rule with WKST causes a difference due to EKRecurrenceRule not supported a writable start weekday
                    //XCTAssert(rwmrule == rules, "rules and rwmrule are not the same: \(parser.rule(from: rules) ?? "X") and \(parser.rule(from: rwmrule) ?? "Y")")
                } else {
                    XCTAssert(false, "Couldn't create RWMRecurrenceRule from EKRecurrenceRule")
                }
            } else {
                XCTAssert(false, "Couldn't create EKRecurrenceRule from \(rule)")
            }
        } else {
            XCTAssert(false, "Couldn't parse \(rule)")
        }
    }

}
