# FloatingPointApproximation

A correct way to determine if two floating-point numbers
are approximately equal to one another.

This functionality is discussed in Chapter 3 of
[Flight School Guide to Swift Numbers](https://gumroad.com/l/swift-numbers).

## Requirements

- Swift 4.0+

## Installation

### Swift Package Manager

Add the FloatingPointApproximation package to your target dependencies in `Package.swift`:

```swift
import PackageDescription

let package = Package(
  name: "YourProject",
  dependencies: [
    .package(
        url: "https://github.com/Flight-School/FloatingPointApproximation",
        from: "1.0.0"
    ),
  ]
)
```

Then run the `swift build` command to build your project.

### Carthage

To use `FloatingPointApproximation` in your Xcode project using Carthage,
specify it in `Cartfile`:

```
github "Flight-School/FloatingPointApproximation" ~> 1.0.0
```

Then run the `carthage update` command to build the framework,
and drag the built FloatingPointApproximation.framework into your Xcode project.

## Usage

Floating-point arithmetic can produce unexpected results,
such as `0.1 + 0.2 != 0.3`.
The reason for this is that many fractional numbers,
including `0.1`, `0.2`, and `0.3`,
cannot be precisely expressed in a binary number representation.

A common mistake is to use an arbitrarily small constant
(such as `.ulpOfOne`)
to determine whether two floating-point numbers are approximately equal.
For example:

```swift
let actual = 0.1 + 0.2
let expected = 0.3
abs(expected - actual) < .ulpOfOne // true
```

However, this doesn't work for large scale numbers:

```swift
let actual = 1e25 + 2e25
let expected = 3e25
abs(expected - actual) < .ulpOfOne // false
```

A better approach for determining approximate equality
would be to count how many representable values, or ULPs,
exist between two floating-point numbers.

The `==~` operator (and its complement, `!=~`)
defined by this package
returns a Boolean value indicating whether
two floating-point numbers are approximately equal.

```swift
import FloatingPointApproximation

0.1 + 0.2 == 0.3 // false
0.1 + 0.2 ==~ 0.3 // true
```

Floating-point numbers are defined to be approximately equal
if they are within one _unit of least precision_, or
[ULP](https://en.wikipedia.org/wiki/Unit_in_the_last_place),
of one another.

Because of how Swift implements floating-point numbers,
the implementation of the `==~` operator is quite simple:

```swift
func ==~<T> (lhs: T, rhs: T) -> Bool where T: FloatingPoint  {
    return lhs == rhs || lhs.nextDown == rhs || lhs.nextUp == rhs
}
```

A more complete approach combines both absolute and relative comparisons.
The `isApproximatelyEqual(to:within:maximumULPs:)` method
determines whether a floating-point number
is approximately equal to another value
by first checking to see if it is within a given absolute margin, if provided,
and then checking to see if it falls within a given number of ULPs:

```swift
import FloatingPointApproximation

(0.1 + 0.2).isApproximatelyEqual(to: 0.3, within: 1e-12, maximumULPs: 2)
```

Ultimately, it's your responsibility to determine how to compare
two floating-point numbers for approximate equality
based on the requirements of your domain.

## License

MIT

## Contact

Mattt ([@mattt](https://twitter.com/mattt))
