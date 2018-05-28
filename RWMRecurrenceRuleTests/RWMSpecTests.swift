//
//  RWMSpecTests.swift
//  RWMRecurrenceRuleTests
//
//  Created by Richard W Maddy on 5/17/18.
//  Copyright © 2018 Maddysoft. All rights reserved.
//

import XCTest

class RWMSpecTests: RWMRecurrenceRuleBase {
    // The following tests are based on samples rules from https://icalendar.org/iCalendar-RFC-5545/3-8-5-3-recurrence-rule.html

    func testRule01() {
        // Start 19970902T090000
        // Daily for 10 occurrences
        let start = calendar.date(from: DateComponents(year: 1997, month: 9, day: 2, hour: 9))!
        run(rule: "RRULE:FREQ=DAILY;COUNT=10", start: start, results:
            ["1997-09-02T09:00:00", "1997-09-03T09:00:00", "1997-09-04T09:00:00", "1997-09-05T09:00:00",
             "1997-09-06T09:00:00", "1997-09-07T09:00:00", "1997-09-08T09:00:00", "1997-09-09T09:00:00",
             "1997-09-10T09:00:00", "1997-09-11T09:00:00"]
        )
    }

    func testRule02() {
        // Start 19970902T090000
        // Daily until December 24, 1997
        let start = calendar.date(from: DateComponents(year: 1997, month: 9, day: 2, hour: 9))!
        run(rule: "RRULE:FREQ=DAILY;UNTIL=19971224T000000Z", start: start, results:
            ["1997-09-02T09:00:00", "1997-09-03T09:00:00", "1997-09-04T09:00:00", "1997-09-05T09:00:00",
             "1997-09-06T09:00:00", "1997-09-07T09:00:00", "1997-09-08T09:00:00", "1997-09-09T09:00:00",
             "1997-09-10T09:00:00", "1997-09-11T09:00:00", "1997-09-12T09:00:00", "1997-09-13T09:00:00",
             "1997-09-14T09:00:00", "1997-09-15T09:00:00", "1997-09-16T09:00:00", "1997-09-17T09:00:00",
             "1997-09-18T09:00:00", "1997-09-19T09:00:00", "1997-09-20T09:00:00", "1997-09-21T09:00:00",
             "1997-09-22T09:00:00", "1997-09-23T09:00:00", "1997-09-24T09:00:00", "1997-09-25T09:00:00",
             "1997-09-26T09:00:00", "1997-09-27T09:00:00", "1997-09-28T09:00:00", "1997-09-29T09:00:00",
             "1997-09-30T09:00:00", "1997-10-01T09:00:00", "1997-10-02T09:00:00", "1997-10-03T09:00:00",
             "1997-10-04T09:00:00", "1997-10-05T09:00:00", "1997-10-06T09:00:00", "1997-10-07T09:00:00",
             "1997-10-08T09:00:00", "1997-10-09T09:00:00", "1997-10-10T09:00:00", "1997-10-11T09:00:00",
             "1997-10-12T09:00:00", "1997-10-13T09:00:00", "1997-10-14T09:00:00", "1997-10-15T09:00:00",
             "1997-10-16T09:00:00", "1997-10-17T09:00:00", "1997-10-18T09:00:00", "1997-10-19T09:00:00",
             "1997-10-20T09:00:00", "1997-10-21T09:00:00", "1997-10-22T09:00:00", "1997-10-23T09:00:00",
             "1997-10-24T09:00:00", "1997-10-25T09:00:00", "1997-10-26T09:00:00", "1997-10-27T09:00:00",
             "1997-10-28T09:00:00", "1997-10-29T09:00:00", "1997-10-30T09:00:00", "1997-10-31T09:00:00",
             "1997-11-01T09:00:00", "1997-11-02T09:00:00", "1997-11-03T09:00:00", "1997-11-04T09:00:00",
             "1997-11-05T09:00:00", "1997-11-06T09:00:00", "1997-11-07T09:00:00", "1997-11-08T09:00:00",
             "1997-11-09T09:00:00", "1997-11-10T09:00:00", "1997-11-11T09:00:00", "1997-11-12T09:00:00",
             "1997-11-13T09:00:00", "1997-11-14T09:00:00", "1997-11-15T09:00:00", "1997-11-16T09:00:00",
             "1997-11-17T09:00:00", "1997-11-18T09:00:00", "1997-11-19T09:00:00", "1997-11-20T09:00:00",
             "1997-11-21T09:00:00", "1997-11-22T09:00:00", "1997-11-23T09:00:00", "1997-11-24T09:00:00",
             "1997-11-25T09:00:00", "1997-11-26T09:00:00", "1997-11-27T09:00:00", "1997-11-28T09:00:00",
             "1997-11-29T09:00:00", "1997-11-30T09:00:00", "1997-12-01T09:00:00", "1997-12-02T09:00:00",
             "1997-12-03T09:00:00", "1997-12-04T09:00:00", "1997-12-05T09:00:00", "1997-12-06T09:00:00",
             "1997-12-07T09:00:00", "1997-12-08T09:00:00", "1997-12-09T09:00:00", "1997-12-10T09:00:00",
             "1997-12-11T09:00:00", "1997-12-12T09:00:00", "1997-12-13T09:00:00", "1997-12-14T09:00:00",
             "1997-12-15T09:00:00", "1997-12-16T09:00:00", "1997-12-17T09:00:00", "1997-12-18T09:00:00",
             "1997-12-19T09:00:00", "1997-12-20T09:00:00", "1997-12-21T09:00:00", "1997-12-22T09:00:00",
             "1997-12-23T09:00:00"]
        )
    }

    func testRule03() {
        // Start 19970902T090000
        // Every other day - forever
        let start = calendar.date(from: DateComponents(year: 1997, month: 9, day: 2, hour: 9))!
        run(rule: "RRULE:FREQ=DAILY;INTERVAL=2", start: start, max: 15, results:
            ["1997-09-02T09:00:00", "1997-09-04T09:00:00", "1997-09-06T09:00:00", "1997-09-08T09:00:00",
             "1997-09-10T09:00:00", "1997-09-12T09:00:00", "1997-09-14T09:00:00", "1997-09-16T09:00:00",
             "1997-09-18T09:00:00", "1997-09-20T09:00:00", "1997-09-22T09:00:00", "1997-09-24T09:00:00",
             "1997-09-26T09:00:00", "1997-09-28T09:00:00", "1997-09-30T09:00:00"]
        )
    }

    func testRule04() {
        // Start 19970902T090000
        // Every 10 days, 5 occurrences
        let start = calendar.date(from: DateComponents(year: 1997, month: 9, day: 2, hour: 9))!
        run(rule: "RRULE:FREQ=DAILY;INTERVAL=10;COUNT=5", start: start, results:
            ["1997-09-02T09:00:00", "1997-09-12T09:00:00", "1997-09-22T09:00:00", "1997-10-02T09:00:00",
             "1997-10-12T09:00:00"]
        )
    }

    func testRule05() {
        // Start 19980101T090000
        // Every day in January, for 3 years
        let start = calendar.date(from: DateComponents(year: 1998, month: 1, day: 1, hour: 9))!
        run(rule: "RRULE:FREQ=YEARLY;UNTIL=20000131T140000;BYMONTH=1;BYDAY=SU,MO,TU,WE,TH,FR,SA", start: start, results:
            ["1998-01-01T09:00:00", "1998-01-02T09:00:00", "1998-01-03T09:00:00", "1998-01-04T09:00:00",
             "1998-01-05T09:00:00", "1998-01-06T09:00:00", "1998-01-07T09:00:00", "1998-01-08T09:00:00",
             "1998-01-09T09:00:00", "1998-01-10T09:00:00", "1998-01-11T09:00:00", "1998-01-12T09:00:00",
             "1998-01-13T09:00:00", "1998-01-14T09:00:00", "1998-01-15T09:00:00", "1998-01-16T09:00:00",
             "1998-01-17T09:00:00", "1998-01-18T09:00:00", "1998-01-19T09:00:00", "1998-01-20T09:00:00",
             "1998-01-21T09:00:00", "1998-01-22T09:00:00", "1998-01-23T09:00:00", "1998-01-24T09:00:00",
             "1998-01-25T09:00:00", "1998-01-26T09:00:00", "1998-01-27T09:00:00", "1998-01-28T09:00:00",
             "1998-01-29T09:00:00", "1998-01-30T09:00:00", "1998-01-31T09:00:00", "1999-01-01T09:00:00",
             "1999-01-02T09:00:00", "1999-01-03T09:00:00", "1999-01-04T09:00:00", "1999-01-05T09:00:00",
             "1999-01-06T09:00:00", "1999-01-07T09:00:00", "1999-01-08T09:00:00", "1999-01-09T09:00:00",
             "1999-01-10T09:00:00", "1999-01-11T09:00:00", "1999-01-12T09:00:00", "1999-01-13T09:00:00",
             "1999-01-14T09:00:00", "1999-01-15T09:00:00", "1999-01-16T09:00:00", "1999-01-17T09:00:00",
             "1999-01-18T09:00:00", "1999-01-19T09:00:00", "1999-01-20T09:00:00", "1999-01-21T09:00:00",
             "1999-01-22T09:00:00", "1999-01-23T09:00:00", "1999-01-24T09:00:00", "1999-01-25T09:00:00",
             "1999-01-26T09:00:00", "1999-01-27T09:00:00", "1999-01-28T09:00:00", "1999-01-29T09:00:00",
             "1999-01-30T09:00:00", "1999-01-31T09:00:00", "2000-01-01T09:00:00", "2000-01-02T09:00:00",
             "2000-01-03T09:00:00", "2000-01-04T09:00:00", "2000-01-05T09:00:00", "2000-01-06T09:00:00",
             "2000-01-07T09:00:00", "2000-01-08T09:00:00", "2000-01-09T09:00:00", "2000-01-10T09:00:00",
             "2000-01-11T09:00:00", "2000-01-12T09:00:00", "2000-01-13T09:00:00", "2000-01-14T09:00:00",
             "2000-01-15T09:00:00", "2000-01-16T09:00:00", "2000-01-17T09:00:00", "2000-01-18T09:00:00",
             "2000-01-19T09:00:00", "2000-01-20T09:00:00", "2000-01-21T09:00:00", "2000-01-22T09:00:00",
             "2000-01-23T09:00:00", "2000-01-24T09:00:00", "2000-01-25T09:00:00", "2000-01-26T09:00:00",
             "2000-01-27T09:00:00", "2000-01-28T09:00:00", "2000-01-29T09:00:00", "2000-01-30T09:00:00",
             "2000-01-31T09:00:00"]
        )
    }

    func testRule06() {
        // Start 19980101T090000
        // Every day in January, for 3 years
        let start = calendar.date(from: DateComponents(year: 1998, month: 1, day: 1, hour: 9))!
        run(rule: "RRULE:FREQ=DAILY;UNTIL=20000131T140000;BYMONTH=1", start: start, results:
            ["1998-01-01T09:00:00", "1998-01-02T09:00:00", "1998-01-03T09:00:00", "1998-01-04T09:00:00",
             "1998-01-05T09:00:00", "1998-01-06T09:00:00", "1998-01-07T09:00:00", "1998-01-08T09:00:00",
             "1998-01-09T09:00:00", "1998-01-10T09:00:00", "1998-01-11T09:00:00", "1998-01-12T09:00:00",
             "1998-01-13T09:00:00", "1998-01-14T09:00:00", "1998-01-15T09:00:00", "1998-01-16T09:00:00",
             "1998-01-17T09:00:00", "1998-01-18T09:00:00", "1998-01-19T09:00:00", "1998-01-20T09:00:00",
             "1998-01-21T09:00:00", "1998-01-22T09:00:00", "1998-01-23T09:00:00", "1998-01-24T09:00:00",
             "1998-01-25T09:00:00", "1998-01-26T09:00:00", "1998-01-27T09:00:00", "1998-01-28T09:00:00",
             "1998-01-29T09:00:00", "1998-01-30T09:00:00", "1998-01-31T09:00:00", "1999-01-01T09:00:00",
             "1999-01-02T09:00:00", "1999-01-03T09:00:00", "1999-01-04T09:00:00", "1999-01-05T09:00:00",
             "1999-01-06T09:00:00", "1999-01-07T09:00:00", "1999-01-08T09:00:00", "1999-01-09T09:00:00",
             "1999-01-10T09:00:00", "1999-01-11T09:00:00", "1999-01-12T09:00:00", "1999-01-13T09:00:00",
             "1999-01-14T09:00:00", "1999-01-15T09:00:00", "1999-01-16T09:00:00", "1999-01-17T09:00:00",
             "1999-01-18T09:00:00", "1999-01-19T09:00:00", "1999-01-20T09:00:00", "1999-01-21T09:00:00",
             "1999-01-22T09:00:00", "1999-01-23T09:00:00", "1999-01-24T09:00:00", "1999-01-25T09:00:00",
             "1999-01-26T09:00:00", "1999-01-27T09:00:00", "1999-01-28T09:00:00", "1999-01-29T09:00:00",
             "1999-01-30T09:00:00", "1999-01-31T09:00:00", "2000-01-01T09:00:00", "2000-01-02T09:00:00",
             "2000-01-03T09:00:00", "2000-01-04T09:00:00", "2000-01-05T09:00:00", "2000-01-06T09:00:00",
             "2000-01-07T09:00:00", "2000-01-08T09:00:00", "2000-01-09T09:00:00", "2000-01-10T09:00:00",
             "2000-01-11T09:00:00", "2000-01-12T09:00:00", "2000-01-13T09:00:00", "2000-01-14T09:00:00",
             "2000-01-15T09:00:00", "2000-01-16T09:00:00", "2000-01-17T09:00:00", "2000-01-18T09:00:00",
             "2000-01-19T09:00:00", "2000-01-20T09:00:00", "2000-01-21T09:00:00", "2000-01-22T09:00:00",
             "2000-01-23T09:00:00", "2000-01-24T09:00:00", "2000-01-25T09:00:00", "2000-01-26T09:00:00",
             "2000-01-27T09:00:00", "2000-01-28T09:00:00", "2000-01-29T09:00:00", "2000-01-30T09:00:00",
             "2000-01-31T09:00:00"]
        )
    }

    func testRule07() {
        // Start 19970902T090000
        // Weekly for 10 occurrences
        let start = calendar.date(from: DateComponents(year: 1997, month: 9, day: 2, hour: 9))!
        run(rule: "RRULE:FREQ=WEEKLY;COUNT=10", start: start, results:
            ["1997-09-02T09:00:00", "1997-09-09T09:00:00", "1997-09-16T09:00:00", "1997-09-23T09:00:00",
             "1997-09-30T09:00:00", "1997-10-07T09:00:00", "1997-10-14T09:00:00", "1997-10-21T09:00:00",
             "1997-10-28T09:00:00", "1997-11-04T09:00:00"]
        )
    }

    func testRule08() {
        // Start 19970902T090000
        // Weekly until December 24, 1997
        let start = calendar.date(from: DateComponents(year: 1997, month: 9, day: 2, hour: 9))!
        run(rule: "RRULE:FREQ=WEEKLY;UNTIL=19971224T000000Z", start: start, results:
            ["1997-09-02T09:00:00", "1997-09-09T09:00:00", "1997-09-16T09:00:00", "1997-09-23T09:00:00",
             "1997-09-30T09:00:00", "1997-10-07T09:00:00", "1997-10-14T09:00:00", "1997-10-21T09:00:00",
             "1997-10-28T09:00:00", "1997-11-04T09:00:00", "1997-11-11T09:00:00", "1997-11-18T09:00:00",
             "1997-11-25T09:00:00", "1997-12-02T09:00:00", "1997-12-09T09:00:00", "1997-12-16T09:00:00",
             "1997-12-23T09:00:00"]
        )
    }

    func testRule09() {
        // Start 19970902T090000
        // Every other week - forever
        let start = calendar.date(from: DateComponents(year: 1997, month: 9, day: 2, hour: 9))!
        run(rule: "RRULE:FREQ=WEEKLY;INTERVAL=2;WKST=SU", start: start, max: 15, results:
            ["1997-09-02T09:00:00", "1997-09-16T09:00:00", "1997-09-30T09:00:00", "1997-10-14T09:00:00",
             "1997-10-28T09:00:00", "1997-11-11T09:00:00", "1997-11-25T09:00:00", "1997-12-09T09:00:00",
             "1997-12-23T09:00:00", "1998-01-06T09:00:00", "1998-01-20T09:00:00", "1998-02-03T09:00:00",
             "1998-02-17T09:00:00", "1998-03-03T09:00:00", "1998-03-17T09:00:00"]
        )
    }

    func testRule10() {
        // Start 19970902T090000
        // Weekly on Tuesday and Thursday for five weeks
        let start = calendar.date(from: DateComponents(year: 1997, month: 9, day: 2, hour: 9))!
        run(rule: "RRULE:FREQ=WEEKLY;UNTIL=19971007T000000Z;WKST=SU;BYDAY=TU,TH", start: start, results:
            ["1997-09-02T09:00:00", "1997-09-04T09:00:00", "1997-09-09T09:00:00", "1997-09-11T09:00:00",
             "1997-09-16T09:00:00", "1997-09-18T09:00:00", "1997-09-23T09:00:00", "1997-09-25T09:00:00",
             "1997-09-30T09:00:00", "1997-10-02T09:00:00"]
        )
    }

    func testRule11() {
        // Start 19970902T090000
        // Weekly on Tuesday and Thursday for five weeks
        let start = calendar.date(from: DateComponents(year: 1997, month: 9, day: 2, hour: 9))!
        run(rule: "RRULE:FREQ=WEEKLY;COUNT=10;WKST=SU;BYDAY=TU,TH", start: start, results:
            ["1997-09-02T09:00:00", "1997-09-04T09:00:00", "1997-09-09T09:00:00", "1997-09-11T09:00:00",
             "1997-09-16T09:00:00", "1997-09-18T09:00:00", "1997-09-23T09:00:00", "1997-09-25T09:00:00",
             "1997-09-30T09:00:00", "1997-10-02T09:00:00"]
        )
    }

    func testRule12() {
        // Start 19970901T090000
        // Every other week on Monday, Wednesday, and Friday until December 24, 1997, starting on Monday, September 1, 1997
        let start = calendar.date(from: DateComponents(year: 1997, month: 9, day: 1, hour: 9))!
        run(rule: "RRULE:FREQ=WEEKLY;INTERVAL=2;UNTIL=19971224T000000Z;WKST=SU;BYDAY=MO,WE,FR", start: start, results:
            ["1997-09-01T09:00:00", "1997-09-03T09:00:00", "1997-09-05T09:00:00", "1997-09-15T09:00:00",
             "1997-09-17T09:00:00", "1997-09-19T09:00:00", "1997-09-29T09:00:00", "1997-10-01T09:00:00",
             "1997-10-03T09:00:00", "1997-10-13T09:00:00", "1997-10-15T09:00:00", "1997-10-17T09:00:00",
             "1997-10-27T09:00:00", "1997-10-29T09:00:00", "1997-10-31T09:00:00", "1997-11-10T09:00:00",
             "1997-11-12T09:00:00", "1997-11-14T09:00:00", "1997-11-24T09:00:00", "1997-11-26T09:00:00",
             "1997-11-28T09:00:00", "1997-12-08T09:00:00", "1997-12-10T09:00:00", "1997-12-12T09:00:00",
             "1997-12-22T09:00:00"]
        )
    }

    func testRule13() {
        // Start 19970902T090000
        // Every other week on Tuesday and Thursday, for 8 occurrences
        let start = calendar.date(from: DateComponents(year: 1997, month: 9, day: 2, hour: 9))!
        run(rule: "RRULE:FREQ=WEEKLY;INTERVAL=2;COUNT=8;WKST=SU;BYDAY=TU,TH", start: start, results:
            ["1997-09-02T09:00:00", "1997-09-04T09:00:00", "1997-09-16T09:00:00", "1997-09-18T09:00:00",
             "1997-09-30T09:00:00", "1997-10-02T09:00:00", "1997-10-14T09:00:00", "1997-10-16T09:00:00"]
        )
    }

    func testRule14() {
        // Start 19970905T090000
        // Monthly on the first Friday for 10 occurrences
        let start = calendar.date(from: DateComponents(year: 1997, month: 9, day: 5, hour: 9))!
        run(rule: "RRULE:FREQ=MONTHLY;COUNT=10;BYDAY=1FR", start: start, results:
            ["1997-09-05T09:00:00", "1997-10-03T09:00:00", "1997-11-07T09:00:00", "1997-12-05T09:00:00",
             "1998-01-02T09:00:00", "1998-02-06T09:00:00", "1998-03-06T09:00:00", "1998-04-03T09:00:00",
             "1998-05-01T09:00:00", "1998-06-05T09:00:00"]
        )
    }

    func testRule15() {
        // Start 19970905T090000
        // Monthly on the first Friday until December 24, 1997
        let start = calendar.date(from: DateComponents(year: 1997, month: 9, day: 5, hour: 9))!
        run(rule: "RRULE:FREQ=MONTHLY;UNTIL=19971224T000000Z;BYDAY=1FR", start: start, results:
            ["1997-09-05T09:00:00", "1997-10-03T09:00:00", "1997-11-07T09:00:00", "1997-12-05T09:00:00"]
        )
    }

    func testRule16() {
        // Start 19970907T090000
        // Every other month on the first and last Sunday of the month for 10 occurrences
        let start = calendar.date(from: DateComponents(year: 1997, month: 9, day: 7, hour: 9))!
        run(rule: "RRULE:FREQ=MONTHLY;INTERVAL=2;COUNT=10;BYDAY=1SU,-1SU", start: start, results:
            ["1997-09-07T09:00:00", "1997-09-28T09:00:00", "1997-11-02T09:00:00", "1997-11-30T09:00:00",
             "1998-01-04T09:00:00", "1998-01-25T09:00:00", "1998-03-01T09:00:00", "1998-03-29T09:00:00",
             "1998-05-03T09:00:00", "1998-05-31T09:00:00"]
        )
    }

    func testRule17() {
        // Start 19970922T090000
        // Monthly on the second-to-last Monday of the month for 6 months
        let start = calendar.date(from: DateComponents(year: 1997, month: 9, day: 22, hour: 9))!
        run(rule: "RRULE:FREQ=MONTHLY;COUNT=6;BYDAY=-2MO", start: start, results:
            ["1997-09-22T09:00:00", "1997-10-20T09:00:00", "1997-11-17T09:00:00", "1997-12-22T09:00:00",
             "1998-01-19T09:00:00", "1998-02-16T09:00:00"]
        )
    }

    func testRule18() {
        // Start 19970928T090000
        // Monthly on the third-to-the-last day of the month, forever
        let start = calendar.date(from: DateComponents(year: 1997, month: 9, day: 28, hour: 9))!
        run(rule: "RRULE:FREQ=MONTHLY;BYMONTHDAY=-3", start: start, max: 6, results:
            ["1997-09-28T09:00:00", "1997-10-29T09:00:00", "1997-11-28T09:00:00", "1997-12-29T09:00:00",
             "1998-01-29T09:00:00", "1998-02-26T09:00:00"]
        )
    }

    func testRule19() {
        // Start 19970902T090000
        // Monthly on the 2nd and 15th of the month for 10 occurrences
        let start = calendar.date(from: DateComponents(year: 1997, month: 9, day: 2, hour: 9))!
        run(rule: "RRULE:FREQ=MONTHLY;COUNT=10;BYMONTHDAY=2,15", start: start, results:
            ["1997-09-02T09:00:00", "1997-09-15T09:00:00", "1997-10-02T09:00:00", "1997-10-15T09:00:00",
             "1997-11-02T09:00:00", "1997-11-15T09:00:00", "1997-12-02T09:00:00", "1997-12-15T09:00:00",
             "1998-01-02T09:00:00", "1998-01-15T09:00:00"]
        )
    }

    func testRule20() {
        // Start 19970930T090000
        // Monthly on the first and last day of the month for 10 occurrences
        let start = calendar.date(from: DateComponents(year: 1997, month: 9, day: 30, hour: 9))!
        run(rule: "RRULE:FREQ=MONTHLY;COUNT=10;BYMONTHDAY=1,-1", start: start, results:
            ["1997-09-30T09:00:00", "1997-10-01T09:00:00", "1997-10-31T09:00:00", "1997-11-01T09:00:00",
             "1997-11-30T09:00:00", "1997-12-01T09:00:00", "1997-12-31T09:00:00", "1998-01-01T09:00:00",
             "1998-01-31T09:00:00", "1998-02-01T09:00:00"]
        )
    }

    func testRule21() {
        // Start 19970910T090000
        // Every 18 months on the 10th thru 15th of the month for 10 occurrences
        let start = calendar.date(from: DateComponents(year: 1997, month: 9, day: 10, hour: 9))!
        run(rule: "RRULE:FREQ=MONTHLY;INTERVAL=18;COUNT=10;BYMONTHDAY=10,11,12,13,14,15", start: start, results:
            ["1997-09-10T09:00:00", "1997-09-11T09:00:00", "1997-09-12T09:00:00", "1997-09-13T09:00:00",
             "1997-09-14T09:00:00", "1997-09-15T09:00:00", "1999-03-10T09:00:00", "1999-03-11T09:00:00",
             "1999-03-12T09:00:00", "1999-03-13T09:00:00"]
        )
    }

    func testRule22() {
        // Start 19970902T090000
        // Every Tuesday, every other month
        let start = calendar.date(from: DateComponents(year: 1997, month: 9, day: 2, hour: 9))!
        run(rule: "RRULE:FREQ=MONTHLY;INTERVAL=2;BYDAY=TU", start: start, max: 18, results:
            ["1997-09-02T09:00:00", "1997-09-09T09:00:00", "1997-09-16T09:00:00", "1997-09-23T09:00:00",
             "1997-09-30T09:00:00", "1997-11-04T09:00:00", "1997-11-11T09:00:00", "1997-11-18T09:00:00",
             "1997-11-25T09:00:00", "1998-01-06T09:00:00", "1998-01-13T09:00:00", "1998-01-20T09:00:00",
             "1998-01-27T09:00:00", "1998-03-03T09:00:00", "1998-03-10T09:00:00", "1998-03-17T09:00:00",
             "1998-03-24T09:00:00", "1998-03-31T09:00:00"]
        )
    }

    func testRule23() {
        // Start 19970610T090000
        // Yearly in June and July for 10 occurrences
        let start = calendar.date(from: DateComponents(year: 1997, month: 6, day: 10, hour: 9))!
        run(rule: "RRULE:FREQ=YEARLY;COUNT=10;BYMONTH=6,7", start: start, results:
            ["1997-06-10T09:00:00", "1997-07-10T09:00:00", "1998-06-10T09:00:00", "1998-07-10T09:00:00",
             "1999-06-10T09:00:00", "1999-07-10T09:00:00", "2000-06-10T09:00:00", "2000-07-10T09:00:00",
             "2001-06-10T09:00:00", "2001-07-10T09:00:00"]
        )
    }

    func testRule24() {
        // Start 19970310T090000
        // Every other year on January, February, and March for 10 occurrences
        let start = calendar.date(from: DateComponents(year: 1997, month: 3, day: 10, hour: 9))!
        run(rule: "RRULE:FREQ=YEARLY;INTERVAL=2;COUNT=10;BYMONTH=1,2,3", start: start, results:
            ["1997-03-10T09:00:00", "1999-01-10T09:00:00", "1999-02-10T09:00:00", "1999-03-10T09:00:00",
             "2001-01-10T09:00:00", "2001-02-10T09:00:00", "2001-03-10T09:00:00", "2003-01-10T09:00:00",
             "2003-02-10T09:00:00", "2003-03-10T09:00:00"]
        )
    }

    func testRule25() {
        // Start 19970101T090000
        // Every third year on the 1st, 100th, and 200th day for 10 occurrences
        let start = calendar.date(from: DateComponents(year: 1997, month: 1, day: 1, hour: 9))!
        run(rule: "RRULE:FREQ=YEARLY;INTERVAL=3;COUNT=10;BYYEARDAY=1,100,200", start: start, results:
            ["1997-01-01T09:00:00", "1997-04-10T09:00:00", "1997-07-19T09:00:00", "2000-01-01T09:00:00",
             "2000-04-09T09:00:00", "2000-07-18T09:00:00", "2003-01-01T09:00:00", "2003-04-10T09:00:00",
             "2003-07-19T09:00:00", "2006-01-01T09:00:00"]
        )
    }

    func testRule26() {
        // Start 19970519T090000
        // Every 20th Monday of the year, forever
        let start = calendar.date(from: DateComponents(year: 1997, month: 5, day: 19, hour: 9))!
        run(rule: "RRULE:FREQ=YEARLY;BYDAY=20MO", start: start, max: 3, results:
            ["1997-05-19T09:00:00", "1998-05-18T09:00:00", "1999-05-17T09:00:00"]
        )
    }

    func testRule27() {
        // Start 19970512T090000
        // Monday of week number 20 (where the default start of the week is Monday), forever
        let start = calendar.date(from: DateComponents(year: 1997, month: 5, day: 12, hour: 9))!
        run(rule: "RRULE:FREQ=YEARLY;BYWEEKNO=20;BYDAY=MO", start: start, max: 3, results:
            ["1997-05-12T09:00:00", "1998-05-11T09:00:00", "1999-05-17T09:00:00"]
        )
    }

    func testRule28() {
        // Start 19970313T090000
        // Every Thursday in March, forever
        let start = calendar.date(from: DateComponents(year: 1997, month: 3, day: 13, hour: 9))!
        run(rule: "RRULE:FREQ=YEARLY;BYMONTH=3;BYDAY=TH", start: start, max: 11, results:
            ["1997-03-13T09:00:00", "1997-03-20T09:00:00", "1997-03-27T09:00:00", "1998-03-05T09:00:00",
             "1998-03-12T09:00:00", "1998-03-19T09:00:00", "1998-03-26T09:00:00", "1999-03-04T09:00:00",
             "1999-03-11T09:00:00", "1999-03-18T09:00:00", "1999-03-25T09:00:00"]
        )
    }

    func testRule29() {
        // Start 19970605T090000
        // Every Thursday, but only during June, July, and August, forever
        let start = calendar.date(from: DateComponents(year: 1997, month: 6, day: 5, hour: 9))!
        run(rule: "RRULE:FREQ=YEARLY;BYDAY=TH;BYMONTH=6,7,8", start: start, max: 39, results:
            ["1997-06-05T09:00:00", "1997-06-12T09:00:00", "1997-06-19T09:00:00", "1997-06-26T09:00:00",
             "1997-07-03T09:00:00", "1997-07-10T09:00:00", "1997-07-17T09:00:00", "1997-07-24T09:00:00",
             "1997-07-31T09:00:00", "1997-08-07T09:00:00", "1997-08-14T09:00:00", "1997-08-21T09:00:00",
             "1997-08-28T09:00:00", "1998-06-04T09:00:00", "1998-06-11T09:00:00", "1998-06-18T09:00:00",
             "1998-06-25T09:00:00", "1998-07-02T09:00:00", "1998-07-09T09:00:00", "1998-07-16T09:00:00",
             "1998-07-23T09:00:00", "1998-07-30T09:00:00", "1998-08-06T09:00:00", "1998-08-13T09:00:00",
             "1998-08-20T09:00:00", "1998-08-27T09:00:00", "1999-06-03T09:00:00", "1999-06-10T09:00:00",
             "1999-06-17T09:00:00", "1999-06-24T09:00:00", "1999-07-01T09:00:00", "1999-07-08T09:00:00",
             "1999-07-15T09:00:00", "1999-07-22T09:00:00", "1999-07-29T09:00:00", "1999-08-05T09:00:00",
             "1999-08-12T09:00:00", "1999-08-19T09:00:00", "1999-08-26T09:00:00"]
        )
    }

    func testRule30() {
        // Start 19970902T090000
        // Every Friday the 13th, forever
        // NOTE: The spec example for this includes EXDATE;TZID=America/New_York:19970902T090000 so the start date
        //       isn't returned. This test doesn't support that so this results in that one extra date.
        let start = calendar.date(from: DateComponents(year: 1997, month: 9, day: 2, hour: 9))!
        run(rule: "RRULE:FREQ=MONTHLY;BYDAY=FR;BYMONTHDAY=13", start: start, max: 6, results:
            ["1997-09-02T09:00:00", "1998-02-13T09:00:00", "1998-03-13T09:00:00", "1998-11-13T09:00:00",
             "1999-08-13T09:00:00", "2000-10-13T09:00:00"]
        )
    }

    func testRule31() {
        // Start 19970913T090000
        // The first Saturday that follows the first Sunday of the month, forever
        let start = calendar.date(from: DateComponents(year: 1997, month: 9, day: 13, hour: 9))!
        run(rule: "RRULE:FREQ=MONTHLY;BYDAY=SA;BYMONTHDAY=7,8,9,10,11,12,13", start: start, max: 10, results:
            ["1997-09-13T09:00:00", "1997-10-11T09:00:00", "1997-11-08T09:00:00", "1997-12-13T09:00:00",
             "1998-01-10T09:00:00", "1998-02-07T09:00:00", "1998-03-07T09:00:00", "1998-04-11T09:00:00",
             "1998-05-09T09:00:00", "1998-06-13T09:00:00"]
        )
    }

    func testRule32() {
        // 19961105T090000
        // Every 4 years, the first Tuesday after a Monday in November, forever (U.S. Presidential Election day)
        let start = calendar.date(from: DateComponents(year: 1996, month: 11, day: 5, hour: 9))!
        run(rule: "RRULE:FREQ=YEARLY;INTERVAL=4;BYMONTH=11;BYDAY=TU;BYMONTHDAY=2,3,4,5,6,7,8", start: start, max: 3, results:
            ["1996-11-05T09:00:00", "2000-11-07T09:00:00", "2004-11-02T09:00:00"]
        )
    }

    func testRule33() {
        // Start 19970904T090000
        // The third instance into the month of one of Tuesday, Wednesday, or Thursday, for the next 3 months
        let start = calendar.date(from: DateComponents(year: 1997, month: 9, day: 4, hour: 9))!
        run(rule: "RRULE:FREQ=MONTHLY;COUNT=3;BYDAY=TU,WE,TH;BYSETPOS=3", start: start, results:
            ["1997-09-04T09:00:00", "1997-10-07T09:00:00", "1997-11-06T09:00:00"]
        )
    }

    func testRule34() {
        // Start 19970929T090000
        // The second-to-last weekday of the month
        let start = calendar.date(from: DateComponents(year: 1997, month: 9, day: 29, hour: 9))!
        run(rule: "RRULE:FREQ=MONTHLY;BYDAY=MO,TU,WE,TH,FR;BYSETPOS=-2", start: start, max: 7, results:
            ["1997-09-29T09:00:00", "1997-10-30T09:00:00", "1997-11-27T09:00:00", "1997-12-30T09:00:00",
             "1998-01-29T09:00:00", "1998-02-26T09:00:00", "1998-03-30T09:00:00"]
        )
    }

    /*
     func testRule35() {
     run(rule: "RRULE:FREQ=HOURLY;INTERVAL=3;UNTIL=19970902T170000Z") { (rule) in
     }
     }
     */

    /*
     func testRule36() {
     run(rule: "RRULE:FREQ=MINUTELY;INTERVAL=15;COUNT=6") { (rule) in
     }
     }
     */

    /*
     func testRule37() {
     run(rule: "RRULE:FREQ=MINUTELY;INTERVAL=90;COUNT=4") { (rule) in
     }
     }
     */

    /*
     func testRule38() {
     run(rule: "RRULE:FREQ=DAILY;BYHOUR=9,10,11,12,13,14,15,16;BYMINUTE=0,20,40") { (rule) in
     }
     }
     */

    /*
     func testRule39() {
     run(rule: "RRULE:FREQ=MINUTELY;INTERVAL=20;BYHOUR=9,10,11,12,13,14,15,16") { (rule) in
     }
     }
     */

    func testRule40() {
        // Start 19970805T090000
        // An example where the days generated makes a difference because of WKST
        let start = calendar.date(from: DateComponents(year: 1997, month: 8, day: 5, hour: 9))!
        run(rule: "RRULE:FREQ=WEEKLY;INTERVAL=2;COUNT=4;BYDAY=TU,SU;WKST=MO", start: start, results:
            ["1997-08-05T09:00:00", "1997-08-10T09:00:00", "1997-08-19T09:00:00", "1997-08-24T09:00:00"])
    }

    func testRule41() {
        // Start 19970805T090000
        // changing only WKST from MO to SU, yields different results...
        let start = calendar.date(from: DateComponents(year: 1997, month: 8, day: 5, hour: 9))!
        run(rule: "RRULE:FREQ=WEEKLY;INTERVAL=2;COUNT=4;BYDAY=TU,SU;WKST=SU", start: start, results:
            ["1997-08-05T09:00:00", "1997-08-17T09:00:00", "1997-08-19T09:00:00", "1997-08-31T09:00:00"]
        )
    }

    func testRule42() {
        // Start 20070115T090000
        // An example where an invalid date (i.e., February 30) is ignored
        let start = calendar.date(from: DateComponents(year: 2007, month: 1, day: 15, hour: 9))!
        run(rule: "RRULE:FREQ=MONTHLY;BYMONTHDAY=15,30;COUNT=5", start: start, results:
            ["2007-01-15T09:00:00", "2007-01-30T09:00:00", "2007-02-15T09:00:00", "2007-03-15T09:00:00",
             "2007-03-30T09:00:00"]
        )
    }
}
