//
//  XMLElement+RawRepresentableHelpers.swift
//  RawRepresentableHelpers
//
//  Created by Tyler Anger on 2019-05-01.
//

import Foundation

public extension XMLElement {
    
    convenience init<R>(name: R) where R: RawRepresentable, R.RawValue == String {
        self.init(name: name.rawValue)
    }
    convenience init<R>(name: R, uri URI: String?) where R: RawRepresentable, R.RawValue == String {
        self.init(name: name.rawValue, uri: URI)
    }
    convenience init<R>(name: R, stringValue string: String?) where R: RawRepresentable, R.RawValue == String {
        self.init(name: name.rawValue, stringValue: string)
    }
    
    /// Get an attribute with the same name as the raw value of the name
    ///
    /// - Parameter name: The name to look for
    /// - Returns: Returns the found attribute or nil if not found
    func attribute<R>(forName name: R) -> XMLNode? where R: RawRepresentable, R.RawValue == String {
        return self.attribute(forName: name.rawValue)
    }
    
    /// Get an attribute with the same name as the raw value of the name
    ///
    /// - Parameters:
    ///   - name: The name to look for
    ///   - uri: The uri for the attribute
    /// - Returns: Returns the found attribute or nil if not found
    func attribute<R>(forName name: R,
                      uri: String?) -> XMLNode? where R: RawRepresentable, R.RawValue == String {
        return self.attribute(forLocalName: name.rawValue, uri: uri)
    }
    
    /// Find elements that have the given name
    ///
    /// - Parameter name: The name of the elements to look for
    /// - Returns: Returns all of the child elements that match this name.
    func elements<R>(forName name: R) -> [XMLElement] where R: RawRepresentable, R.RawValue == String {
        return self.elements(forName: name.rawValue)
    }
}
