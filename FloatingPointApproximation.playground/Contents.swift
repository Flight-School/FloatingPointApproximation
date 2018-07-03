import FloatingPointApproximation

0.1 + 0.2 == 0.3
0.1 + 0.2 ==~ 0.3

(0.1 + 0.2).isApproximatelyEqual(to: 0.3, within: .ulpOfOne)

1e-20 + 2e-20 == 3e-20

Double.ulpOfOne


let actual = 1e25 + 2e25
let expected = 3e25
abs(expected - actual) < .ulpOfOne // false
