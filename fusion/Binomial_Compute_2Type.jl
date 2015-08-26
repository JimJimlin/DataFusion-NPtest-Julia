#=
- Example:

Sensor A - Reliable = 0.8 , Number = 2
Sensor B - Reliable = 0.6 , Number = 3

They have many permutations:

Count = 0 : (0, 0)
Conut = 1 : (0, 1), (1, 0)           ex: C(2, 0)*(0.8^0)*(0.2^2) x C(3, 1)*(0.6^1)*(0.4^2)      +      C(2, 1)*(0.8^1)*(0.2^1) x C(3, 0)*(0.6^0)*(0.4^3)
Conut = 2 : (0, 2), (1, 1), (2, 0)
Count = 3 : (0, 3), (1, 2),,,,,
,,      4       ,,
,,      5       ,,

This function will compute summation each Count, input a array.
Notice that if you compute sum from all factor in array, the answer = 1.

- last change: 8/26/2015
=#
