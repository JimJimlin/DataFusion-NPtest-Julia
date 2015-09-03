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

  include("Binomial_Compute_2Type.jl")

  NumofMove = 0 # initial
  max_testnumber = 10

  threshold_f = 0

  for NumofMove = 0: max_testnumber  #Find Number of Move

    sensor_total = NumofFix + NumofMove  + 1   # +1 for array index

    joint_probability_f_array = joint_probability(NumofFix, FalseofFix, NumofMove, FalseofMove)
    joint_probability_d_array = joint_probability(NumofFix, DetectofFix, NumofMove, DetectofMove)
    println(joint_probability_d_array)

    for inverse_start = 0 : sensor_total  # inverse start point for find threshold

      start_point = (sensor_total - inverse_start)

      sum_falsealarm = 0

      for compute = start_point : sensor_total

        temp_sum_f = joint_probability_f_array[compute,1]

        sum_falsealarm = sum_falsealarm + temp_sum_f

      end

      if sum_falsealarm >= FalseofTarget

        threshold_f = start_point +1

        break

      end

    end  # inverse loop F


      sum_detection = 0
      sum_falsealarm = 0

      for compute = threshold_f : sensor_total

        temp_sum_d = joint_probability_d_array[compute,1]
        temp_sum_f = joint_probability_f_array[compute,1]

        sum_detection = sum_detection + temp_sum_d
        sum_falsealarm = sum_falsealarm + temp_sum_f

      end

    if sum_falsealarm <= FalseofTarget && sum_detection >= DetectofTarget && NumofMove ==0

      println("Number of type-II sensor")
      println(NumofMove)

      println("Threshold")
      println(threshold_f)

    end

  if sum_falsealarm <= FalseofTarget && sum_detection >= DetectofTarget && NumofMove !=0

      println("Number of type-II sensor")
      println(NumofMove)

      println("Threshold")
      println(threshold_f)

    end


  end  # find loop

end  # function


det_fusiontwotype(1,0.1,0.9,0.2,0.8,0.4,0.6)
