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

# using Binomial_Compute_2Type.jl

joint_probability(4, 0.2, 1, 0.4)

#=
function det_fusiontwotype(NumofFix, FalseofTarget, DetectofTarget, FalseofFix, DetectofFix, FalseofMove, DetectofMove )

  for NumofMove = 0: max_testnumber  #Find Number of Move





  end  # find loop




end  # function
=#





















#=

function det_fusiontwotype(NumofFix, FalseofTarget, DetectofTarget, FalseofFix, DetectofFix, FalseofMove, DetectofMove )

  max_testnumber = 250

  for NumofMove = 0: max_testnumber  #Find Number of Move

    sensor_total = NumofFix + NumofMove

    #=
    sensor_buffer = zeros(2, sensor_total)

    for quality_in = 1 : NumofFix    # input sensor quality in work buffer

      sensor_buffer[1, quality_in] = DetectofFix
      sensor_buffer[2, quality_in] = FalseofFix

    end

    for quality_in = (NumofFix + 1) : sensor_total   # input sensor quality in work buffer

      sensor_buffer[1, quality_in] = DetectofMove
      sensor_buffer[2, quality_in] = FalseofMove

    end

    probability_buffer = zeros(4, sensor_total)  #Use to compute probability of senor-fix and sensor-move
    =#





  end  #first loop: for

end  #function

=#




















