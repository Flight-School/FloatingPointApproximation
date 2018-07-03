import XCTest
@testable import FloatingPointApproximation

final class FloatingPointApproximationTests: XCTestCase {
    func testEqualToOperator() {
        XCTAssertFalse(0.1 + 0.2 == 0.3)
        XCTAssertTrue(0.1 == 0.1)
    }
    
    func testApproximatelyEqualToOperator() {
        XCTAssertTrue(0.1 + 0.2 ==~ 0.3)
        XCTAssertTrue(0.1 ==~ 0.1)
        XCTAssertFalse(0.1 ==~ 0.2)
        XCTAssertTrue(0.1 ==~ 0.1.nextDown)
        XCTAssertTrue(0.1 ==~ 0.1.nextUp)
        XCTAssertFalse(0.1.nextDown ==~ 0.1.nextUp)
        
        XCTAssertTrue(-0.0 ==~ 0.0)
        XCTAssertTrue(Double.infinity ==~ Double.infinity)
        XCTAssertFalse(Double.nan ==~ Double.nan)
    }
    
    func testIsApproximatelyEqualToWithin() {
        XCTAssertTrue((0.1 + 0.2).isApproximatelyEqual(to: 0.3,
                                                       within: 1e-12,
                                                       maximumULPs: 2))
    }

    static var allTests = [
        ("testEqualToOperator", testEqualToOperator),
        ("testApproximatelyEqualToOperator", testApproximatelyEqualToOperator),
        ("testIsApproximatelyEqualToWithin", testIsApproximatelyEqualToWithin)
    ]
}
