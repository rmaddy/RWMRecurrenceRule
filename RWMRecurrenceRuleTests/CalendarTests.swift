//
//  CalendarTests.swift
//  RWMRecurrenceRuleTests
//
//  Created by Richard W Maddy on 5/19/18.
//  Copyright © 2018 Maddysoft. All rights reserved.
//

import XCTest

class CalendarTests: XCTestCase {
    func testWeeklyMonth() {
        let results2018: [[Int]] = [
            [4,5,5,5,4,4,4], // Jan
            [4,4,4,4,4,4,4], // Feb
            [4,4,4,4,5,5,5], // Mar
            [5,5,4,4,4,4,4], // Apr
            [4,4,5,5,5,4,4], // May
            [4,4,4,4,4,5,5], // Jun
            [5,5,5,4,4,4,4], // Jul
            [4,4,4,5,5,5,4], // Aug
            [5,4,4,4,4,4,5], // Sep
            [4,5,5,5,4,4,4], // Oct
            [4,4,4,4,5,5,4], // Nov
            [5,5,4,4,4,4,5]  // Dec
        ]

        let cal = Calendar(identifier: .iso8601)

        for (month,monthResults) in results2018.enumerated() {
            for (weekday,result) in monthResults.enumerated() {
                if let range = cal.range(of: weekday + 1, in: 2018, month: month + 1) {
                    XCTAssert(range.count == result, "Incorrect result \(range.count) (expected \(result)) for \(cal.weekdaySymbols[weekday]) \(cal.monthSymbols[month]) 2018")
                } else {
                    XCTAssert(false, "Nil result for \(cal.weekdaySymbols[weekday]) \(cal.monthSymbols[month]) 2018")
                }
            }
        }
    }

    func testWeeklyYear() {
        let results: [Int: [Int]] = [
            2018: [52,53,52,52,52,52,52],
            2019: [52,52,53,52,52,52,52],
            2020: [52,52,52,53,53,52,52],
        ]

        let cal = Calendar(identifier: .iso8601)

        for yearData in results {
            for (weekday,result) in yearData.value.enumerated() {
                if let range = cal.range(of: weekday + 1, in: yearData.key) {
                    XCTAssert(range.count == result, "Incorrect result \(range.count) (expected \(result)) for \(cal.weekdaySymbols[weekday]) \(yearData.key)")
                } else {
                    XCTAssert(false, "Nil result for \(cal.weekdaySymbols[weekday]) \(yearData.key)")
                }
            }
        }
    }

    func checkRelativeMonthDate(year: Int, month: Int, weekday: Int, ordinal: Int, resultDay: Int) {
        let cal = Calendar(identifier: .iso8601)

        let comps = DateComponents(year: year, month: month, weekday: weekday, weekdayOrdinal: ordinal)
        let result = cal.date(from: DateComponents(year: year, month: month, day: resultDay))!
        if let date = cal.date(fromRelative: comps) {
            XCTAssert(date == result, "Expected \(result), got \(date)")
        } else {
            XCTAssert(false, "No date")
        }
    }

    func checkRelativeYearDate(year: Int, weekday: Int, ordinal: Int, resultMonth: Int, resultDay: Int) {
        let cal = Calendar(identifier: .iso8601)

        let comps = DateComponents(year: year, weekday: weekday, weekdayOrdinal: ordinal)
        let result = cal.date(from: DateComponents(year: year, month: resultMonth, day: resultDay))!
        if let date = cal.date(fromRelative: comps) {
            XCTAssert(date == result, "Expected \(result), got \(date)")
        } else {
            XCTAssert(false, "No date")
        }
    }

    func checkRelativeDayDate(year: Int, day: Int, resultMonth: Int, resultDay: Int) {
        let cal = Calendar(identifier: .iso8601)

        let comps = DateComponents(year: year, day: day)
        let result = cal.date(from: DateComponents(year: year, month: resultMonth, day: resultDay))!
        if let date = cal.date(fromRelative: comps) {
            XCTAssert(date == result, "Expected \(result), got \(date)")
        } else {
            XCTAssert(false, "No date")
        }
    }

    func checkRelativeMonthDayDate(year: Int, month: Int, dayOrdinal: Int, resultDay: Int) {
        let cal = Calendar(identifier: .iso8601)

        let comps = DateComponents(year: year, month: month, day: dayOrdinal)
        let result = cal.date(from: DateComponents(year: year, month: month, day: resultDay))!
        if let date = cal.date(fromRelative: comps) {
            XCTAssert(date == result, "Expected \(result), got \(date)")
        } else {
            XCTAssert(false, "No date")
        }
    }

    func testRelativeData01() {
        // Third Tuesday of January
        checkRelativeMonthDate(year: 2018, month: 1, weekday: 3, ordinal: 3, resultDay: 16)
    }

    func testRelativeData02() {
        // Third-to-last Thursday of January
        checkRelativeMonthDate(year: 2018, month: 1, weekday: 5, ordinal: -3, resultDay: 11)
    }

    func testRelativeData03() {
        // First Sunday of January
        checkRelativeMonthDate(year: 2018, month: 1, weekday: 1, ordinal: 1, resultDay: 7)
    }

    func testRelativeData04() {
        // Last Sunday of January
        checkRelativeMonthDate(year: 2018, month: 1, weekday: 1, ordinal: -1, resultDay: 28)
    }

    func testRelativeData10() {
        // First Sunday of the year
        checkRelativeYearDate(year: 2018, weekday: 1, ordinal: 1, resultMonth: 1, resultDay: 7)
    }

    func testRelativeData11() {
        // Last Sunday of the year
        checkRelativeYearDate(year: 2018, weekday: 1, ordinal: -1, resultMonth: 12, resultDay: 30)
    }

    func testRelativeData12() {
        // 20th Wednesday of the year
        checkRelativeYearDate(year: 2018, weekday: 4, ordinal: 20, resultMonth: 5, resultDay: 16)
    }

    func testRelativeData13() {
        // 8th-to-last Saturday of the year
        checkRelativeYearDate(year: 2018, weekday: 7, ordinal: -8, resultMonth: 11, resultDay: 10)
    }

    func testRelativeData20() {
        // First day of year
        checkRelativeDayDate(year: 2018, day: 1, resultMonth: 1, resultDay: 1)
    }

    func testRelativeData21() {
        // Last day of the year
        checkRelativeDayDate(year: 2018, day: -1, resultMonth: 12, resultDay: 31)
    }

    func testRelativeData22() {
        // 100th day of the year
        checkRelativeDayDate(year: 2018, day: 100, resultMonth: 4, resultDay: 10)
    }

    func testRelativeData23() {
        // 76th-to-last day of the year
        checkRelativeDayDate(year: 2018, day: -76, resultMonth: 10, resultDay: 17)
    }

    func testRelativeData30() {
        // First day of February
        checkRelativeMonthDayDate(year: 2018, month: 2, dayOrdinal: 1, resultDay: 1)
    }

    func testRelativeData31() {
        // Last day of February
        checkRelativeMonthDayDate(year: 2018, month: 2, dayOrdinal: -1, resultDay: 28)
    }

    func testRelativeData32() {
        // 7th day of July
        checkRelativeMonthDayDate(year: 2018, month: 7, dayOrdinal: 10, resultDay: 10)
    }

    func testRelativeData33() {
        // 10th-to-last day of October
        checkRelativeMonthDayDate(year: 2018, month: 10, dayOrdinal: -10, resultDay: 22)
    }
}
