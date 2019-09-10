//
//  FinalMiniProject__WhatApp_Tests.swift
//  FinalMiniProject(@WhatApp)Tests
//
//  Created by Keith Wong on 7/26/19.
//  Copyright © 2019 Keith Wong. All rights reserved.
//

import XCTest
@testable import FinalMiniProject__WhatApp_

class FinalMiniProject__WhatApp_Tests: XCTestCase {

    func testVenueInitSuccess()
    {
        let zeroCase = Venue.init(userid: "Sample", venue: "Sample", type: "Sample", photo: nil, rate: 0, food: "default", serv: "default", cost: "default")
        XCTAssertNotNil(zeroCase)
        let posiCase = Venue.init(userid: "Sample", venue: "Sample", type: "Sample", photo: nil, rate: 5, food: "default", serv: "default", cost: "default")
        XCTAssertNotNil(posiCase)
    }
    func testVenueInitFail()
    {
        let emptyCase = Venue.init(userid: "", venue: "", type: "", photo: nil, rate: 0, food: "default", serv: "default", cost: "default")
        XCTAssertNil(emptyCase)
        let negaCase = Venue.init(userid: "Sample", venue: "Sample", type: "Sample", photo: nil, rate: -1, food: "default", serv: "default", cost: "default")
        XCTAssertNil(negaCase)
        let overCase = Venue.init(userid: "Sample", venue: "Sample", type: "Sample", photo: nil, rate: 6, food: "default", serv: "default", cost: "default")
        XCTAssertNil(overCase)
    }
}
