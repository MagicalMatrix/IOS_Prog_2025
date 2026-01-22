//
//  Zad7UITests.swift
//  Zad7UITests
//
//  Created by user279431 on 1/21/26.
//

import XCTest

final class Zad7UITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        let b0 = app.buttons["0"]
        let b1 = app.buttons["1"]
        let b2 = app.buttons["2"]
        let b3 = app.buttons["3"]
        let b4 = app.buttons["4"]
        let b5 = app.buttons["5"]
        let b6 = app.buttons["6"]
        let b7 = app.buttons["7"]
        let b8 = app.buttons["8"]
        let b9 = app.buttons["9"]
        let bAC = app.buttons["AC"]
        let beq = app.buttons["="]
        let bsum = app.buttons["+"]
        let bdiff = app.buttons["-"]
        let bmul = app.buttons["*"]
        let bdiv = app.buttons["/"]
        let bmod = app.buttons["%"]
        let blog = app.buttons["log"]
        let bpow = app.buttons["pow"]
        
        //let resultField = app.staticTexts.element(matching: any, identifier: "result").label
        //let bufferField = app.label["Calc buffer"]
        let resultField = app/*@START_MENU_TOKEN@*/.staticTexts["result"]/*[[".staticTexts[\"53.0\"]",".staticTexts[\"result\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let bufferField = app.staticTexts["buffer"]

        //check button existance
        XCTAssertTrue(b0.exists)
        XCTAssertTrue(b1.exists)
        XCTAssertTrue(b2.exists)
        XCTAssertTrue(b3.exists)
        XCTAssertTrue(b4.exists)
        XCTAssertTrue(b5.exists)
        XCTAssertTrue(b6.exists)
        XCTAssertTrue(b7.exists)
        XCTAssertTrue(b8.exists)
        XCTAssertTrue(b9.exists)
        XCTAssertTrue(bAC.exists)
        XCTAssertTrue(beq.exists)
        XCTAssertTrue(bsum.exists)
        XCTAssertTrue(bdiff.exists)
        XCTAssertTrue(bmul.exists)
        XCTAssertTrue(bdiv.exists)
        XCTAssertTrue(bmod.exists)
        XCTAssertTrue(blog.exists)
        XCTAssertTrue(bpow.exists)
        //19
        
        //check empty result

        
        //check formulating number
        b1.tap()
        b2.tap()
        b3.tap()
        
        XCTAssertTrue(app.staticTexts["123"].exists)
        
        beq.tap()
        
        //check number formatting
        XCTAssertTrue(app.staticTexts["123.0"].exists)
        
        b2.tap()
        bsum.tap()
        b2.tap()
        
        beq.tap()
        
        //check addition
        XCTAssertTrue(app.staticTexts["4.0"].exists)
        
        b2.tap()
        bpow.tap()
        b3.tap()
        
        beq.tap()
        
        //check power
        XCTAssertTrue(app.staticTexts["8.0"].exists)
        
        b5.tap()
        bdiv.tap()
        b1.tap()
        b0.tap()
        
        beq.tap()
        
        //check float result
        XCTAssertTrue(app.staticTexts["0.5"].exists)
        
        bsum.tap()
        b9.tap()
        
        beq.tap()
        
        //check continue operations
        XCTAssertTrue(app.staticTexts["9.5"].exists)
        
        b1.tap()
        blog.tap()
        
        //check log formating
        XCTAssertTrue(app.staticTexts["log(1)"].exists)
        
        beq.tap()
        
        //check log result
        XCTAssertTrue(app.staticTexts["0.0"].exists)
        

        bdiff.tap()
        b6.tap()
        
        beq.tap()
        
        //check negatives
        XCTAssertTrue(app.staticTexts["-6.0"].exists)
        
        //check multiple negatives
        b4.tap()
        bdiff.tap()
        bdiff.tap()
        bdiff.tap()
        bdiff.tap()
        bdiff.tap()
        b7.tap()
        
        beq.tap()
        
        XCTAssertTrue(app.staticTexts["-3.0"].exists)
        //29
        
        //operation order test (operation order is not supperted and they evaluate in the way they were provided
        b2.tap()
        bsum.tap()
        b2.tap()
        bmul.tap()
        b3.tap()
        
        beq.tap()
        
        XCTAssertTrue(app.staticTexts["12.0"].exists)
        //30
        
        //mult and single operation formatting
        
        b5.tap()
        b5.tap()
        bmul.tap()
        b1.tap()
        b3.tap()
        blog.tap()
        
        XCTAssertTrue(app.staticTexts["log(55*13)"].exists)
        
        //reset check
        bAC.tap()
        
        XCTAssertFalse(app.staticTexts["log(55*13)"].exists)
        
        //percent check
        b2.tap()
        b5.tap()
        
        bmod.tap()
        
        beq.tap()
        
        XCTAssertTrue(app.staticTexts["0.25"].exists)

    }

    @MainActor
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}

//let staticText = XCUIApplication().windows.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 0).staticTexts["0"]

