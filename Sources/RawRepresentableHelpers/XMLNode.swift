//
//  XMLNode.swift
//  RawRepresentableHelpers
//
//  Created by Tyler Anger on 2019-07-18.
//

import Foundation

public extension XMLNode {
    /// Returns an XMLElement object with a given tag identifier, or name
    ///
    /// - Parameter name: The raw representable string that is the name (or tag identifier) of an element.
    /// - Returns: Returns an element <name></name>.
    class func element<R>(withName name: R) -> XMLElement where R: RawRepresentable, R.RawValue == String {
        return XMLNode.element(withName: name.rawValue) as! XMLElement
    }
    
    
    
    /// Returns an element whose fully qualified name is specified.
    ///
    /// - Parameters:
    ///   - name: The raw representable string that is the name (or tag identifier) of an element.
    ///   - URI: A URI (Universal Resource Identifier) that qualifies name.
    /// - Returns: Returns an element whose full QName is specified.
    class func element<R>(withName name: R,
                                 uri URI: String) -> XMLElement where R: RawRepresentable, R.RawValue == String {
        return XMLNode.element(withName: name.rawValue,
                               uri: URI) as! XMLElement
    }
    
    
    
    /// Returns an XMLElement object with a single text-node child containing the specified text.
    ///
    /// - Parameters:
    ///   - name: The raw representable string that is the name (or tag identifier) of an element.
    ///   - string: A string that is the content of the receiver's text node.
    /// - Returns: Returns an element with a single text node child <name>string</name>
    class func element<R>(withName name: R,
                                 stringValue string: String) -> XMLElement where R: RawRepresentable, R.RawValue == String {
        return XMLNode.element(withName: name.rawValue,
                               stringValue: string) as! XMLElement
    }
    

    /// Returns an XMLElement object with the given tag (name), attributes, and children.
    ///
    /// - Parameters:
    ///   - name: The raw representable string that is the name (or tag identifier) of an element.
    ///   - children: An array of NSXMLElement objects or NSXMLNode objects of kinds XMLNode.Kind.element, XMLNode.Kind.processingInstruction, XMLNode.Kind.comment, and XMLNode.Kind.text. Specify nil if there are no children to add to this node object.
    ///   - attributes: An array of NSXMLNode objects of kind XMLNode.Kind.attribute. Specify nil if there are no attributes to add to this node object.
    /// - Returns: Returns an element children and attributes <name attr1="foo" attr2="bar"> -- child1 -->child2</name>
    class func element<R>(withName name: R,
                                 children: [XMLNode]?,
                                 attributes: [XMLNode]?) -> XMLElement where R: RawRepresentable, R.RawValue == String {
        return XMLNode.element(withName: name.rawValue,
                               children: children,
                               attributes: attributes) as! XMLElement
    }
    
    
    /// Returns an NSXMLNode object representing an attribute node with a given name and string.
    ///
    /// - Parameters:
    ///   - name: The raw representable string that is the name of an attribute.
    ///   - stringValue: A string that is the value of an attribute.
    /// - Returns: Returns an attribute <tt>name="stringValue"</tt>.
    class func attribute<R>(withName name: R, stringValue: String) -> XMLNode where R: RawRepresentable, R.RawValue == String {
        return XMLNode.attribute(withName: name.rawValue, stringValue: stringValue) as! XMLNode
    }
    
    /// Returns an NSXMLNode object representing an attribute node with a given name and string.
    ///
    /// - Parameters:
    ///   - name: The string that is the name of an attribute.
    ///   - stringValue: A raw representable string that is the value of an attribute.
    /// - Returns: Returns an attribute <tt>name="stringValue"</tt>.
    class func attribute<R>(withName name: String, stringValue: R) -> XMLNode where R: RawRepresentable, R.RawValue == String {
        return XMLNode.attribute(withName: name, stringValue: stringValue.rawValue) as! XMLNode
    }
    
    /// Returns an NSXMLNode object representing an attribute node with a given name and string.
    ///
    /// - Parameters:
    ///   - name: The raw representable string that is the name of an attribute.
    ///   - stringValue: A raw representable string that is the value of an attribute.
    /// - Returns: Returns an attribute <tt>name="stringValue"</tt>.
    class func attribute<R1, R2>(withName name: R1, stringValue: R2) -> XMLNode where R1: RawRepresentable, R1.RawValue == String, R2: RawRepresentable, R2.RawValue == String {
        return XMLNode.attribute(withName: name.rawValue,
                                 stringValue: stringValue.rawValue) as! XMLNode
    }
    
    /// Returns an NSXMLNode object representing an attribute node with a given qualified name and string.
    ///
    /// - Parameters:
    ///   - name: The raw representable string that is the name of an attribute.
    ///   - URI: A URI (Universal Resource Identifier) that qualifies name.
    ///   - stringValue: A string that is the value of the attribute.
    /// - Returns: Returns an attribute whose full QName is specified.
    class func attribute<R>(withName name: R,
                                   uri URI: String,
                                   stringValue: String) -> XMLNode where R: RawRepresentable, R.RawValue == String {
        return XMLNode.attribute(withName: name.rawValue,
                                 uri: URI,
                                 stringValue: stringValue) as! XMLNode
    }
    
    /// Returns an NSXMLNode object representing an attribute node with a given qualified name and string.
    ///
    /// - Parameters:
    ///   - name: The string that is the name of an attribute.
    ///   - URI: A URI (Universal Resource Identifier) that qualifies name.
    ///   - stringValue: A raw representable string that is the value of the attribute.
    /// - Returns: Returns an attribute whose full QName is specified.
    class func attribute<R>(withName name: String,
                                   uri URI: String,
                                   stringValue: R) -> XMLNode where R: RawRepresentable, R.RawValue == String {
        return XMLNode.attribute(withName: name,
                                 uri: URI,
                                 stringValue: stringValue.rawValue) as! XMLNode
    }
    
    /// Returns an NSXMLNode object representing an attribute node with a given qualified name and string.
    ///
    /// - Parameters:
    ///   - name: The raw representable string that is the name of an attribute.
    ///   - URI: A URI (Universal Resource Identifier) that qualifies name.
    ///   - stringValue: A raw representable string that is the value of the attribute.
    /// - Returns: Returns an attribute whose full QName is specified.
    class func attribute<R1, R2>(withName name: R1,
                                   uri URI: String,
                                   stringValue: R2) -> XMLNode where R1: RawRepresentable, R1.RawValue == String, R2: RawRepresentable, R2.RawValue == String {
        return XMLNode.attribute(withName: name.rawValue,
                                 uri: URI,
                                 stringValue: stringValue.rawValue) as! XMLNode
    }
}
