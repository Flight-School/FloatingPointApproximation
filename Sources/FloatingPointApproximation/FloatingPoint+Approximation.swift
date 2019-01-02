infix operator ==~ : ComparisonPrecedence
/**
 Returns a Boolean value indicating whether
 two floating-point numbers are approximately equal.

 Floating-point numbers are defined to be approximately equal
 if they are within one _unit of least precision_, or ULP,
 of one another.
 */
public func ==~<T> (lhs: T, rhs: T) -> Bool where T: FloatingPoint  {
    return lhs == rhs || lhs.nextDown == rhs || lhs.nextUp == rhs
}

infix operator !=~ : ComparisonPrecedence
/**
 Returns a Boolean value indicating whether
 two floating-point numbers are not approximately equal.

 - SeeAlso: ==~
*/
public func !=~<T> (lhs: T, rhs: T) -> Bool where T: FloatingPoint {
    return !(lhs ==~ rhs)
}

extension FloatingPoint {
    /**
     Returns a Boolean value indicating whether
     the floating-point number is approximately equal to another value
     within a given absolute margin and/or
     maximum number of _units of least precision_, or ULPs.

     - Parameter other: The value to compare to this number.
     - Parameter margin: The maximum difference for approximate equality.
                         Must not be negative.
     - Parameter ulps: The maximum number of units of least precision
                       for approximate equality.
                       Must be greater than zero.
    */
    public func isApproximatelyEqual(to other: Self,
                                     within margin: Self?,
                                     maximumULPs ulps: Int = 1) -> Bool
    {
        precondition(margin?.sign != .minus && ulps > 0)

        guard self != other else {
            return true
        }

        let distance = abs(self - other)

        if let margin = margin, distance > margin {
            return false
        } else {
            return distance <= (self.ulp * Self(ulps))
        }
    }
}
