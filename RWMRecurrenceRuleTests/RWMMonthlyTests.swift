//
//  RWMMonthlyTests.swift
//  RWMRecurrenceRuleTests
//
//  Created by Richard W Maddy on 5/17/18.
//  Copyright © 2018 Maddysoft. All rights reserved.
//

import XCTest

class RWMMonthlyTests: RWMRecurrenceRuleBase {
    // ----------- MONTHLY ------------

    // Monthly can use BYMONTH, BYMONTHDAY, BYDAY, BYSETPOS

    func testMonthly01() {
        // Start 20180517T090000
        // Monthly with no BYxxx clauses. Should give 3 months with same day as start date
        let start = calendar.date(from: DateComponents(year: 2018, month: 5, day: 17, hour: 9))!
        run(rule: "RRULE:FREQ=MONTHLY;COUNT=3", start: start, results:
            ["2018-05-17T09:00:00", "2018-06-17T09:00:00", "2018-07-17T09:00:00"]
        )
    }

    func testMonthly02() {
        // Start 20180517T090000
        // Once every three months
        let start = calendar.date(from: DateComponents(year: 2018, month: 5, day: 17, hour: 9))!
        run(rule: "RRULE:FREQ=MONTHLY;INTERVAL=3;COUNT=3", start: start, results:
            ["2018-05-17T09:00:00", "2018-08-17T09:00:00", "2018-11-17T09:00:00"]
        )
    }

    func testMonthly03() {
        // Start 20180517T090000
        // Start day each May and June
        let start = calendar.date(from: DateComponents(year: 2018, month: 5, day: 17, hour: 9))!
        run(rule: "RRULE:FREQ=MONTHLY;BYMONTH=5,6;COUNT=3", start: start, results:
            ["2018-05-17T09:00:00", "2018-06-17T09:00:00", "2019-05-17T09:00:00"]
        )
    }

    func testMonthly03a() {
        // Start 20180617T090000
        // Start day each May and June
        let start = calendar.date(from: DateComponents(year: 2018, month: 6, day: 17, hour: 9))!
        run(rule: "RRULE:FREQ=MONTHLY;INTERVAL=2;BYMONTH=1,3,5,7,9,11;COUNT=5", start: start, results:
            ["2018-06-17T09:00:00"/*, "2018-07-17T09:00:00", "2018-09-17T09:00:00", "2018-11-17T09:00:00",
             "2019-01-17T09:00:00"*/]
        )
    }

    func testMonthly04() {
        // Start 20180517T090000
        // 2nd, 4th, and 6th of each month
        let start = calendar.date(from: DateComponents(year: 2018, month: 5, day: 17, hour: 9))!
        run(rule: "RRULE:FREQ=MONTHLY;BYMONTHDAY=2,4,6;COUNT=10", start: start, results:
            ["2018-05-17T09:00:00", "2018-06-02T09:00:00", "2018-06-04T09:00:00", "2018-06-06T09:00:00",
             "2018-07-02T09:00:00", "2018-07-04T09:00:00", "2018-07-06T09:00:00", "2018-08-02T09:00:00",
             "2018-08-04T09:00:00", "2018-08-06T09:00:00"]
        )
    }

    func testMonthly05() {
        // Start 20180517T090000
        // 2nd and last day of each month
        let start = calendar.date(from: DateComponents(year: 2018, month: 5, day: 17, hour: 9))!
        run(rule: "RRULE:FREQ=MONTHLY;BYMONTHDAY=2,-1;COUNT=10", start: start, results:
            ["2018-05-17T09:00:00", "2018-05-31T09:00:00", "2018-06-02T09:00:00", "2018-06-30T09:00:00",
             "2018-07-02T09:00:00", "2018-07-31T09:00:00", "2018-08-02T09:00:00", "2018-08-31T09:00:00",
             "2018-09-02T09:00:00", "2018-09-30T09:00:00"]
        )
    }

    func testMonthly06() {
        // Start 20180517T090000
        // 2nd, 4th, and 6th of every other month
        let start = calendar.date(from: DateComponents(year: 2018, month: 5, day: 17, hour: 9))!
        run(rule: "RRULE:FREQ=MONTHLY;BYMONTHDAY=2,4,6;INTERVAL=2;COUNT=10", start: start, results:
            ["2018-05-17T09:00:00", "2018-07-02T09:00:00", "2018-07-04T09:00:00", "2018-07-06T09:00:00",
             "2018-09-02T09:00:00", "2018-09-04T09:00:00", "2018-09-06T09:00:00", "2018-11-02T09:00:00",
             "2018-11-04T09:00:00", "2018-11-06T09:00:00"]
        )
    }

    func testMonthly07() {
        // Start 20180517T090000
        // 2nd and last day of each 3rd month
        let start = calendar.date(from: DateComponents(year: 2018, month: 5, day: 17, hour: 9))!
        run(rule: "RRULE:FREQ=MONTHLY;BYMONTHDAY=2,-1;INTERVAL=3;COUNT=10", start: start, results:
            ["2018-05-17T09:00:00", "2018-05-31T09:00:00", "2018-08-02T09:00:00", "2018-08-31T09:00:00",
             "2018-11-02T09:00:00", "2018-11-30T09:00:00", "2019-02-02T09:00:00", "2019-02-28T09:00:00",
             "2019-05-02T09:00:00", "2019-05-31T09:00:00"]
        )
    }

    func testMonthly08() {
        // Start 20180517T090000
        // Every Tuesday and Thursday of every month
        let start = calendar.date(from: DateComponents(year: 2018, month: 5, day: 17, hour: 9))!
        run(rule: "RRULE:FREQ=MONTHLY;BYDAY=TU,TH;COUNT=10", start: start, results:
            ["2018-05-17T09:00:00", "2018-05-22T09:00:00", "2018-05-24T09:00:00", "2018-05-29T09:00:00",
             "2018-05-31T09:00:00", "2018-06-05T09:00:00", "2018-06-07T09:00:00", "2018-06-12T09:00:00",
             "2018-06-14T09:00:00", "2018-06-19T09:00:00"]
        )
    }

    func testMonthly09() {
        // Start 20180517T090000
        // 1st Monday and last Friday of every month
        let start = calendar.date(from: DateComponents(year: 2018, month: 5, day: 17, hour: 9))!
        run(rule: "RRULE:FREQ=MONTHLY;BYDAY=1MO,-1FR;COUNT=10", start: start, results:
            ["2018-05-17T09:00:00", "2018-05-25T09:00:00", "2018-06-04T09:00:00", "2018-06-29T09:00:00",
             "2018-07-02T09:00:00", "2018-07-27T09:00:00", "2018-08-06T09:00:00", "2018-08-31T09:00:00",
             "2018-09-03T09:00:00", "2018-09-28T09:00:00"]
        )
    }

    func testMonthly10() {
        // Start 20180517T090000
        // Every Tuesday and Thursday of every third month
        let start = calendar.date(from: DateComponents(year: 2018, month: 5, day: 17, hour: 9))!
        run(rule: "RRULE:FREQ=MONTHLY;BYDAY=TU,TH;INTERVAL=3;COUNT=10", start: start, results:
            ["2018-05-17T09:00:00", "2018-05-22T09:00:00", "2018-05-24T09:00:00", "2018-05-29T09:00:00",
             "2018-05-31T09:00:00", "2018-08-02T09:00:00", "2018-08-07T09:00:00", "2018-08-09T09:00:00",
             "2018-08-14T09:00:00", "2018-08-16T09:00:00"]
        )
    }

    func testMonthly11() {
        // Start 20180517T090000
        // 1st Monday and last Friday of every other month
        let start = calendar.date(from: DateComponents(year: 2018, month: 5, day: 17, hour: 9))!
        run(rule: "RRULE:FREQ=MONTHLY;BYDAY=1MO,-1FR;INTERVAL=2;COUNT=10", start: start, results:
            ["2018-05-17T09:00:00", "2018-05-25T09:00:00", "2018-07-02T09:00:00", "2018-07-27T09:00:00",
             "2018-09-03T09:00:00", "2018-09-28T09:00:00", "2018-11-05T09:00:00", "2018-11-30T09:00:00",
             "2019-01-07T09:00:00", "2019-01-25T09:00:00"]
        )
    }

    func testMonthly12() {
        // Start 20180517T090000
        // 2nd, 4th, and 6th of March and May
        let start = calendar.date(from: DateComponents(year: 2018, month: 5, day: 17, hour: 9))!
        run(rule: "RRULE:FREQ=MONTHLY;BYMONTHDAY=2,4,6;BYMONTH=3,5;COUNT=10", start: start, results:
            ["2018-05-17T09:00:00", "2019-03-02T09:00:00", "2019-03-04T09:00:00", "2019-03-06T09:00:00",
             "2019-05-02T09:00:00", "2019-05-04T09:00:00", "2019-05-06T09:00:00", "2020-03-02T09:00:00",
             "2020-03-04T09:00:00", "2020-03-06T09:00:00"]
        )
    }

    func testMonthly13() {
        // Start 20180517T090000
        // 2nd and last day of June
        let start = calendar.date(from: DateComponents(year: 2018, month: 5, day: 17, hour: 9))!
        run(rule: "RRULE:FREQ=MONTHLY;BYMONTH=6;BYMONTHDAY=2,-1;COUNT=10", start: start, results:
            ["2018-05-17T09:00:00", "2018-06-02T09:00:00", "2018-06-30T09:00:00", "2019-06-02T09:00:00",
             "2019-06-30T09:00:00", "2020-06-02T09:00:00", "2020-06-30T09:00:00", "2021-06-02T09:00:00",
             "2021-06-30T09:00:00", "2022-06-02T09:00:00"]
        )
    }

    func testMonthly14() {
        // Start 20180517T090000
        // Every Tuesday and Thursday of every August
        let start = calendar.date(from: DateComponents(year: 2018, month: 5, day: 17, hour: 9))!
        run(rule: "RRULE:FREQ=MONTHLY;BYDAY=TU,TH;BYMONTH=8;COUNT=15", start: start, results:
            ["2018-05-17T09:00:00", "2018-08-02T09:00:00", "2018-08-07T09:00:00", "2018-08-09T09:00:00",
             "2018-08-14T09:00:00", "2018-08-16T09:00:00", "2018-08-21T09:00:00", "2018-08-23T09:00:00",
             "2018-08-28T09:00:00", "2018-08-30T09:00:00", "2019-08-01T09:00:00", "2019-08-06T09:00:00",
             "2019-08-08T09:00:00", "2019-08-13T09:00:00", "2019-08-15T09:00:00"]
        )
    }

    func testMonthly14a() {
        // Start 20180517T090000
        // Every Tuesday and the 2nd Thursday of every August
        let start = calendar.date(from: DateComponents(year: 2018, month: 5, day: 17, hour: 9))!
        run(rule: "RRULE:FREQ=MONTHLY;BYDAY=TU,2TH;BYMONTH=8;COUNT=15", start: start, results:
            ["2018-05-17T09:00:00", "2018-08-07T09:00:00", "2018-08-09T09:00:00", "2018-08-14T09:00:00",
             "2018-08-21T09:00:00", "2018-08-28T09:00:00", "2019-08-06T09:00:00", "2019-08-08T09:00:00",
             "2019-08-13T09:00:00", "2019-08-20T09:00:00", "2019-08-27T09:00:00", "2020-08-04T09:00:00",
             "2020-08-11T09:00:00", "2020-08-13T09:00:00", "2020-08-18T09:00:00"]
        )
    }

    func testMonthly15() {
        // Start 20180517T090000
        // 1st Monday and last Friday of every March and September
        let start = calendar.date(from: DateComponents(year: 2018, month: 5, day: 17, hour: 9))!
        run(rule: "RRULE:FREQ=MONTHLY;BYDAY=1MO,-1FR;BYMONTH=3,9;COUNT=10", start: start, results:
            ["2018-05-17T09:00:00", "2018-09-03T09:00:00", "2018-09-28T09:00:00", "2019-03-04T09:00:00",
             "2019-03-29T09:00:00", "2019-09-02T09:00:00", "2019-09-27T09:00:00", "2020-03-02T09:00:00",
             "2020-03-27T09:00:00", "2020-09-07T09:00:00"]
        )
    }

    func testMonthly16() {
        // Start 20180517T090000
        // The 10th, 11th, 12th, 13th, and 14th of every month that falls on a Tuesday or Thursday
        let start = calendar.date(from: DateComponents(year: 2018, month: 5, day: 17, hour: 9))!
        run(rule: "RRULE:FREQ=MONTHLY;BYDAY=TU,TH;BYMONTHDAY=10,11,12,13,14;COUNT=10", start: start, results:
            ["2018-05-17T09:00:00", "2018-06-12T09:00:00", "2018-06-14T09:00:00", "2018-07-10T09:00:00",
             "2018-07-12T09:00:00", "2018-08-14T09:00:00", "2018-09-11T09:00:00", "2018-09-13T09:00:00",
             "2018-10-11T09:00:00", "2018-11-13T09:00:00"]
        )
    }

    func testMonthly17() {
        // Start 20180517T090000
        // The 1st, 2nd, 3rd, last, 2nd-to-last, and 3rd-to-last of every month that falls on the 1st Monday or the last Friday
        let start = calendar.date(from: DateComponents(year: 2018, month: 5, day: 17, hour: 9))!
        run(rule: "RRULE:FREQ=MONTHLY;BYMONTHDAY=1,2,3,-1,-2,-3;BYDAY=1MO,-1FR;COUNT=10", start: start, results:
            ["2018-05-17T09:00:00", "2018-06-29T09:00:00", "2018-07-02T09:00:00", "2018-08-31T09:00:00",
             "2018-09-03T09:00:00", "2018-09-28T09:00:00", "2018-10-01T09:00:00", "2018-11-30T09:00:00",
             "2018-12-03T09:00:00", "2019-03-29T09:00:00"]
        )
    }

    func testMonthly18() {
        // Start 20180517T090000
        // The 1st, 2nd, and 3rd of January, February, and March that fall on a Sunday, Monday, or Tuesday
        let start = calendar.date(from: DateComponents(year: 2018, month: 5, day: 17, hour: 9))!
        run(rule: "RRULE:FREQ=MONTHLY;BYMONTH=1,2,3;BYMONTHDAY=1,2,3;BYDAY=SU,MO,TU;COUNT=10", start: start, results:
            ["2018-05-17T09:00:00", "2019-01-01T09:00:00", "2019-02-03T09:00:00", "2019-03-03T09:00:00",
             "2020-02-02T09:00:00", "2020-02-03T09:00:00", "2020-03-01T09:00:00", "2020-03-02T09:00:00",
             "2020-03-03T09:00:00", "2021-01-03T09:00:00"]
        )
    }

    // TODO - test BYSETPOS
}
