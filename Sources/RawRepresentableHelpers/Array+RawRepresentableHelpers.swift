//
//  Array+RawRepresentableHelpers.swift
//  RawRepresentableHelpers
//
//  Created by Tyler Anger on 2019-05-01.
//

import Foundation

#if swift(>=4.1)
    #if canImport(SwiftClassCollection)
        import SwiftClassCollection
        // If we can import SwiftClassCollection we will add the helper init on the protocol to apply to all implemented array types
        public extension SArray {
            init<R>(_ elements: [R]) where R: RawRepresentable, R.RawValue == Element {
                let ary = elements.map({ $0.rawValue })
                self.init(ary)
            }

            /// Adds a new element at the end of the array.
            ///
            /// Use this method to append a single element to the end of a mutable array.
            ///
            ///     var numbers = [1, 2, 3, 4, 5]
            ///     numbers.append(100)
            ///     print(numbers)
            ///     // Prints "[1, 2, 3, 4, 5, 100]"
            ///
            /// Because arrays increase their allocated capacity using an exponential
            /// strategy, appending a single element to an array is an O(1) operation
            /// when averaged over many calls to the `append(_:)` method. When an array
            /// has additional capacity and is not sharing its storage with another
            /// instance, appending an element is O(1). When an array needs to
            /// reallocate storage before appending or its storage is shared with
            /// another copy, appending is O(*n*), where *n* is the length of the array.
            ///
            /// - Parameter newElement: The element to append to the array.
            ///
            /// - Complexity: O(1) on average, over many calls to `append(_:)` on the
            ///   same array.
            mutating func append<R>(_ newElement: R) where R: RawRepresentable, R.RawValue == Element {
                self.append(newElement.rawValue)
            }
            /// Inserts a new element into the collection at the specified position.
            ///
            /// - Parameters:
            ///   - newElement: The new element to insert into the collection.
            ///   - i: The position at which to insert the new element. index must be a valid index into the collection.
            mutating func insert<R>(_ newElement: R, at i: Int) where R: RawRepresentable, R.RawValue == Element {
                self.insert(newElement.rawValue, at: i)
            }
            /// Inserts the elements of a sequence into the collection at the specified position.
            ///
            /// - Parameters:
            ///   - newElements: The new elements to insert into the collection.
            ///   - i: The position at which to insert the new elements. index must be a valid index of the collection.
            mutating func insert<C>(contentsOf newElements: C, at i: Int) where C : Collection, C.Element: RawRepresentable, Element == C.Element.RawValue {
                self.insert(contentsOf: newElements.map({ return $0.rawValue }), at: i)
            }
            /// Adds the elements of a sequence or collection to the end of this collection.
            ///
            /// - Parameter newElements: The elements to append to the collection.
            mutating func append<S>(contentsOf newElements: S) where S : Sequence, S.Element: RawRepresentable, Element == S.Element.RawValu {
                self.append(contentsOf: newElements.map({ return $0.rawValue }))
            }
        }
    #else
        // Otherwise we just implmenet it on the Array struct specifically
        public extension Array {

            init<R>(_ elements: [R]) where R: RawRepresentable, R.RawValue == Element {
                self = elements.map({ $0.rawValue })
            }

            /// Adds a new element at the end of the array.
            ///
            /// Use this method to append a single element to the end of a mutable array.
            ///
            ///     var numbers = [1, 2, 3, 4, 5]
            ///     numbers.append(100)
            ///     print(numbers)
            ///     // Prints "[1, 2, 3, 4, 5, 100]"
            ///
            /// Because arrays increase their allocated capacity using an exponential
            /// strategy, appending a single element to an array is an O(1) operation
            /// when averaged over many calls to the `append(_:)` method. When an array
            /// has additional capacity and is not sharing its storage with another
            /// instance, appending an element is O(1). When an array needs to
            /// reallocate storage before appending or its storage is shared with
            /// another copy, appending is O(*n*), where *n* is the length of the array.
            ///
            /// - Parameter newElement: The element to append to the array.
            ///
            /// - Complexity: O(1) on average, over many calls to `append(_:)` on the
            ///   same array.
            mutating func append<R>(_ newElement: R) where R: RawRepresentable, R.RawValue == Element {
                self.append(newElement.rawValue)
            }
            /// Inserts a new element into the collection at the specified position.
            ///
            /// - Parameters:
            ///   - newElement: The new element to insert into the collection.
            ///   - i: The position at which to insert the new element. index must be a valid index into the collection.
            mutating func insert<R>(_ newElement: R, at i: Int) where R: RawRepresentable, R.RawValue == Element {
                self.insert(newElement.rawValue, at: i)
            }
            /// Inserts the elements of a sequence into the collection at the specified position.
            ///
            /// - Parameters:
            ///   - newElements: The new elements to insert into the collection.
            ///   - i: The position at which to insert the new elements. index must be a valid index of the collection.
            mutating func insert<C>(contentsOf newElements: C, at i: Int) where C : Collection, C.Element: RawRepresentable, Element == C.Element.RawValue {
                self.insert(contentsOf: newElements.map({ return $0.rawValue }), at: i)
            }
            /// Adds the elements of a sequence or collection to the end of this collection.
            ///
            /// - Parameter newElements: The elements to append to the collection.
            mutating func append<S>(contentsOf newElements: S) where S : Sequence, S.Element: RawRepresentable, Element == S.Element.RawValue {
                self.append(contentsOf: newElements.map({ return $0.rawValue }))
            }
        }
    #endif
#else
    // Otherwise we just implmenet it on the Array struct specifically
    public extension Array {

        init<R>(_ elements: [R]) where R: RawRepresentable, R.RawValue == Element {
            self = elements.map({ $0.rawValue })
        }
        
        /// Adds a new element at the end of the array.
        ///
        /// Use this method to append a single element to the end of a mutable array.
        ///
        ///     var numbers = [1, 2, 3, 4, 5]
        ///     numbers.append(100)
        ///     print(numbers)
        ///     // Prints "[1, 2, 3, 4, 5, 100]"
        ///
        /// Because arrays increase their allocated capacity using an exponential
        /// strategy, appending a single element to an array is an O(1) operation
        /// when averaged over many calls to the `append(_:)` method. When an array
        /// has additional capacity and is not sharing its storage with another
        /// instance, appending an element is O(1). When an array needs to
        /// reallocate storage before appending or its storage is shared with
        /// another copy, appending is O(*n*), where *n* is the length of the array.
        ///
        /// - Parameter newElement: The element to append to the array.
        ///
        /// - Complexity: O(1) on average, over many calls to `append(_:)` on the
        ///   same array.
        mutating func append<R>(_ newElement: R) where R: RawRepresentable, R.RawValue == Element {
            self.append(newElement.rawValue)
        }
        /// Inserts a new element into the collection at the specified position.
        ///
        /// - Parameters:
        ///   - newElement: The new element to insert into the collection.
        ///   - i: The position at which to insert the new element. index must be a valid index into the collection.
        mutating func insert<R>(_ newElement: R, at i: Int) where R: RawRepresentable, R.RawValue == Element {
            self.insert(newElement.rawValue, at: i)
        }
        /// Inserts the elements of a sequence into the collection at the specified position.
        ///
        /// - Parameters:
        ///   - newElements: The new elements to insert into the collection.
        ///   - i: The position at which to insert the new elements. index must be a valid index of the collection.
        mutating func insert<C>(contentsOf newElements: C, at i: Int) where C : Collection, C.Element: RawRepresentable, Element == C.Element.RawValue {
            self.insert(contentsOf: newElements.map({ return $0.rawValue }), at: i)
        }
        /// Adds the elements of a sequence or collection to the end of this collection.
        ///
        /// - Parameter newElements: The elements to append to the collection.
        mutating func append<S>(contentsOf newElements: S) where S : Sequence, S.Element: RawRepresentable, Element == S.Element.RawValue {
            self.append(contentsOf: newElements.map({ return $0.rawValue }))
        }
    }
#endif


public extension Collection where Element: Equatable {
    func index<R>(of element: R) -> Index? where R: RawRepresentable, R.RawValue == Element {
        return self.index(where: { return $0 == element.rawValue})
    }
    /// Returns a Boolean value indicating whether the sequence contains the
    /// given element.
    ///
    /// This example checks to see whether a favorite actor is in an array
    /// storing a movie's cast.
    ///
    ///     let cast = ["Vivien", "Marlon", "Kim", "Karl"]
    ///     print(cast.contains("Marlon"))
    ///     // Prints "true"
    ///     print(cast.contains("James"))
    ///     // Prints "false"
    ///
    /// - Parameter element: The element to find in the sequence.
    /// - Returns: `true` if the element was found in the sequence; otherwise,
    ///   `false`.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the sequence.
    func contains<R>( _ element: R) -> Bool where R: RawRepresentable, R.RawValue == Element {
        return self.contains(element.rawValue)
    }
}
public extension Collection {
    
    /// Accesses the element at the specified position.
    ///
    /// The following example accesses an element of an array through its
    /// subscript to print its value:
    ///
    ///     var streets = ["Adams", "Bryant", "Channing", "Douglas", "Evarts"]
    ///     print(streets[1])
    ///     // Prints "Bryant"
    ///
    /// You can subscript a collection with any valid index other than the
    /// collection's end index. The end index refers to the position one past
    /// the last element of a collection, so it doesn't correspond with an
    /// element.
    ///
    /// - Parameter position: The position of the element to access. `position`
    ///   must be a valid index of the collection that is not equal to the
    ///   `endIndex` property.
    ///
    /// - Complexity: O(1)
    subscript<R>(index: R) -> Element where R: RawRepresentable, R.RawValue == Index {
        return self[index.rawValue]
    }
}

public extension Collection where Element: RawRepresentable, Element.RawValue: Equatable {
    /// Returns a Boolean value indicating whether the sequence contains the
    /// given element.
    ///
    /// This example checks to see whether a favorite actor is in an array
    /// storing a movie's cast.
    ///
    ///     let cast = ["Vivien", "Marlon", "Kim", "Karl"]
    ///     print(cast.contains("Marlon"))
    ///     // Prints "true"
    ///     print(cast.contains("James"))
    ///     // Prints "false"
    ///
    /// - Parameter element: The element to find in the sequence.
    /// - Returns: `true` if the element was found in the sequence; otherwise,
    ///   `false`.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the sequence.
    func contains(_ element: Element.RawValue) -> Bool {
        return self.contains(where: {$0.rawValue == element})
    }
    /// Returns a Boolean value indicating whether the sequence contains the
    /// given element.
    ///
    /// This example checks to see whether a favorite actor is in an array
    /// storing a movie's cast.
    ///
    ///     let cast = ["Vivien", "Marlon", "Kim", "Karl"]
    ///     print(cast.contains("Marlon"))
    ///     // Prints "true"
    ///     print(cast.contains("James"))
    ///     // Prints "false"
    ///
    /// - Parameter element: The element to find in the sequence.
    /// - Returns: `true` if the element was found in the sequence; otherwise,
    ///   `false`.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the sequence.
    func contains(_ element: Element.RawValue?) -> Bool {
        guard let e = element else { return false }
        return self.contains(e)
    }
    
}

public extension MutableCollection {
    /// Accesses the element at the specified position.
    ///
    /// For example, you can replace an element of an array by using its
    /// subscript.
    ///
    ///     var streets = ["Adams", "Bryant", "Channing", "Douglas", "Evarts"]
    ///     streets[1] = "Butler"
    ///     print(streets[1])
    ///     // Prints "Butler"
    ///
    /// You can subscript a collection with any valid index other than the
    /// collection's end index. The end index refers to the position one
    /// past the last element of a collection, so it doesn't correspond with an
    /// element.
    ///
    /// - Parameter position: The position of the element to access. `position`
    ///   must be a valid index of the collection that is not equal to the
    ///   `endIndex` property.
    ///
    /// - Complexity: O(1)
    subscript<R>(index: R) -> Element where R: RawRepresentable, R.RawValue == Index {
        get { return self[index.rawValue] }
        set { self[index.rawValue] = newValue  }
    }
}
