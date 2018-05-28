//
//  RWMYearlyTests.swift
//  RWMRecurrenceRuleTests
//
//  Created by Richard W Maddy on 5/17/18.
//  Copyright © 2018 Maddysoft. All rights reserved.
//

import XCTest

class RWMYearlyTests: RWMRecurrenceRuleBase {
    // ----------- YEARLY ------------

    // Yearly can use BYMONTH, BYWEEKNO, BYYEARDAY, BYMONTHDAY, BYDAY, BYSETPOS

    func testYearly01() {
        // Start 20180517T090000
        // Yearly with no BYxxx clauses. Should give same date as start date for 3 years
        let start = calendar.date(from: DateComponents(year: 2018, month: 5, day: 17, hour: 9))!
        run(rule: "RRULE:FREQ=YEARLY;COUNT=3", start: start, results:
            ["2018-05-17T09:00:00", "2019-05-17T09:00:00", "2020-05-17T09:00:00"])
    }

    func testYearly02() {
        // Start 20180517T090000
        // Start day in February, April, and June of each year
        let start = calendar.date(from: DateComponents(year: 2018, month: 5, day: 17, hour: 9))!
        run(rule: "RRULE:FREQ=YEARLY;BYMONTH=2,4,6;COUNT=10", start: start, results:
            ["2018-05-17T09:00:00", "2018-06-17T09:00:00", "2019-02-17T09:00:00", "2019-04-17T09:00:00",
             "2019-06-17T09:00:00", "2020-02-17T09:00:00", "2020-04-17T09:00:00", "2020-06-17T09:00:00",
             "2021-02-17T09:00:00", "2021-04-17T09:00:00"]
        )
    }

    func testYearly03() {
        // Start 20180517T090000
        // Every day in the 2nd, 4th, and 6th week of the year
        let start = calendar.date(from: DateComponents(year: 2018, month: 5, day: 17, hour: 9))!
        run(rule: "RRULE:FREQ=YEARLY;BYWEEKNO=2,4,6;COUNT=15", start: start, results:
            ["2018-05-17T09:00:00", "2019-01-07T09:00:00", "2019-01-08T09:00:00", "2019-01-09T09:00:00",
             "2019-01-10T09:00:00", "2019-01-11T09:00:00", "2019-01-12T09:00:00", "2019-01-13T09:00:00",
             "2019-01-21T09:00:00", "2019-01-22T09:00:00", "2019-01-23T09:00:00", "2019-01-24T09:00:00",
             "2019-01-25T09:00:00", "2019-01-26T09:00:00", "2019-01-27T09:00:00"]
        )
    }

    func testYearly04() {
        // Start 20180110T090000
        // Every day in the last week of the year
        let start = calendar.date(from: DateComponents(year: 2018, month: 1, day: 10, hour: 9))!
        run(rule: "RRULE:FREQ=YEARLY;BYWEEKNO=-1;COUNT=45", start: start, results:
            ["2018-01-10T09:00:00", "2018-12-24T09:00:00", "2018-12-25T09:00:00", "2018-12-26T09:00:00",
             "2018-12-27T09:00:00", "2018-12-28T09:00:00", "2018-12-29T09:00:00", "2018-12-30T09:00:00",
             "2019-12-23T09:00:00", "2019-12-24T09:00:00", "2019-12-25T09:00:00", "2019-12-26T09:00:00",
             "2019-12-27T09:00:00", "2019-12-28T09:00:00", "2019-12-29T09:00:00", "2020-12-28T09:00:00",
             "2020-12-29T09:00:00", "2020-12-30T09:00:00", "2020-12-31T09:00:00", "2021-12-27T09:00:00",
             "2021-12-28T09:00:00", "2021-12-29T09:00:00", "2021-12-30T09:00:00", "2021-12-31T09:00:00",
             "2022-12-26T09:00:00", "2022-12-27T09:00:00", "2022-12-28T09:00:00", "2022-12-29T09:00:00",
             "2022-12-30T09:00:00", "2022-12-31T09:00:00", "2023-12-25T09:00:00", "2023-12-26T09:00:00",
             "2023-12-27T09:00:00", "2023-12-28T09:00:00", "2023-12-29T09:00:00", "2023-12-30T09:00:00",
             "2023-12-31T09:00:00", "2024-12-23T09:00:00", "2024-12-24T09:00:00", "2024-12-25T09:00:00",
             "2024-12-26T09:00:00", "2024-12-27T09:00:00", "2024-12-28T09:00:00", "2024-12-29T09:00:00",
             "2025-12-22T09:00:00"]
        )
    }

    func testYearly04a() {
        // Start 20180110T090000
        // Every day in the 53rd week of the year
        let start = calendar.date(from: DateComponents(year: 2018, month: 1, day: 10, hour: 9))!
        run(rule: "RRULE:FREQ=YEARLY;BYWEEKNO=53;COUNT=25", start: start, results:
            ["2018-01-10T09:00:00", "2018-12-31T09:00:00", "2019-12-30T09:00:00", "2019-12-31T09:00:00",
             "2020-12-28T09:00:00", "2020-12-29T09:00:00", "2020-12-30T09:00:00", "2020-12-31T09:00:00",
             "2024-12-30T09:00:00", "2024-12-31T09:00:00", "2025-12-29T09:00:00", "2025-12-30T09:00:00",
             "2025-12-31T09:00:00", "2026-12-28T09:00:00", "2026-12-29T09:00:00", "2026-12-30T09:00:00",
             "2026-12-31T09:00:00", "2029-12-31T09:00:00", "2030-12-30T09:00:00", "2030-12-31T09:00:00",
             "2031-12-29T09:00:00", "2031-12-30T09:00:00", "2031-12-31T09:00:00", "2032-12-27T09:00:00",
             "2032-12-28T09:00:00"]
        )
    }

    func testYearly05() {
        // Start 20180517T090000
        // Every day in the 2nd-to-last, 4th-to-last, and 6th-to-last week of the year
        let start = calendar.date(from: DateComponents(year: 2018, month: 5, day: 17, hour: 9))!
        run(rule: "RRULE:FREQ=YEARLY;BYWEEKNO=-2,-4,-6;COUNT=15", start: start, results:
            ["2018-05-17T09:00:00", "2018-11-19T09:00:00", "2018-11-20T09:00:00", "2018-11-21T09:00:00",
             "2018-11-22T09:00:00", "2018-11-23T09:00:00", "2018-11-24T09:00:00", "2018-11-25T09:00:00",
             "2018-12-03T09:00:00", "2018-12-04T09:00:00", "2018-12-05T09:00:00", "2018-12-06T09:00:00",
             "2018-12-07T09:00:00", "2018-12-08T09:00:00", "2018-12-09T09:00:00"]
        )
    }

    func testYearly06() {
        // Start 20180517T090000
        // The 20th, 45th, and 160th day of each year (Jan 10, Feb 14, and Jun 8 or 9 (depending on leap year))
        let start = calendar.date(from: DateComponents(year: 2018, month: 5, day: 17, hour: 9))!
        run(rule: "RRULE:FREQ=YEARLY;BYYEARDAY=20,45,160;COUNT=10", start: start, results:
            ["2018-05-17T09:00:00", "2018-06-09T09:00:00", "2019-01-20T09:00:00", "2019-02-14T09:00:00",
             "2019-06-09T09:00:00", "2020-01-20T09:00:00", "2020-02-14T09:00:00", "2020-06-08T09:00:00",
             "2021-01-20T09:00:00", "2021-02-14T09:00:00"]
        )
    }

    func testYearly07() {
        // Start 20180517T090000
        // The 20th, 45th, and 160th day of each year (Jan 10, Feb 14, and Jun 8 or 9 (depending on leap year))
        let start = calendar.date(from: DateComponents(year: 2018, month: 5, day: 17, hour: 9))!
        run(rule: "RRULE:FREQ=YEARLY;BYYEARDAY=-1,-150;COUNT=10", start: start, results:
            ["2018-05-17T09:00:00", "2018-08-04T09:00:00", "2018-12-31T09:00:00", "2019-08-04T09:00:00",
             "2019-12-31T09:00:00", "2020-08-04T09:00:00", "2020-12-31T09:00:00", "2021-08-04T09:00:00",
             "2021-12-31T09:00:00", "2022-08-04T09:00:00"]
        )
    }

    func testYearly08() {
        // Start 20180517T090000
        // The 4th, 8th, and 12th of each month of the year
        let start = calendar.date(from: DateComponents(year: 2018, month: 5, day: 17, hour: 9))!
        run(rule: "RRULE:FREQ=YEARLY;BYMONTHDAY=4,8,12;COUNT=10", start: start, results:
            ["2018-05-17T09:00:00", "2018-06-04T09:00:00", "2018-06-08T09:00:00", "2018-06-12T09:00:00",
             "2018-07-04T09:00:00", "2018-07-08T09:00:00", "2018-07-12T09:00:00", "2018-08-04T09:00:00",
             "2018-08-08T09:00:00", "2018-08-12T09:00:00"]
        )
    }

    func testYearly09() {
        // Start 20180517T090000
        // Every Sunday of the year
        let start = calendar.date(from: DateComponents(year: 2018, month: 5, day: 17, hour: 9))!
        run(rule: "RRULE:FREQ=YEARLY;BYDAY=SU;COUNT=10", start: start, results:
            ["2018-05-17T09:00:00", "2018-05-20T09:00:00", "2018-05-27T09:00:00", "2018-06-03T09:00:00",
             "2018-06-10T09:00:00", "2018-06-17T09:00:00", "2018-06-24T09:00:00", "2018-07-01T09:00:00",
             "2018-07-08T09:00:00", "2018-07-15T09:00:00"]
        )
    }

    func testYearly10() {
        // Start 20180517T090000
        // Every Monday of the year and the 23rd Thursday of the year
        let start = calendar.date(from: DateComponents(year: 2018, month: 5, day: 17, hour: 9))!
        run(rule: "RRULE:FREQ=YEARLY;BYDAY=MO,23TH;COUNT=10", start: start, results:
            ["2018-05-17T09:00:00", "2018-05-21T09:00:00", "2018-05-28T09:00:00", "2018-06-04T09:00:00",
             "2018-06-07T09:00:00", "2018-06-11T09:00:00", "2018-06-18T09:00:00", "2018-06-25T09:00:00",
             "2018-07-02T09:00:00", "2018-07-09T09:00:00"]
        )
    }

    func testYearly11() {
        // Start 20180517T090000
        // The last Thursday, 10th-to-last Thursday, and 15th-to-last Wednesday of each year
        let start = calendar.date(from: DateComponents(year: 2018, month: 5, day: 17, hour: 9))!
        run(rule: "RRULE:FREQ=YEARLY;BYDAY=-1TH,-10TH,-15WE;COUNT=10", start: start, results:
            ["2018-05-17T09:00:00", "2018-09-19T09:00:00", "2018-10-25T09:00:00", "2018-12-27T09:00:00",
             "2019-09-18T09:00:00", "2019-10-24T09:00:00", "2019-12-26T09:00:00", "2020-09-23T09:00:00",
             "2020-10-29T09:00:00", "2020-12-31T09:00:00"]
        )
    }

    func testYearly12() {
        // Start 20180517T090000
        // Days from the 5th week of the year falling in February
        let start = calendar.date(from: DateComponents(year: 2018, month: 5, day: 17, hour: 9))!
        run(rule: "RRULE:FREQ=YEARLY;BYWEEKNO=5;BYMONTH=2;COUNT=10", start: start, results:
            ["2018-05-17T09:00:00", "2019-02-01T09:00:00", "2019-02-02T09:00:00", "2019-02-03T09:00:00",
             "2020-02-01T09:00:00", "2020-02-02T09:00:00", "2021-02-01T09:00:00", "2021-02-02T09:00:00",
             "2021-02-03T09:00:00", "2021-02-04T09:00:00"]
        )
    }

    func testYearly13() {
        // Start 20180517T090000
        // Days from the 6th-to-last and 10th-to-last weeks of the year falling in October or December
        let start = calendar.date(from: DateComponents(year: 2018, month: 5, day: 17, hour: 9))!
        run(rule: "RRULE:FREQ=YEARLY;BYWEEKNO=-6,-10;BYMONTH=12,10;COUNT=10", start: start, results:
            ["2018-05-17T09:00:00", "2018-10-22T09:00:00", "2018-10-23T09:00:00", "2018-10-24T09:00:00",
             "2018-10-25T09:00:00", "2018-10-26T09:00:00", "2018-10-27T09:00:00", "2018-10-28T09:00:00",
             "2019-10-21T09:00:00", "2019-10-22T09:00:00"]
        )
    }

    func testYearly14() {
        // Start 20180517T090000
        // The 20th, 45th, and 160th day of each year falling in June (Jun 8 or 9 (depending on leap year))
        let start = calendar.date(from: DateComponents(year: 2018, month: 5, day: 17, hour: 9))!
        run(rule: "RRULE:FREQ=YEARLY;BYMONTH=6;BYYEARDAY=20,45,160;COUNT=5", start: start, results:
            ["2018-05-17T09:00:00", "2018-06-09T09:00:00", "2019-06-09T09:00:00", "2020-06-08T09:00:00",
             "2021-06-09T09:00:00"]
        )
    }

    func testYearly15() {
        // Start 20180517T090000
        // The 4th, 8th, and 12th of April, May, and June of the year
        let start = calendar.date(from: DateComponents(year: 2018, month: 5, day: 17, hour: 9))!
        run(rule: "RRULE:FREQ=YEARLY;BYMONTH=4,5,6;BYMONTHDAY=4,8,12;COUNT=10", start: start, results:
            ["2018-05-17T09:00:00", "2018-06-04T09:00:00", "2018-06-08T09:00:00", "2018-06-12T09:00:00",
             "2019-04-04T09:00:00", "2019-04-08T09:00:00", "2019-04-12T09:00:00", "2019-05-04T09:00:00",
             "2019-05-08T09:00:00", "2019-05-12T09:00:00"]
        )
    }

    func testYearly16() {
        // Start 20180517T090000
        // The last and 15th-to-last day of September and October
        let start = calendar.date(from: DateComponents(year: 2018, month: 5, day: 17, hour: 9))!
        run(rule: "RRULE:FREQ=YEARLY;BYMONTH=9,10;BYMONTHDAY=-1,-15;COUNT=10", start: start, results:
            ["2018-05-17T09:00:00", "2018-09-16T09:00:00", "2018-09-30T09:00:00", "2018-10-17T09:00:00",
             "2018-10-31T09:00:00", "2019-09-16T09:00:00", "2019-09-30T09:00:00", "2019-10-17T09:00:00",
             "2019-10-31T09:00:00", "2020-09-16T09:00:00"]
        )
    }

    func testYearly16a() {
        // Start 20180517T090000
        // Leap days
        let start = calendar.date(from: DateComponents(year: 2018, month: 5, day: 17, hour: 9))!
        run(rule: "RRULE:FREQ=YEARLY;BYMONTH=2;BYMONTHDAY=29;COUNT=5", start: start, results:
            ["2018-05-17T09:00:00", "2020-02-29T09:00:00", "2024-02-29T09:00:00", "2028-02-29T09:00:00",
             "2032-02-29T09:00:00"]
        )
    }

    func testYearly17() {
        // Start 20180517T090000
        // Every Tuesday and Thursday in April and October
        let start = calendar.date(from: DateComponents(year: 2018, month: 5, day: 17, hour: 9))!
        run(rule: "RRULE:FREQ=YEARLY;BYMONTH=4,10;BYDAY=TU,TH;COUNT=15", start: start, results:
            ["2018-05-17T09:00:00", "2018-10-02T09:00:00", "2018-10-04T09:00:00", "2018-10-09T09:00:00",
             "2018-10-11T09:00:00", "2018-10-16T09:00:00", "2018-10-18T09:00:00", "2018-10-23T09:00:00",
             "2018-10-25T09:00:00", "2018-10-30T09:00:00", "2019-04-02T09:00:00", "2019-04-04T09:00:00",
             "2019-04-09T09:00:00", "2019-04-11T09:00:00", "2019-04-16T09:00:00"]
        )
    }

    func testYearly18() {
        // Start 20180517T090000
        // The first Tuesday and Thursday of May, July, and September
        let start = calendar.date(from: DateComponents(year: 2018, month: 5, day: 17, hour: 9))!
        run(rule: "RRULE:FREQ=YEARLY;BYMONTH=5,7,9;BYDAY=1TU,1TH;COUNT=15", start: start, results:
            ["2018-05-17T09:00:00", "2018-07-03T09:00:00", "2018-07-05T09:00:00", "2018-09-04T09:00:00",
             "2018-09-06T09:00:00", "2019-05-02T09:00:00", "2019-05-07T09:00:00", "2019-07-02T09:00:00",
             "2019-07-04T09:00:00", "2019-09-03T09:00:00", "2019-09-05T09:00:00", "2020-05-05T09:00:00",
             "2020-05-07T09:00:00", "2020-07-02T09:00:00", "2020-07-07T09:00:00"]
        )
    }

    func testYearly19() {
        // Start 20180517T090000
        // The 2nd Monday and 2nd-to-last Friday in January and December
        let start = calendar.date(from: DateComponents(year: 2018, month: 5, day: 17, hour: 9))!
        run(rule: "RRULE:FREQ=YEARLY;BYMONTH=1,12;BYDAY=2MO,-2FR;COUNT=15", start: start, results:
            ["2018-05-17T09:00:00", "2018-12-10T09:00:00", "2018-12-21T09:00:00", "2019-01-14T09:00:00",
             "2019-01-18T09:00:00", "2019-12-09T09:00:00", "2019-12-20T09:00:00", "2020-01-13T09:00:00",
             "2020-01-24T09:00:00", "2020-12-14T09:00:00", "2020-12-18T09:00:00", "2021-01-11T09:00:00",
             "2021-01-22T09:00:00", "2021-12-13T09:00:00", "2021-12-24T09:00:00"]
        )
    }

    func testYearly20() {
        // Start 20180517T090000
        // The 10th, 27th, and 40th days of the year if also in the 2nd, 4th, or 6th week of the year
        let start = calendar.date(from: DateComponents(year: 2018, month: 5, day: 17, hour: 9))!
        run(rule: "RRULE:FREQ=YEARLY;BYWEEKNO=2,4,6;BYYEARDAY=10,27,40;COUNT=15", start: start, results:
            ["2018-05-17T09:00:00", "2019-01-10T09:00:00", "2019-01-27T09:00:00", "2019-02-09T09:00:00",
             "2020-01-10T09:00:00", "2020-02-09T09:00:00", "2021-01-27T09:00:00", "2021-02-09T09:00:00",
             "2022-01-10T09:00:00", "2022-01-27T09:00:00", "2022-02-09T09:00:00", "2023-01-10T09:00:00",
             "2023-01-27T09:00:00", "2023-02-09T09:00:00", "2024-01-10T09:00:00"]
        )
    }

    func testYearly21() {
        // Start 20180517T090000
        // The 357 and 21st-to-last days of the year if also in the 2nd-to-last or 4th-to-last week of the year
        let start = calendar.date(from: DateComponents(year: 2018, month: 5, day: 17, hour: 9))!
        run(rule: "RRULE:FREQ=YEARLY;BYWEEKNO=-2,-4;BYYEARDAY=357,-21;COUNT=15", start: start, results:
            ["2018-05-17T09:00:00", "2018-12-23T09:00:00", "2020-12-11T09:00:00", "2020-12-22T09:00:00",
             "2021-12-11T09:00:00", "2021-12-23T09:00:00", "2022-12-11T09:00:00", "2022-12-23T09:00:00",
             "2023-12-23T09:00:00", "2024-12-22T09:00:00", "2026-12-11T09:00:00", "2026-12-23T09:00:00",
             "2027-12-11T09:00:00", "2027-12-23T09:00:00", "2028-12-22T09:00:00"]
        )
    }

    func testYearly22() {
        // Start 20180517T090000
        // The 3rd and 4th day of each month if in the 5th week of the year
        let start = calendar.date(from: DateComponents(year: 2018, month: 5, day: 17, hour: 9))!
        run(rule: "RRULE:FREQ=YEARLY;BYWEEKNO=5;BYMONTHDAY=3,4;COUNT=10", start: start, results:
            ["2018-05-17T09:00:00", "2019-02-03T09:00:00", "2021-02-03T09:00:00", "2021-02-04T09:00:00",
             "2022-02-03T09:00:00", "2022-02-04T09:00:00", "2023-02-03T09:00:00", "2023-02-04T09:00:00",
             "2024-02-03T09:00:00", "2024-02-04T09:00:00"]
        )
    }

    func testYearly23() {
        // Start 20180517T090000
        // The 29th of each month if in the last week of the year
        let start = calendar.date(from: DateComponents(year: 2018, month: 5, day: 17, hour: 9))!
        run(rule: "RRULE:FREQ=YEARLY;BYWEEKNO=-1;BYMONTHDAY=29;COUNT=10", start: start, results:
             ["2018-05-17T09:00:00", "2018-12-29T09:00:00", "2019-12-29T09:00:00", "2020-12-29T09:00:00",
              "2021-12-29T09:00:00", "2022-12-29T09:00:00", "2023-12-29T09:00:00", "2024-12-29T09:00:00",
              "2026-12-29T09:00:00", "2027-12-29T09:00:00"]
        )
    }

    func testYearly24() {
        // Start 20180517T090000
        // The Monday, Wednesday, and Friday in the 3rd week of the year
        let start = calendar.date(from: DateComponents(year: 2018, month: 5, day: 17, hour: 9))!
        run(rule: "RRULE:FREQ=YEARLY;BYWEEKNO=3;BYDAY=MO,WE,FR;COUNT=10", start: start, results :
            ["2018-05-17T09:00:00", "2019-01-14T09:00:00", "2019-01-16T09:00:00", "2019-01-18T09:00:00",
             "2020-01-13T09:00:00", "2020-01-15T09:00:00", "2020-01-17T09:00:00", "2021-01-18T09:00:00",
             "2021-01-20T09:00:00", "2021-01-22T09:00:00"]
        )
    }

    func testYearly25() {
        // Start 20180517T090000
        // The Monday, Wednesday, and Friday in the 3rd-to-last week of the year
        let start = calendar.date(from: DateComponents(year: 2018, month: 5, day: 17, hour: 9))!
        run(rule: "RRULE:FREQ=YEARLY;BYWEEKNO=-3;BYDAY=MO,WE,FR;COUNT=10", start: start, results:
            ["2018-05-17T09:00:00", "2018-12-10T09:00:00", "2018-12-12T09:00:00", "2018-12-14T09:00:00",
             "2019-12-09T09:00:00", "2019-12-11T09:00:00", "2019-12-13T09:00:00", "2020-12-14T09:00:00",
             "2020-12-16T09:00:00", "2020-12-18T09:00:00"]
        )
    }

    func testYearly26() {
        // Start 20180517T090000
        // The 160th day of each year (Jun 8 or 9 (depending on leap year)) that is also the 9th of the month
        let start = calendar.date(from: DateComponents(year: 2018, month: 5, day: 17, hour: 9))!
        run(rule: "RRULE:FREQ=YEARLY;BYYEARDAY=160;BYMONTHDAY=9;COUNT=10", start: start, results:
            ["2018-05-17T09:00:00", "2018-06-09T09:00:00", "2019-06-09T09:00:00", "2021-06-09T09:00:00",
             "2022-06-09T09:00:00", "2023-06-09T09:00:00", "2025-06-09T09:00:00", "2026-06-09T09:00:00",
             "2027-06-09T09:00:00", "2029-06-09T09:00:00"]
        )
    }

    func testYearly27() {
        // Start 20180517T090000
        // The 160th day of each year (Jun 8 or 9 (depending on leap year)) that is also on a Tuesday or Thursday
        let start = calendar.date(from: DateComponents(year: 2018, month: 5, day: 17, hour: 9))!
        run(rule: "RRULE:FREQ=YEARLY;BYYEARDAY=160;BYDAY=TU,TH;COUNT=5", start: start, results:
            ["2018-05-17T09:00:00", "2022-06-09T09:00:00", "2026-06-09T09:00:00", "2028-06-08T09:00:00",
             "2032-06-08T09:00:00"]
        )
    }

    func testYearly28() {
        // Start 20180517T090000
        // The 160th day of each year (Jun 8 or 9 (depending on leap year)) that is also on a Tuesday or Thursday
        let start = calendar.date(from: DateComponents(year: 2018, month: 5, day: 17, hour: 9))!
        run(rule: "RRULE:FREQ=YEARLY;BYMONTHDAY=5,10,15;BYDAY=TU,TH;COUNT=15", start: start, results:
            ["2018-05-17T09:00:00", "2018-06-05T09:00:00", "2018-07-05T09:00:00", "2018-07-10T09:00:00",
             "2018-11-15T09:00:00", "2019-01-10T09:00:00", "2019-01-15T09:00:00", "2019-02-05T09:00:00",
             "2019-03-05T09:00:00", "2019-08-15T09:00:00", "2019-09-05T09:00:00", "2019-09-10T09:00:00",
             "2019-10-10T09:00:00", "2019-10-15T09:00:00", "2019-11-05T09:00:00"]
        )
    }

    func testYearly29() {
        // Start 20180517T090000
        // The 160th day of each year (Jun 8 or 9 (depending on leap year)) that is also on a Tuesday or Thursday
        let start = calendar.date(from: DateComponents(year: 2018, month: 5, day: 17, hour: 9))!
        run(rule: "RRULE:FREQ=YEARLY;BYMONTHDAY=-1,-2;BYDAY=SA,SU;COUNT=15", start: start, results:
            ["2018-05-17T09:00:00", "2018-06-30T09:00:00", "2018-09-29T09:00:00", "2018-09-30T09:00:00",
             "2018-12-30T09:00:00", "2019-03-30T09:00:00", "2019-03-31T09:00:00", "2019-06-29T09:00:00",
             "2019-06-30T09:00:00", "2019-08-31T09:00:00", "2019-09-29T09:00:00", "2019-11-30T09:00:00",
             "2020-02-29T09:00:00", "2020-05-30T09:00:00", "2020-05-31T09:00:00"]
        )
    }

    func testYearly30() {
        // Start 20180517T090000
        // The 160th day of each year (Jun 8 or 9 (depending on leap year)) that is also on a Tuesday or Thursday
        let start = calendar.date(from: DateComponents(year: 2018, month: 5, day: 17, hour: 9))!
        run(rule: "RRULE:FREQ=YEARLY;BYMONTHDAY=1,-1;BYDAY=1SA,1SU,-1SA,-1SU;COUNT=15", start: start, results:
            ["2018-05-17T09:00:00", "2018-06-30T09:00:00", "2018-07-01T09:00:00", "2018-09-01T09:00:00",
             "2018-09-30T09:00:00", "2018-12-01T09:00:00", "2019-03-31T09:00:00", "2019-06-01T09:00:00",
             "2019-06-30T09:00:00", "2019-08-31T09:00:00", "2019-09-01T09:00:00", "2019-11-30T09:00:00",
             "2019-12-01T09:00:00", "2020-02-01T09:00:00", "2020-02-29T09:00:00"]
        )
    }

    func testYearly31() {
        // Start 20180517T090000
        // Days from the 5th week of the year falling in February that are also either the 33rd or 34th day of the year
        let start = calendar.date(from: DateComponents(year: 2018, month: 5, day: 17, hour: 9))!
        run(rule: "RRULE:FREQ=YEARLY;BYWEEKNO=5;BYMONTH=2;BYYEARDAY=33,34;COUNT=10", start: start, results:
            ["2018-05-17T09:00:00", "2019-02-02T09:00:00", "2019-02-03T09:00:00", "2020-02-02T09:00:00",
             "2021-02-02T09:00:00", "2021-02-03T09:00:00", "2022-02-02T09:00:00", "2022-02-03T09:00:00",
             "2023-02-02T09:00:00", "2023-02-03T09:00:00"]
        )
    }

    func testYearly32() {
        // Start 20180517T090000
        // Days from the 6th-to-last and 10th-to-last weeks of the year falling in October or December that are also eith the 297th or 70th-to-last day of the year
        let start = calendar.date(from: DateComponents(year: 2018, month: 5, day: 17, hour: 9))!
        run(rule: "RRULE:FREQ=YEARLY;BYWEEKNO=-6,-10;BYMONTH=12,10;BYYEARDAY=297,-70;COUNT=10", start: start, results:
            ["2018-05-17T09:00:00", "2018-10-23T09:00:00", "2018-10-24T09:00:00", "2019-10-23T09:00:00",
             "2019-10-24T09:00:00", "2022-10-24T09:00:00", "2023-10-23T09:00:00", "2023-10-24T09:00:00",
             "2024-10-23T09:00:00", "2025-10-23T09:00:00"]
        )
    }

    func testYearly33() {
        // Start 20180517T090000
        // The 2nd, 4th, 6th, 8th, and 10th of February and March that fall on the 5th or 10th week of the year
        let start = calendar.date(from: DateComponents(year: 2018, month: 5, day: 17, hour: 9))!
        run(rule: "RRULE:FREQ=YEARLY;BYMONTH=2,3;BYWEEKNO=5,10;BYMONTHDAY=2,4,6,8,10;COUNT=10", start: start, results:
            ["2018-05-17T09:00:00", "2019-02-02T09:00:00", "2019-03-04T09:00:00", "2019-03-06T09:00:00",
             "2019-03-08T09:00:00", "2019-03-10T09:00:00", "2020-02-02T09:00:00", "2020-03-02T09:00:00",
             "2020-03-04T09:00:00", "2020-03-06T09:00:00"]
        )
    }

    func testYearly34() {
        // Start 20180517T090000
        // The 2nd, 4th, 6th, and 8th of February and March that fall on a Wednesday or Saturday
        let start = calendar.date(from: DateComponents(year: 2018, month: 5, day: 17, hour: 9))!
        run(rule: "RRULE:FREQ=YEARLY;BYMONTH=2,3;BYDAY=WE,SA;BYMONTHDAY=2,4,6,8;COUNT=10", start: start, results:
            ["2018-05-17T09:00:00", "2019-02-02T09:00:00", "2019-02-06T09:00:00", "2019-03-02T09:00:00",
             "2019-03-06T09:00:00", "2020-02-08T09:00:00", "2020-03-04T09:00:00", "2021-02-06T09:00:00",
             "2021-03-06T09:00:00", "2022-02-02T09:00:00"]
        )
    }

    func testYearly35() {
        // Start 20180517T090000
        // The 3rd and 31st of a month that is also The 62nd or last day of the year falling in week number 9 or 52
        let start = calendar.date(from: DateComponents(year: 2018, month: 5, day: 17, hour: 9))!
        run(rule: "RRULE:FREQ=YEARLY;BYWEEKNO=9,52;BYYEARDAY=62,-1;BYMONTHDAY=3,31;COUNT=10", start: start, results:
            ["2018-05-17T09:00:00", "2019-03-03T09:00:00", "2021-03-03T09:00:00", "2021-12-31T09:00:00",
             "2022-03-03T09:00:00", "2022-12-31T09:00:00", "2023-03-03T09:00:00", "2023-12-31T09:00:00",
             "2027-03-03T09:00:00", "2027-12-31T09:00:00"]
        )
    }

    func testYearly36() {
        // Start 20180517T090000
        // The 62nd or last day of the year falling in the 9th or 52nd week of the year and also falling on a Monday, Wednesday, or Friday
        let start = calendar.date(from: DateComponents(year: 2018, month: 5, day: 17, hour: 9))!
        run(rule: "RRULE:FREQ=YEARLY;BYWEEKNO=9,52;BYYEARDAY=62,-1;BYDAY=MO,WE,FR;COUNT=5", start: start, results:
            ["2018-05-17T09:00:00", "2021-03-03T09:00:00", "2021-12-31T09:00:00", "2023-03-03T09:00:00",
             "2027-03-03T09:00:00"]
        )
    }

    func testYearly37() {
        // Start 20180517T090000
        // The 3rd and 31st of a month that is also The 62nd or last day of the year falling on a Monday, Tuesday, Wednesday, or Thursday
        let start = calendar.date(from: DateComponents(year: 2018, month: 5, day: 17, hour: 9))!
        run(rule: "RRULE:FREQ=YEARLY;BYYEARDAY=62,-1;BYMONTHDAY=3,31;BYDAY=MO,TU,WE,TH;COUNT=10", start: start, results:
            ["2018-05-17T09:00:00", "2018-12-31T09:00:00", "2019-12-31T09:00:00", "2020-12-31T09:00:00",
             "2021-03-03T09:00:00", "2022-03-03T09:00:00", "2024-12-31T09:00:00", "2025-03-03T09:00:00",
             "2025-12-31T09:00:00", "2026-03-03T09:00:00"]
        )
    }

    // TODO - there should be tests with the 5 combinations of 4 "BY" clauses and 1 with all 5 (not counting BYSETPOS)

    // With 4
    // BYWEEKNO, BYYEARDAY, BYMONTHDAY, BYDAY
    // BYMONTH, BYYEARDAY, BYMONTHDAY, BYDAY
    // BYMONTH, BYWEEKNO, BYMONTHDAY, BYDAY
    // BYMONTH, BYWEEKNO, BYYEARDAY, BYDAY
    // BYMONTH, BYWEEKNO, BYYEARDAY, BYMONTHDAY

    // All 5
    // BYMONTH, BYWEEKNO, BYYEARDAY, BYMONTHDAY, BYDAY

    // TODO - need lots of test using BYSETPOS with lots of various combinations of the other 5 "BY" clauses
}
