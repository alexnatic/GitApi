//
//  GitApiTests.swift
//  GitApiTests
//
//  Created by Alex Natic on 1/29/21.
//

import XCTest
@testable import GitApi

class GitApiTests: XCTestCase {

    let vc : ViewController? = ViewController()
    
    override func setUp() {
        super.setUp()
        vc?.getGitCommits()
        XCTAssertNil(vc?.errorStatus)
    }

    override func tearDown() {
        super.tearDown()
    }

}
