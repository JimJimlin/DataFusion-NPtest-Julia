#=
- Deterministic Rule
- Compute Detection and Falsealarm without care threshold

- Example

Assume
-Quality goal (a, b) = (0.05, 0.95)
-Type A sensor = (0.1, 0.9)
-Type B sensor = (0.4, 0.6)

We already have 5 type1 sensor, Under this condition, how many number of type2 sensor we need?
This question can be solve by thie function

Ans:
5 numberA(0.1 ,0.9) + 20 sensorB(0.4, 0.6) => (0.0424, 0.9576)

- last change:
=#

function det_fusiontwotype(NumofFix, FalseofTarget, DetectofTarget, FalseofFix, DetectofFix, FalseofMove, DetectofMove )

  max_testnumber = 250

  for NumofMove = 0: max_testnumber  #Find Number of Move

    sensor_total = NumofFix + NumofMove

    sensor_buffer = zeros(2, sensor_total)



  end  #first loop: for

end  #function
