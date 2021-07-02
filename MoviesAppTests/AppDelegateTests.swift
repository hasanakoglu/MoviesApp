import XCTest

@testable import MoviesApp

class AppDelegateTests: XCTestCase {
    var subject: AppDelegate!
    
    override func setUp() {
        subject = AppDelegate()
        _ = subject.application(UIApplication.shared, didFinishLaunchingWithOptions: nil)
    }

    override func tearDown() {
        subject = nil
    }

    func testAppDelegateLaunch_CreatesWindow() {
        XCTAssertNotNil(subject.window)
    }
    
    func testAppDelegateLaunch_SetsUpRootViewControllerCorrectly() {
        guard let rootViewController = subject.window?.rootViewController else {
            XCTFail("rootViewController is nil")
            return
        }
        
        let mainVC = rootViewController as? MainTabBarController
        XCTAssertNotNil(mainVC)
    }
}

