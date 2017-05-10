// Generated using Sourcery 0.6.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// swiftlint:disable file_length
fileprivate func compareOptionals<T>(lhs: T?, rhs: T?, compare: (_ lhs: T, _ rhs: T) -> Bool) -> Bool {
    switch (lhs, rhs) {
    case let (lValue?, rValue?):
        return compare(lValue, rValue)
    case (nil, nil):
        return true
    default:
        return false
    }
}

fileprivate func compareArrays<T>(lhs: [T], rhs: [T], compare: (_ lhs: T, _ rhs: T) -> Bool) -> Bool {
    guard lhs.count == rhs.count else { return false }
    for (idx, lhsItem) in lhs.enumerated() {
        guard compare(lhsItem, rhs[idx]) else { return false }
    }

    return true
}

// MARK: - AutoEquatable for classes, protocols, structs

// MARK: - AutoEquatable for Enums
// MARK: - BarricadeError AutoEquatable
extension BarricadeError: Equatable {}
public func == (lhs: BarricadeError, rhs: BarricadeError) -> Bool {
    switch (lhs, rhs) {
    case (.noResponseRegistered(let lhs), .noResponseRegistered(let rhs)): 
        return lhs == rhs
     case (.unableToGenerateUrlResponse, .unableToGenerateUrlResponse): 
         return true 
     case (.emptyFilePath, .emptyFilePath): 
         return true 
     case (.responseFileNotFound, .responseFileNotFound): 
         return true 
     case (.malformedJson, .malformedJson): 
         return true 
     case (.unknown, .unknown): 
         return true 
    default: return false
    }
}

// MARK: -
