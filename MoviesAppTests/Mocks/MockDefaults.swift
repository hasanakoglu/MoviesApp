import Foundation

@testable import MoviesApp

class MockDefaults: UserDefaultsProtocol {
    var setValue: Any?
    var key = "test"
    func set(_ value: Any?, forKey defaultName: String) {
        setValue = value
        key = defaultName
    }
    
    var value: Any?
    func value(forKey defaultName: String) -> Any? {
        key = defaultName
        return value
    }
}

