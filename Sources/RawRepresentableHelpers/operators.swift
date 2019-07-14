//
//  operators.swift
//  RawRepresentableHelpers
//
//  Created by Tyler Anger on 2019-05-01.
//

import Foundation


// MARK: - Operator ==

public func ==<R, V>(lhs: @autoclosure ()->R,
                     rhs: @autoclosure ()->V) -> Bool where R: RawRepresentable, R.RawValue == V, V: Equatable {
    return lhs().rawValue == rhs()
}

public func ==<R, V>(lhs: @autoclosure ()->V,
                     rhs: @autoclosure ()->R) -> Bool where R: RawRepresentable, R.RawValue == V, V: Equatable {
    return lhs() == rhs().rawValue
}

public func ==<R, V>(lhs: @autoclosure ()->R,
                     rhs: @autoclosure ()->V?) -> Bool where R: RawRepresentable, R.RawValue == V, V: Equatable {
    guard let rhsv = rhs() else { return false }
    return lhs().rawValue == rhsv
}

public func ==<R, V>(lhs: @autoclosure ()->V?,
                     rhs: @autoclosure ()->R) -> Bool where R: RawRepresentable, R.RawValue == V, V: Equatable {
    guard let lhsv = lhs() else { return false }
    return lhsv == rhs().rawValue
}

// MARK: - Operator !=

public func !=<R, V>(lhs: @autoclosure ()->R,
                     rhs: @autoclosure ()->V) -> Bool where R: RawRepresentable, R.RawValue == V, V: Equatable {
    return lhs().rawValue != rhs()
}

public func !=<R, V>(lhs: @autoclosure ()->V,
                     rhs: @autoclosure ()->R) -> Bool where R: RawRepresentable, R.RawValue == V, V: Equatable {
    return lhs() != rhs().rawValue
}

public func !=<R, V>(lhs: @autoclosure ()->R,
                     rhs: @autoclosure ()->V?) -> Bool where R: RawRepresentable, R.RawValue == V, V: Equatable {
    guard let rhsv = rhs() else { return true }
    return lhs().rawValue != rhsv
}

public func !=<R, V>(lhs: @autoclosure ()->V?,
                     rhs: @autoclosure ()->R) -> Bool where R: RawRepresentable, R.RawValue == V, V: Equatable {
    guard let lhsv = lhs() else { return true }
    return lhsv != rhs().rawValue
}

// MARK: - Operator <

public func <<R, V>(lhs: @autoclosure ()->R,
                    rhs: @autoclosure ()-> V) -> Bool where R: RawRepresentable, R.RawValue == V, V: Comparable {
    return lhs().rawValue < rhs()
}

public func <<R, V>(lhs: @autoclosure ()->V,
                    rhs: @autoclosure ()->R) -> Bool where R: RawRepresentable, R.RawValue == V, V: Comparable {
    return lhs() < rhs().rawValue
}

// MARK: - Operator <=

public func <=<R, V>(lhs: @autoclosure ()->R,
                     rhs: @autoclosure ()->V) -> Bool where R: RawRepresentable, R.RawValue == V, V: Comparable {
    return lhs().rawValue <= rhs()
}

public func <=<R, V>(lhs: @autoclosure ()->V,
                     rhs: @autoclosure ()->R) -> Bool where R: RawRepresentable, R.RawValue == V, V: Comparable {
    return lhs() <= rhs().rawValue
}

// MARK: - Operator >

public func ><R, V>(lhs: @autoclosure ()->R,
                    rhs: @autoclosure ()->V) -> Bool where R: RawRepresentable, R.RawValue == V, V: Comparable {
    return lhs().rawValue > rhs()
}

public func ><R, V>(lhs: @autoclosure ()->V,
                    rhs: @autoclosure ()->R) -> Bool where R: RawRepresentable, R.RawValue == V, V: Comparable {
    return lhs() > rhs().rawValue
}

// MARK: - Operator >=

public func >=<R, V>(lhs: @autoclosure ()->R,
                     rhs: @autoclosure ()->V) -> Bool where R: RawRepresentable, R.RawValue == V, V: Comparable {
    return lhs().rawValue >= rhs()
}

public func >=<R, V>(lhs: @autoclosure ()->V,
                     rhs: @autoclosure ()->R) -> Bool where R: RawRepresentable, R.RawValue == V, V: Comparable {
    return lhs() >= rhs().rawValue
}


