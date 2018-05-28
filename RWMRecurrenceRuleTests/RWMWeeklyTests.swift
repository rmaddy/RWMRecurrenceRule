//
//  RWMWeeklyTests.swift
//  RWMRecurrenceRuleTests
//
//  Created by Richard W Maddy on 5/17/18.
//  Copyright © 2018 Maddysoft. All rights reserved.
//

import XCTest

class RWMWeeklyTests: RWMRecurrenceRuleBase {
    // ----------- WEEKLY ------------

    // Weekly can use BYMONTH, BYDAY, BYSETPOS

    func testWeekly01() {
        // Start 20180517T090000
        // Weekly with no BYxxx clauses. Should give several weeks with same day as start date
        let start = calendar.date(from: DateComponents(year: 2018, month: 5, day: 17, hour: 9))!
        run(rule: "RRULE:FREQ=WEEKLY;COUNT=10", start: start, results:
            ["2018-05-17T09:00:00", "2018-05-24T09:00:00", "2018-05-31T09:00:00", "2018-06-07T09:00:00",
             "2018-06-14T09:00:00", "2018-06-21T09:00:00", "2018-06-28T09:00:00", "2018-07-05T09:00:00",
             "2018-07-12T09:00:00", "2018-07-19T09:00:00"]
        )
    }

    func testWeekly02() {
        // Start 20180517T090000
        // Every third week.
        let start = calendar.date(from: DateComponents(year: 2018, month: 5, day: 17, hour: 9))!
        run(rule: "RRULE:FREQ=WEEKLY;INTERVAL=3;COUNT=10", start: start, results:
            ["2018-05-17T09:00:00", "2018-06-07T09:00:00", "2018-06-28T09:00:00", "2018-07-19T09:00:00",
             "2018-08-09T09:00:00", "2018-08-30T09:00:00", "2018-09-20T09:00:00", "2018-10-11T09:00:00",
             "2018-11-01T09:00:00", "2018-11-22T09:00:00"]
        )
    }

    func testWeekly03() {
        // Start 20180517T090000
        // Weekly but only in June.
        let start = calendar.date(from: DateComponents(year: 2018, month: 5, day: 17, hour: 9))!
        run(rule: "RRULE:FREQ=WEEKLY;BYMONTH=6;COUNT=10", start: start, results:
            ["2018-05-17T09:00:00", "2018-06-07T09:00:00", "2018-06-14T09:00:00", "2018-06-21T09:00:00",
             "2018-06-28T09:00:00", "2019-06-06T09:00:00", "2019-06-13T09:00:00", "2019-06-20T09:00:00",
             "2019-06-27T09:00:00", "2020-06-04T09:00:00"]
        )
    }

    func testWeekly04() {
        // Start 20180517T090000
        // Every third week, but only in June
        let start = calendar.date(from: DateComponents(year: 2018, month: 5, day: 17, hour: 9))!
        run(rule: "RRULE:FREQ=WEEKLY;INTERVAL=3;BYMONTH=6;COUNT=10", start: start, results:
            ["2018-05-17T09:00:00", "2018-06-07T09:00:00", "2018-06-28T09:00:00", "2019-06-20T09:00:00",
             "2020-06-11T09:00:00", "2021-06-03T09:00:00", "2021-06-24T09:00:00", "2022-06-16T09:00:00",
             "2023-06-08T09:00:00", "2023-06-29T09:00:00"]
        )
    }

    func testWeekly05() {
        // Start 20180517T090000
        // Weekly but only in June or September.
        let start = calendar.date(from: DateComponents(year: 2018, month: 5, day: 17, hour: 9))!
        run(rule: "RRULE:FREQ=WEEKLY;BYMONTH=6,9;COUNT=10", start: start, results:
            ["2018-05-17T09:00:00", "2018-06-07T09:00:00", "2018-06-14T09:00:00", "2018-06-21T09:00:00",
             "2018-06-28T09:00:00", "2018-09-06T09:00:00", "2018-09-13T09:00:00", "2018-09-20T09:00:00",
             "2018-09-27T09:00:00", "2019-06-06T09:00:00"]
        )
    }

    func testWeekly06() {
        // Start 20180517T090000
        // Weekly on Monday, Wednesday, Friday.
        let start = calendar.date(from: DateComponents(year: 2018, month: 5, day: 17, hour: 9))!
        run(rule: "RRULE:FREQ=WEEKLY;BYDAY=MO,WE,FR;COUNT=20", start: start, results:
            ["2018-05-17T09:00:00", "2018-05-18T09:00:00", "2018-05-21T09:00:00", "2018-05-23T09:00:00",
             "2018-05-25T09:00:00", "2018-05-28T09:00:00", "2018-05-30T09:00:00", "2018-06-01T09:00:00",
             "2018-06-04T09:00:00", "2018-06-06T09:00:00", "2018-06-08T09:00:00", "2018-06-11T09:00:00",
             "2018-06-13T09:00:00", "2018-06-15T09:00:00", "2018-06-18T09:00:00", "2018-06-20T09:00:00",
             "2018-06-22T09:00:00", "2018-06-25T09:00:00", "2018-06-27T09:00:00", "2018-06-29T09:00:00"]
        )
    }

    func testWeekly07() {
        // Start 20180517T090000
        // Every third week on Tuesday/Thursday
        let start = calendar.date(from: DateComponents(year: 2018, month: 5, day: 17, hour: 9))!
        run(rule: "RRULE:FREQ=WEEKLY;INTERVAL=3;BYDAY=TU,TH;COUNT=20", start: start, results:
            ["2018-05-17T09:00:00", "2018-06-05T09:00:00", "2018-06-07T09:00:00", "2018-06-26T09:00:00",
             "2018-06-28T09:00:00", "2018-07-17T09:00:00", "2018-07-19T09:00:00", "2018-08-07T09:00:00",
             "2018-08-09T09:00:00", "2018-08-28T09:00:00", "2018-08-30T09:00:00", "2018-09-18T09:00:00",
             "2018-09-20T09:00:00", "2018-10-09T09:00:00", "2018-10-11T09:00:00", "2018-10-30T09:00:00",
             "2018-11-01T09:00:00", "2018-11-20T09:00:00", "2018-11-22T09:00:00", "2018-12-11T09:00:00"]
        )
    }

    func testWeekly08() {
        // Start 20180517T090000
        // Weekly on Monday, Wednesday, Friday in April or August
        let start = calendar.date(from: DateComponents(year: 2018, month: 5, day: 17, hour: 9))!
        run(rule: "RRULE:FREQ=WEEKLY;BYDAY=MO,WE,FR;BYMONTH=4,8;COUNT=20", start: start, results:
            ["2018-05-17T09:00:00", "2018-08-01T09:00:00", "2018-08-03T09:00:00", "2018-08-06T09:00:00",
             "2018-08-08T09:00:00", "2018-08-10T09:00:00", "2018-08-13T09:00:00", "2018-08-15T09:00:00",
             "2018-08-17T09:00:00", "2018-08-20T09:00:00", "2018-08-22T09:00:00", "2018-08-24T09:00:00",
             "2018-08-27T09:00:00", "2018-08-29T09:00:00", "2018-08-31T09:00:00", "2019-04-01T09:00:00",
             "2019-04-03T09:00:00", "2019-04-05T09:00:00", "2019-04-08T09:00:00", "2019-04-10T09:00:00"]
        )
    }

    func testWeekly09() {
        // Start 20180517T090000
        // Every third week on Tuesday/Thursday in June
        let start = calendar.date(from: DateComponents(year: 2018, month: 5, day: 17, hour: 9))!
        run(rule: "RRULE:FREQ=WEEKLY;INTERVAL=3;BYDAY=TU,TH;BYMONTH=6;COUNT=20", start: start, results:
            ["2018-05-17T09:00:00", "2018-06-05T09:00:00", "2018-06-07T09:00:00", "2018-06-26T09:00:00",
             "2018-06-28T09:00:00", "2019-06-18T09:00:00", "2019-06-20T09:00:00", "2020-06-09T09:00:00",
             "2020-06-11T09:00:00", "2020-06-30T09:00:00", "2021-06-01T09:00:00", "2021-06-03T09:00:00",
             "2021-06-22T09:00:00", "2021-06-24T09:00:00", "2022-06-14T09:00:00", "2022-06-16T09:00:00",
             "2023-06-06T09:00:00", "2023-06-08T09:00:00", "2023-06-27T09:00:00", "2023-06-29T09:00:00"]
        )
    }

    func testWeekly10() {
        // Start 20180517T090000
        // Weekly on Monday, Wednesday, Friday in April or August
        let start = calendar.date(from: DateComponents(year: 2018, month: 5, day: 17, hour: 9))!
        run(rule: "RRULE:FREQ=WEEKLY;BYDAY=MO,WE,FR;BYMONTH=4,8;BYSETPOS=-1,1;COUNT=20", start: start, results:
            ["2018-05-17T09:00:00", "2018-08-01T09:00:00", "2018-08-03T09:00:00", "2018-08-06T09:00:00",
             "2018-08-10T09:00:00", "2018-08-13T09:00:00", "2018-08-17T09:00:00", "2018-08-20T09:00:00",
             "2018-08-24T09:00:00", "2018-08-27T09:00:00", "2018-08-31T09:00:00", "2019-04-01T09:00:00",
             "2019-04-05T09:00:00", "2019-04-08T09:00:00", "2019-04-12T09:00:00", "2019-04-15T09:00:00",
             "2019-04-19T09:00:00", "2019-04-22T09:00:00", "2019-04-26T09:00:00", "2019-04-29T09:00:00"]
        )
    }

    func testWeekly11() {
        // Start 20180517T090000
        // Every third week on Tuesday/Thursday in June
        let start = calendar.date(from: DateComponents(year: 2018, month: 5, day: 17, hour: 9))!
        run(rule: "RRULE:FREQ=WEEKLY;INTERVAL=3;BYDAY=TU,TH;BYMONTH=6;BYSETPOS=1;COUNT=20", start: start, results:
            ["2018-05-17T09:00:00", "2018-06-05T09:00:00", "2018-06-26T09:00:00", "2019-06-18T09:00:00",
             "2020-06-09T09:00:00", "2020-06-30T09:00:00", "2021-06-01T09:00:00", "2021-06-22T09:00:00",
             "2022-06-14T09:00:00", "2023-06-06T09:00:00", "2023-06-27T09:00:00", "2024-06-18T09:00:00",
             "2025-06-10T09:00:00", "2026-06-02T09:00:00", "2026-06-23T09:00:00", "2027-06-15T09:00:00",
             "2028-06-06T09:00:00", "2028-06-27T09:00:00", "2029-06-19T09:00:00", "2030-06-11T09:00:00"]
        )
    }
}
