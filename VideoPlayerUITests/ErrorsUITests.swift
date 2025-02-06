//
//  ErrorsUITests.swift
//  VideoPlayerUITests
//
//  Created by Igor Shelopaev
//

import XCTest
import swiftui_loop_videoplayer

final class ErrorsUITests: XCTestCase, Initializable, Navigable {

    /// Prepares the test class for execution by ensuring the application is launched if not already running and sets failure handling.
    ///
    /// Throws an error if the setup process fails, potentially causing all subsequent tests to be skipped.
    override func setUpWithError() throws {
        continueAfterFailure = false
        AppManager.shared.launchApplicationIfNeeded()
    }
    
    override class func tearDown() {
        AppManager.shared.terminateApplication()
    }

    /// Tests the non-existence of a specific resource video.
    ///
    /// This method simulates tapping on a button named after a video and checks for an error message if the resource is not found.
    func testErrorResourceNotFound(){
        let videoName = Video3.videoPrefix

        tap(button: videoName, wait: 11)
        
        let error = getCurrentErrorText(app: AppManager.shared.app)
        let description = VPErrors.sourceNotFound(Video3.sourceName).description
        
        XCTAssertEqual(description, error)
        
        back()
    }

    /// Retrieves the current error text displayed within the application.
    ///
    /// - Parameter app: The instance of `XCUIApplication` to query for error text.
    /// - Returns: A string containing the error text or an empty string if no error text is found.
    func getCurrentErrorText(app: XCUIApplication) -> String {
        let errorText = app.staticTexts["\(Video3.errorWidgetIdentifier)"]
        XCTAssertTrue(errorText.waitForExistence(timeout: 5), "Error text should be visible on the screen")
        
        return errorText.label
    }
}
