# Raw Representable Helpers
![swift >= 4.0](https://img.shields.io/badge/swift-%3E%3D4.0-brightgreen.svg)
![macOS](https://img.shields.io/badge/os-macOS-green.svg?style=flat)
![Linux](https://img.shields.io/badge/os-linux-green.svg?style=flat)
![Apache 2](https://img.shields.io/badge/license-Apache2-blue.svg?style=flat)

This package provides helper methods where you may be using values in RawRepresentable Enums and have to call the .rawValue alot.
When using Arrays or Dictionaries where you would have the Element or Key type the same as a Enum with a RawValue type the same, this package will provide simmilar getter/setter/add/remove methods so you don't need to add the .rawValue each time

## Usage
```Swift
enum CodingKeys: String {
    case key1
    case key2
    case key3
}

var dictionary[String: Any] = [:]
dictionary[CodingKeys.key1] = true
dictionary[CodingKeys.key2] = 1
dictionary[CodingKeys.key3] = "String"
dictionary.removeValue(forKey: CodingKeys.key2)

var array: [String] = []
array.append(CodingKeys.key1)
array.append(CodingKeys.key2)
array.append(CodingKeys.key3)
_ = array.contains(CodingKeys.key3)


```

## Authors

* **Tyler Anger** - *Initial work* - [TheAngryDarling](https://github.com/TheAngryDarling)

## License

This project is licensed under Apache License v2.0 - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments
