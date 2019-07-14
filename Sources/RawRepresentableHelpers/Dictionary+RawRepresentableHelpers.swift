//
//  Dictionary+RawRepresentableHelpers.swift
//  RawRepresentableHelpers
//
//  Created by Tyler Anger on 2019-05-01.
//


import Foundation

#if swift(>=4.1)
    #if canImport(SwiftClassCollection)
        import SwiftClassCollection

        public extension SDictionary {
            /// Accesses the value associated with the given key for reading and writing.
            ///
            /// This *key-based* subscript returns the value for the given key if the key
            /// is found in the dictionary, or `nil` if the key is not found.
            ///
            /// The following example creates a new dictionary and prints the value of a
            /// key found in the dictionary (`"Coral"`) and a key not found in the
            /// dictionary (`"Cerise"`).
            ///
            ///     var hues = ["Heliotrope": 296, "Coral": 16, "Aquamarine": 156]
            ///     print(hues["Coral"])
            ///     // Prints "Optional(16)"
            ///     print(hues["Cerise"])
            ///     // Prints "nil"
            ///
            /// When you assign a value for a key and that key already exists, the
            /// dictionary overwrites the existing value. If the dictionary doesn't
            /// contain the key, the key and value are added as a new key-value pair.
            ///
            /// Here, the value for the key `"Coral"` is updated from `16` to `18` and a
            /// new key-value pair is added for the key `"Cerise"`.
            ///
            ///     hues["Coral"] = 18
            ///     print(hues["Coral"])
            ///     // Prints "Optional(18)"
            ///
            ///     hues["Cerise"] = 330
            ///     print(hues["Cerise"])
            ///     // Prints "Optional(330)"
            ///
            /// If you assign `nil` as the value for the given key, the dictionary
            /// removes that key and its associated value.
            ///
            /// In the following example, the key-value pair for the key `"Aquamarine"`
            /// is removed from the dictionary by assigning `nil` to the key-based
            /// subscript.
            ///
            ///     hues["Aquamarine"] = nil
            ///     print(hues)
            ///     // Prints "["Coral": 18, "Heliotrope": 296, "Cerise": 330]"
            ///
            /// - Parameter key: The key to find in the dictionary.
            /// - Returns: The value associated with `key` if `key` is in the dictionary;
            ///   otherwise, `nil`.
            subscript<E>(key: E) -> Value? where E: RawRepresentable, E.RawValue == Key {
                get {
                    return self[key.rawValue]
                }
                set {
                    self[key.rawValue] = newValue
                }
            }

            /// Accesses the value with the given key. If the dictionary doesn't contain
            /// the given key, accesses the provided default value as if the key and
            /// default value existed in the dictionary.
            ///
            /// Use this subscript when you want either the value for a particular key
            /// or, when that key is not present in the dictionary, a default value. This
            /// example uses the subscript with a message to use in case an HTTP response
            /// code isn't recognized:
            ///
            ///     var responseMessages = [200: "OK",
            ///                             403: "Access forbidden",
            ///                             404: "File not found",
            ///                             500: "Internal server error"]
            ///
            ///     let httpResponseCodes = [200, 403, 301]
            ///     for code in httpResponseCodes {
            ///         let message = responseMessages[code, default: "Unknown response"]
            ///         print("Response \(code): \(message)")
            ///     }
            ///     // Prints "Response 200: OK"
            ///     // Prints "Response 403: Access Forbidden"
            ///     // Prints "Response 301: Unknown response"
            ///
            /// When a dictionary's `Value` type has value semantics, you can use this
            /// subscript to perform in-place operations on values in the dictionary.
            /// The following example uses this subscript while counting the occurences
            /// of each letter in a string:
            ///
            ///     let message = "Hello, Elle!"
            ///     var letterCounts: [Character: Int] = [:]
            ///     for letter in message {
            ///         letterCounts[letter, defaultValue: 0] += 1
            ///     }
            ///     // letterCounts == ["H": 1, "e": 2, "l": 4, "o": 1, ...]
            ///
            /// When `letterCounts[letter, defaultValue: 0] += 1` is executed with a
            /// value of `letter` that isn't already a key in `letterCounts`, the
            /// specified default value (`0`) is returned from the subscript,
            /// incremented, and then added to the dictionary under that key.
            ///
            /// - Note: Do not use this subscript to modify dictionary values if the
            ///   dictionary's `Value` type is a class. In that case, the default value
            ///   and key are not written back to the dictionary after an operation.
            ///
            /// - Parameters:
            ///   - key: The key the look up in the dictionary.
            ///   - defaultValue: The default value to use if `key` doesn't exist in the
            ///     dictionary.
            /// - Returns: The value associated with `key` in the dictionary`; otherwise,
            ///   `defaultValue`.
            subscript<R>(key: R,
                default defaultValue: @autoclosure () -> Value) -> Value  where R: RawRepresentable, R.RawValue == Key {
                    guard let v = self[key.rawValue] else { return defaultValue() }
                    return v
            }

            /// Creates a new dictionary from the key-value pairs in the given sequence.
            ///
            /// You use this initializer to create a dictionary when you have a sequence
            /// of key-value tuples with unique keys. Passing a sequence with duplicate
            /// keys to this initializer results in a runtime error. If your
            /// sequence might have duplicate keys, use the
            /// `Dictionary(_:uniquingKeysWith:)` initializer instead.
            ///
            /// The following example creates a new dictionary using an array of strings
            /// as the keys and the integers in a countable range as the values:
            ///
            ///     let digitWords = ["one", "two", "three", "four", "five"]
            ///     let wordToValue = Dictionary(uniqueKeysWithValues: zip(digitWords, 1...5))
            ///     print(wordToValue["three"]!)
            ///     // Prints "3"
            ///     print(wordToValue)
            ///     // Prints "["three": 3, "four": 4, "five": 5, "one": 1, "two": 2]"
            ///
            /// - Parameter keysAndValues: A sequence of key-value pairs to use for
            ///   the new dictionary. Every key in `keysAndValues` must be unique.
            /// - Returns: A new dictionary initialized with the elements of
            ///   `keysAndValues`.
            /// - Precondition: The sequence must not have duplicate keys.
            init<S,R>(uniqueKeysWithValues keysAndValues: S) where S : Sequence, R: RawRepresentable, R.RawValue == Key, S.Element == (R, Value) {
                let ary = keysAndValues.map({($0.0.rawValue, $0.1)})
                self.init(uniqueKeysWithValues: ary)
            }

            /// Creates a new dictionary from the key-value pairs in the given sequence.
            ///
            /// You use this initializer to create a dictionary when you have a sequence
            /// of key-value tuples with unique keys. Passing a sequence with duplicate
            /// keys to this initializer results in a runtime error. If your
            /// sequence might have duplicate keys, use the
            /// `Dictionary(_:uniquingKeysWith:)` initializer instead.
            ///
            /// The following example creates a new dictionary using an array of strings
            /// as the keys and the integers in a countable range as the values:
            ///
            ///     let digitWords = ["one", "two", "three", "four", "five"]
            ///     let wordToValue = Dictionary(uniqueKeysWithValues: zip(digitWords, 1...5))
            ///     print(wordToValue["three"]!)
            ///     // Prints "3"
            ///     print(wordToValue)
            ///     // Prints "["three": 3, "four": 4, "five": 5, "one": 1, "two": 2]"
            ///
            /// - Parameter keysAndValues: A sequence of key-value pairs to use for
            ///   the new dictionary. Every key in `keysAndValues` must be unique.
            /// - Returns: A new dictionary initialized with the elements of
            ///   `keysAndValues`.
            /// - Precondition: The sequence must not have duplicate keys.
            init<S,R>(uniqueKeysWithValues keysAndValues: S) where S : Sequence, R: RawRepresentable, R.RawValue == Value, S.Element == (Key, R) {
                let ary = keysAndValues.map({($0.0, $0.1.rawValue)})
                self.init(uniqueKeysWithValues: ary)
            }

            /// Creates a new dictionary from the key-value pairs in the given sequence.
            ///
            /// You use this initializer to create a dictionary when you have a sequence
            /// of key-value tuples with unique keys. Passing a sequence with duplicate
            /// keys to this initializer results in a runtime error. If your
            /// sequence might have duplicate keys, use the
            /// `Dictionary(_:uniquingKeysWith:)` initializer instead.
            ///
            /// The following example creates a new dictionary using an array of strings
            /// as the keys and the integers in a countable range as the values:
            ///
            ///     let digitWords = ["one", "two", "three", "four", "five"]
            ///     let wordToValue = Dictionary(uniqueKeysWithValues: zip(digitWords, 1...5))
            ///     print(wordToValue["three"]!)
            ///     // Prints "3"
            ///     print(wordToValue)
            ///     // Prints "["three": 3, "four": 4, "five": 5, "one": 1, "two": 2]"
            ///
            /// - Parameter keysAndValues: A sequence of key-value pairs to use for
            ///   the new dictionary. Every key in `keysAndValues` must be unique.
            /// - Returns: A new dictionary initialized with the elements of
            ///   `keysAndValues`.
            /// - Precondition: The sequence must not have duplicate keys.
            init<S, RK, RV>(uniqueKeysWithValues keysAndValues: S) where S : Sequence, RK: RawRepresentable, RV: RawRepresentable, RK.RawValue == Key, RV.RawValue == Value, S.Element == (RK, RV) {
                let ary = keysAndValues.map({($0.0.rawValue, $0.1.rawValue)})
                self.init(uniqueKeysWithValues: ary)
            }

            init<R>(_ dictionary: [R: Value]) where R: RawRepresentable, R.RawValue == Key {
                let ary = dictionary.map({($0.key.rawValue, $0.value)})
                self.init(uniqueKeysWithValues: ary)
            }

            init<R>(_ dictionary: [Key: R]) where R: RawRepresentable, R.RawValue == Value {
                let ary = dictionary.map({($0.key, $0.value.rawValue)})
                self.init(uniqueKeysWithValues: ary)
            }

            init<RK, RV>(_ dictionary: [RK: RV]) where RK: RawRepresentable, RK.RawValue == Key, RV: RawRepresentable, RV.RawValue == Value {
                let ary = dictionary.map({($0.key.rawValue, $0.value.rawValue)})
                self.init(uniqueKeysWithValues: ary)
            }

            /// Removes the given key and its associated value from the dictionary.
            ///
            /// If the key is found in the dictionary, this method returns the key's
            /// associated value. On removal, this method invalidates all indices with
            /// respect to the dictionary.
            ///
            ///     var hues = ["Heliotrope": 296, "Coral": 16, "Aquamarine": 156]
            ///     if let value = hues.removeValue(forKey: "Coral") {
            ///         print("The value \(value) was removed.")
            ///     }
            ///     // Prints "The value 16 was removed."
            ///
            /// If the key isn't found in the dictionary, `removeValue(forKey:)` returns
            /// `nil`.
            ///
            ///     if let value = hues.removeValueForKey("Cerise") {
            ///         print("The value \(value) was removed.")
            ///     } else {
            ///         print("No value found for that key.")
            ///     }
            ///     // Prints "No value found for that key.""
            ///
            /// - Parameter key: The key to remove along with its associated value.
            /// - Returns: The value that was removed, or `nil` if the key was not
            ///   present in the dictionary.
            ///
            /// - Complexity: O(*n*), where *n* is the number of key-value pairs in the
            ///   dictionary.
            @discardableResult mutating func removeValue<R>(forKey key: R) -> Value? where R: RawRepresentable, R.RawValue == Key {
                return self.removeValue(forKey: key.rawValue)
            }
        }
    #else
        public extension Dictionary {
            /// Accesses the value associated with the given key for reading and writing.
            ///
            /// This *key-based* subscript returns the value for the given key if the key
            /// is found in the dictionary, or `nil` if the key is not found.
            ///
            /// The following example creates a new dictionary and prints the value of a
            /// key found in the dictionary (`"Coral"`) and a key not found in the
            /// dictionary (`"Cerise"`).
            ///
            ///     var hues = ["Heliotrope": 296, "Coral": 16, "Aquamarine": 156]
            ///     print(hues["Coral"])
            ///     // Prints "Optional(16)"
            ///     print(hues["Cerise"])
            ///     // Prints "nil"
            ///
            /// When you assign a value for a key and that key already exists, the
            /// dictionary overwrites the existing value. If the dictionary doesn't
            /// contain the key, the key and value are added as a new key-value pair.
            ///
            /// Here, the value for the key `"Coral"` is updated from `16` to `18` and a
            /// new key-value pair is added for the key `"Cerise"`.
            ///
            ///     hues["Coral"] = 18
            ///     print(hues["Coral"])
            ///     // Prints "Optional(18)"
            ///
            ///     hues["Cerise"] = 330
            ///     print(hues["Cerise"])
            ///     // Prints "Optional(330)"
            ///
            /// If you assign `nil` as the value for the given key, the dictionary
            /// removes that key and its associated value.
            ///
            /// In the following example, the key-value pair for the key `"Aquamarine"`
            /// is removed from the dictionary by assigning `nil` to the key-based
            /// subscript.
            ///
            ///     hues["Aquamarine"] = nil
            ///     print(hues)
            ///     // Prints "["Coral": 18, "Heliotrope": 296, "Cerise": 330]"
            ///
            /// - Parameter key: The key to find in the dictionary.
            /// - Returns: The value associated with `key` if `key` is in the dictionary;
            ///   otherwise, `nil`.
            subscript<E>(key: E) -> Value? where E: RawRepresentable, E.RawValue == Key {
                get {
                    return self[key.rawValue]
                }
                set {
                    self[key.rawValue] = newValue
                }
            }

            /// Accesses the value with the given key. If the dictionary doesn't contain
            /// the given key, accesses the provided default value as if the key and
            /// default value existed in the dictionary.
            ///
            /// Use this subscript when you want either the value for a particular key
            /// or, when that key is not present in the dictionary, a default value. This
            /// example uses the subscript with a message to use in case an HTTP response
            /// code isn't recognized:
            ///
            ///     var responseMessages = [200: "OK",
            ///                             403: "Access forbidden",
            ///                             404: "File not found",
            ///                             500: "Internal server error"]
            ///
            ///     let httpResponseCodes = [200, 403, 301]
            ///     for code in httpResponseCodes {
            ///         let message = responseMessages[code, default: "Unknown response"]
            ///         print("Response \(code): \(message)")
            ///     }
            ///     // Prints "Response 200: OK"
            ///     // Prints "Response 403: Access Forbidden"
            ///     // Prints "Response 301: Unknown response"
            ///
            /// When a dictionary's `Value` type has value semantics, you can use this
            /// subscript to perform in-place operations on values in the dictionary.
            /// The following example uses this subscript while counting the occurences
            /// of each letter in a string:
            ///
            ///     let message = "Hello, Elle!"
            ///     var letterCounts: [Character: Int] = [:]
            ///     for letter in message {
            ///         letterCounts[letter, defaultValue: 0] += 1
            ///     }
            ///     // letterCounts == ["H": 1, "e": 2, "l": 4, "o": 1, ...]
            ///
            /// When `letterCounts[letter, defaultValue: 0] += 1` is executed with a
            /// value of `letter` that isn't already a key in `letterCounts`, the
            /// specified default value (`0`) is returned from the subscript,
            /// incremented, and then added to the dictionary under that key.
            ///
            /// - Note: Do not use this subscript to modify dictionary values if the
            ///   dictionary's `Value` type is a class. In that case, the default value
            ///   and key are not written back to the dictionary after an operation.
            ///
            /// - Parameters:
            ///   - key: The key the look up in the dictionary.
            ///   - defaultValue: The default value to use if `key` doesn't exist in the
            ///     dictionary.
            /// - Returns: The value associated with `key` in the dictionary`; otherwise,
            ///   `defaultValue`.
            subscript<R>(key: R,
                default defaultValue: @autoclosure () -> Value) -> Value  where R: RawRepresentable, R.RawValue == Key {
                    guard let v = self[key.rawValue] else { return defaultValue() }
                    return v
            }

            /// Creates a new dictionary from the key-value pairs in the given sequence.
            ///
            /// You use this initializer to create a dictionary when you have a sequence
            /// of key-value tuples with unique keys. Passing a sequence with duplicate
            /// keys to this initializer results in a runtime error. If your
            /// sequence might have duplicate keys, use the
            /// `Dictionary(_:uniquingKeysWith:)` initializer instead.
            ///
            /// The following example creates a new dictionary using an array of strings
            /// as the keys and the integers in a countable range as the values:
            ///
            ///     let digitWords = ["one", "two", "three", "four", "five"]
            ///     let wordToValue = Dictionary(uniqueKeysWithValues: zip(digitWords, 1...5))
            ///     print(wordToValue["three"]!)
            ///     // Prints "3"
            ///     print(wordToValue)
            ///     // Prints "["three": 3, "four": 4, "five": 5, "one": 1, "two": 2]"
            ///
            /// - Parameter keysAndValues: A sequence of key-value pairs to use for
            ///   the new dictionary. Every key in `keysAndValues` must be unique.
            /// - Returns: A new dictionary initialized with the elements of
            ///   `keysAndValues`.
            /// - Precondition: The sequence must not have duplicate keys.
            init<S,R>(uniqueKeysWithValues keysAndValues: S) where S : Sequence, R: RawRepresentable, R.RawValue == Key, S.Element == (R, Value) {
                let ary = keysAndValues.map({($0.0.rawValue, $0.1)})
                self.init(uniqueKeysWithValues: ary)
            }

            /// Creates a new dictionary from the key-value pairs in the given sequence.
            ///
            /// You use this initializer to create a dictionary when you have a sequence
            /// of key-value tuples with unique keys. Passing a sequence with duplicate
            /// keys to this initializer results in a runtime error. If your
            /// sequence might have duplicate keys, use the
            /// `Dictionary(_:uniquingKeysWith:)` initializer instead.
            ///
            /// The following example creates a new dictionary using an array of strings
            /// as the keys and the integers in a countable range as the values:
            ///
            ///     let digitWords = ["one", "two", "three", "four", "five"]
            ///     let wordToValue = Dictionary(uniqueKeysWithValues: zip(digitWords, 1...5))
            ///     print(wordToValue["three"]!)
            ///     // Prints "3"
            ///     print(wordToValue)
            ///     // Prints "["three": 3, "four": 4, "five": 5, "one": 1, "two": 2]"
            ///
            /// - Parameter keysAndValues: A sequence of key-value pairs to use for
            ///   the new dictionary. Every key in `keysAndValues` must be unique.
            /// - Returns: A new dictionary initialized with the elements of
            ///   `keysAndValues`.
            /// - Precondition: The sequence must not have duplicate keys.
            init<S,R>(uniqueKeysWithValues keysAndValues: S) where S : Sequence, R: RawRepresentable, R.RawValue == Value, S.Element == (Key, R) {
                let ary = keysAndValues.map({($0.0, $0.1.rawValue)})
                self.init(uniqueKeysWithValues: ary)
            }

            /// Creates a new dictionary from the key-value pairs in the given sequence.
            ///
            /// You use this initializer to create a dictionary when you have a sequence
            /// of key-value tuples with unique keys. Passing a sequence with duplicate
            /// keys to this initializer results in a runtime error. If your
            /// sequence might have duplicate keys, use the
            /// `Dictionary(_:uniquingKeysWith:)` initializer instead.
            ///
            /// The following example creates a new dictionary using an array of strings
            /// as the keys and the integers in a countable range as the values:
            ///
            ///     let digitWords = ["one", "two", "three", "four", "five"]
            ///     let wordToValue = Dictionary(uniqueKeysWithValues: zip(digitWords, 1...5))
            ///     print(wordToValue["three"]!)
            ///     // Prints "3"
            ///     print(wordToValue)
            ///     // Prints "["three": 3, "four": 4, "five": 5, "one": 1, "two": 2]"
            ///
            /// - Parameter keysAndValues: A sequence of key-value pairs to use for
            ///   the new dictionary. Every key in `keysAndValues` must be unique.
            /// - Returns: A new dictionary initialized with the elements of
            ///   `keysAndValues`.
            /// - Precondition: The sequence must not have duplicate keys.
            init<S, RK, RV>(uniqueKeysWithValues keysAndValues: S) where S : Sequence, RK: RawRepresentable, RV: RawRepresentable, RK.RawValue == Key, RV.RawValue == Value, S.Element == (RK, RV) {
                let ary = keysAndValues.map({($0.0.rawValue, $0.1.rawValue)})
                self.init(uniqueKeysWithValues: ary)
            }

            init<R>(_ dictionary: [R: Value]) where R: RawRepresentable, R.RawValue == Key {
                let ary = dictionary.map({($0.key.rawValue, $0.value)})
                self.init(uniqueKeysWithValues: ary)
            }

            init<R>(_ dictionary: [Key: R]) where R: RawRepresentable, R.RawValue == Value {
                let ary = dictionary.map({($0.key, $0.value.rawValue)})
                self.init(uniqueKeysWithValues: ary)
            }

            init<RK, RV>(_ dictionary: [RK: RV]) where RK: RawRepresentable, RK.RawValue == Key, RV: RawRepresentable, RV.RawValue == Value {
                let ary = dictionary.map({($0.key.rawValue, $0.value.rawValue)})
                self.init(uniqueKeysWithValues: ary)
            }

            /// Removes the given key and its associated value from the dictionary.
            ///
            /// If the key is found in the dictionary, this method returns the key's
            /// associated value. On removal, this method invalidates all indices with
            /// respect to the dictionary.
            ///
            ///     var hues = ["Heliotrope": 296, "Coral": 16, "Aquamarine": 156]
            ///     if let value = hues.removeValue(forKey: "Coral") {
            ///         print("The value \(value) was removed.")
            ///     }
            ///     // Prints "The value 16 was removed."
            ///
            /// If the key isn't found in the dictionary, `removeValue(forKey:)` returns
            /// `nil`.
            ///
            ///     if let value = hues.removeValueForKey("Cerise") {
            ///         print("The value \(value) was removed.")
            ///     } else {
            ///         print("No value found for that key.")
            ///     }
            ///     // Prints "No value found for that key.""
            ///
            /// - Parameter key: The key to remove along with its associated value.
            /// - Returns: The value that was removed, or `nil` if the key was not
            ///   present in the dictionary.
            ///
            /// - Complexity: O(*n*), where *n* is the number of key-value pairs in the
            ///   dictionary.
            @discardableResult mutating func removeValue<R>(forKey key: R) -> Value? where R: RawRepresentable, R.RawValue == Key {
                return self.removeValue(forKey: key.rawValue)
            }
        }
    #endif
#else
    public extension Dictionary {
        /// Accesses the value associated with the given key for reading and writing.
        ///
        /// This *key-based* subscript returns the value for the given key if the key
        /// is found in the dictionary, or `nil` if the key is not found.
        ///
        /// The following example creates a new dictionary and prints the value of a
        /// key found in the dictionary (`"Coral"`) and a key not found in the
        /// dictionary (`"Cerise"`).
        ///
        ///     var hues = ["Heliotrope": 296, "Coral": 16, "Aquamarine": 156]
        ///     print(hues["Coral"])
        ///     // Prints "Optional(16)"
        ///     print(hues["Cerise"])
        ///     // Prints "nil"
        ///
        /// When you assign a value for a key and that key already exists, the
        /// dictionary overwrites the existing value. If the dictionary doesn't
        /// contain the key, the key and value are added as a new key-value pair.
        ///
        /// Here, the value for the key `"Coral"` is updated from `16` to `18` and a
        /// new key-value pair is added for the key `"Cerise"`.
        ///
        ///     hues["Coral"] = 18
        ///     print(hues["Coral"])
        ///     // Prints "Optional(18)"
        ///
        ///     hues["Cerise"] = 330
        ///     print(hues["Cerise"])
        ///     // Prints "Optional(330)"
        ///
        /// If you assign `nil` as the value for the given key, the dictionary
        /// removes that key and its associated value.
        ///
        /// In the following example, the key-value pair for the key `"Aquamarine"`
        /// is removed from the dictionary by assigning `nil` to the key-based
        /// subscript.
        ///
        ///     hues["Aquamarine"] = nil
        ///     print(hues)
        ///     // Prints "["Coral": 18, "Heliotrope": 296, "Cerise": 330]"
        ///
        /// - Parameter key: The key to find in the dictionary.
        /// - Returns: The value associated with `key` if `key` is in the dictionary;
        ///   otherwise, `nil`.
        subscript<E>(key: E) -> Value? where E: RawRepresentable, E.RawValue == Key {
            get {
                return self[key.rawValue]
            }
            set {
                self[key.rawValue] = newValue
            }
        }

        /// Accesses the value with the given key. If the dictionary doesn't contain
        /// the given key, accesses the provided default value as if the key and
        /// default value existed in the dictionary.
        ///
        /// Use this subscript when you want either the value for a particular key
        /// or, when that key is not present in the dictionary, a default value. This
        /// example uses the subscript with a message to use in case an HTTP response
        /// code isn't recognized:
        ///
        ///     var responseMessages = [200: "OK",
        ///                             403: "Access forbidden",
        ///                             404: "File not found",
        ///                             500: "Internal server error"]
        ///
        ///     let httpResponseCodes = [200, 403, 301]
        ///     for code in httpResponseCodes {
        ///         let message = responseMessages[code, default: "Unknown response"]
        ///         print("Response \(code): \(message)")
        ///     }
        ///     // Prints "Response 200: OK"
        ///     // Prints "Response 403: Access Forbidden"
        ///     // Prints "Response 301: Unknown response"
        ///
        /// When a dictionary's `Value` type has value semantics, you can use this
        /// subscript to perform in-place operations on values in the dictionary.
        /// The following example uses this subscript while counting the occurences
        /// of each letter in a string:
        ///
        ///     let message = "Hello, Elle!"
        ///     var letterCounts: [Character: Int] = [:]
        ///     for letter in message {
        ///         letterCounts[letter, defaultValue: 0] += 1
        ///     }
        ///     // letterCounts == ["H": 1, "e": 2, "l": 4, "o": 1, ...]
        ///
        /// When `letterCounts[letter, defaultValue: 0] += 1` is executed with a
        /// value of `letter` that isn't already a key in `letterCounts`, the
        /// specified default value (`0`) is returned from the subscript,
        /// incremented, and then added to the dictionary under that key.
        ///
        /// - Note: Do not use this subscript to modify dictionary values if the
        ///   dictionary's `Value` type is a class. In that case, the default value
        ///   and key are not written back to the dictionary after an operation.
        ///
        /// - Parameters:
        ///   - key: The key the look up in the dictionary.
        ///   - defaultValue: The default value to use if `key` doesn't exist in the
        ///     dictionary.
        /// - Returns: The value associated with `key` in the dictionary`; otherwise,
        ///   `defaultValue`.
        subscript<R>(key: R,
            default defaultValue: @autoclosure () -> Value) -> Value  where R: RawRepresentable, R.RawValue == Key {
                guard let v = self[key.rawValue] else { return defaultValue() }
                return v
        }

        /// Creates a new dictionary from the key-value pairs in the given sequence.
        ///
        /// You use this initializer to create a dictionary when you have a sequence
        /// of key-value tuples with unique keys. Passing a sequence with duplicate
        /// keys to this initializer results in a runtime error. If your
        /// sequence might have duplicate keys, use the
        /// `Dictionary(_:uniquingKeysWith:)` initializer instead.
        ///
        /// The following example creates a new dictionary using an array of strings
        /// as the keys and the integers in a countable range as the values:
        ///
        ///     let digitWords = ["one", "two", "three", "four", "five"]
        ///     let wordToValue = Dictionary(uniqueKeysWithValues: zip(digitWords, 1...5))
        ///     print(wordToValue["three"]!)
        ///     // Prints "3"
        ///     print(wordToValue)
        ///     // Prints "["three": 3, "four": 4, "five": 5, "one": 1, "two": 2]"
        ///
        /// - Parameter keysAndValues: A sequence of key-value pairs to use for
        ///   the new dictionary. Every key in `keysAndValues` must be unique.
        /// - Returns: A new dictionary initialized with the elements of
        ///   `keysAndValues`.
        /// - Precondition: The sequence must not have duplicate keys.
        init<S,R>(uniqueKeysWithValues keysAndValues: S) where S : Sequence, R: RawRepresentable, R.RawValue == Key, S.Element == (R, Value) {
            let ary = keysAndValues.map({($0.0.rawValue, $0.1)})
            self.init(uniqueKeysWithValues: ary)
        }

        /// Creates a new dictionary from the key-value pairs in the given sequence.
        ///
        /// You use this initializer to create a dictionary when you have a sequence
        /// of key-value tuples with unique keys. Passing a sequence with duplicate
        /// keys to this initializer results in a runtime error. If your
        /// sequence might have duplicate keys, use the
        /// `Dictionary(_:uniquingKeysWith:)` initializer instead.
        ///
        /// The following example creates a new dictionary using an array of strings
        /// as the keys and the integers in a countable range as the values:
        ///
        ///     let digitWords = ["one", "two", "three", "four", "five"]
        ///     let wordToValue = Dictionary(uniqueKeysWithValues: zip(digitWords, 1...5))
        ///     print(wordToValue["three"]!)
        ///     // Prints "3"
        ///     print(wordToValue)
        ///     // Prints "["three": 3, "four": 4, "five": 5, "one": 1, "two": 2]"
        ///
        /// - Parameter keysAndValues: A sequence of key-value pairs to use for
        ///   the new dictionary. Every key in `keysAndValues` must be unique.
        /// - Returns: A new dictionary initialized with the elements of
        ///   `keysAndValues`.
        /// - Precondition: The sequence must not have duplicate keys.
        init<S,R>(uniqueKeysWithValues keysAndValues: S) where S : Sequence, R: RawRepresentable, R.RawValue == Value, S.Element == (Key, R) {
            let ary = keysAndValues.map({($0.0, $0.1.rawValue)})
            self.init(uniqueKeysWithValues: ary)
        }

        /// Creates a new dictionary from the key-value pairs in the given sequence.
        ///
        /// You use this initializer to create a dictionary when you have a sequence
        /// of key-value tuples with unique keys. Passing a sequence with duplicate
        /// keys to this initializer results in a runtime error. If your
        /// sequence might have duplicate keys, use the
        /// `Dictionary(_:uniquingKeysWith:)` initializer instead.
        ///
        /// The following example creates a new dictionary using an array of strings
        /// as the keys and the integers in a countable range as the values:
        ///
        ///     let digitWords = ["one", "two", "three", "four", "five"]
        ///     let wordToValue = Dictionary(uniqueKeysWithValues: zip(digitWords, 1...5))
        ///     print(wordToValue["three"]!)
        ///     // Prints "3"
        ///     print(wordToValue)
        ///     // Prints "["three": 3, "four": 4, "five": 5, "one": 1, "two": 2]"
        ///
        /// - Parameter keysAndValues: A sequence of key-value pairs to use for
        ///   the new dictionary. Every key in `keysAndValues` must be unique.
        /// - Returns: A new dictionary initialized with the elements of
        ///   `keysAndValues`.
        /// - Precondition: The sequence must not have duplicate keys.
        init<S, RK, RV>(uniqueKeysWithValues keysAndValues: S) where S : Sequence, RK: RawRepresentable, RV: RawRepresentable, RK.RawValue == Key, RV.RawValue == Value, S.Element == (RK, RV) {
            let ary = keysAndValues.map({($0.0.rawValue, $0.1.rawValue)})
            self.init(uniqueKeysWithValues: ary)
        }

        init<R>(_ dictionary: [R: Value]) where R: RawRepresentable, R.RawValue == Key {
            let ary = dictionary.map({($0.key.rawValue, $0.value)})
            self.init(uniqueKeysWithValues: ary)
        }

        init<R>(_ dictionary: [Key: R]) where R: RawRepresentable, R.RawValue == Value {
            let ary = dictionary.map({($0.key, $0.value.rawValue)})
            self.init(uniqueKeysWithValues: ary)
        }

        init<RK, RV>(_ dictionary: [RK: RV]) where RK: RawRepresentable, RK.RawValue == Key, RV: RawRepresentable, RV.RawValue == Value {
            let ary = dictionary.map({($0.key.rawValue, $0.value.rawValue)})
            self.init(uniqueKeysWithValues: ary)
        }

        /// Removes the given key and its associated value from the dictionary.
        ///
        /// If the key is found in the dictionary, this method returns the key's
        /// associated value. On removal, this method invalidates all indices with
        /// respect to the dictionary.
        ///
        ///     var hues = ["Heliotrope": 296, "Coral": 16, "Aquamarine": 156]
        ///     if let value = hues.removeValue(forKey: "Coral") {
        ///         print("The value \(value) was removed.")
        ///     }
        ///     // Prints "The value 16 was removed."
        ///
        /// If the key isn't found in the dictionary, `removeValue(forKey:)` returns
        /// `nil`.
        ///
        ///     if let value = hues.removeValueForKey("Cerise") {
        ///         print("The value \(value) was removed.")
        ///     } else {
        ///         print("No value found for that key.")
        ///     }
        ///     // Prints "No value found for that key.""
        ///
        /// - Parameter key: The key to remove along with its associated value.
        /// - Returns: The value that was removed, or `nil` if the key was not
        ///   present in the dictionary.
        ///
        /// - Complexity: O(*n*), where *n* is the number of key-value pairs in the
        ///   dictionary.
        @discardableResult mutating func removeValue<R>(forKey key: R) -> Value? where R: RawRepresentable, R.RawValue == Key {
            return self.removeValue(forKey: key.rawValue)
        }
    }
#endif
