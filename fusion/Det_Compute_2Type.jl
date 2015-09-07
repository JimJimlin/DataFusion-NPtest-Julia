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


#=
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
=#



















































function DissimilarSensorFusion(NumberofTypeFix,Goal_F,Goal_D,TypeFixOfFalse,TypeFixOfDetection,TypeMoveOfFalse,TypeMoveOfDetection)


MaxFindNumber = 200

for NumberofTypeMove = 0 : MaxFindNumber
    NumberOfALL = (NumberofTypeFix+NumberofTypeMove)

    thresholdTofF = 0

    for i = 0:NumberOfALL  # Watch out the ( 0:NumberOfSS )
        egg = (NumberOfALL - i)
        buffer_sum_b = 0

        for j = egg:NumberOfALL

            buffer_sum_a = 0

            for k = 0:j
                buffer_a = (j - k)
                buffer_b = (j - buffer_a)

                if buffer_a > NumberofTypeMove | buffer_b > NumberofTypeFix
                    continue
                else
                    buffer_c = (binomial(NumberofTypeMove,buffer_a) * ((TypeMoveOfFalse)^buffer_a) * ((1 - TypeMoveOfFalse)^(NumberofTypeMove-buffer_a))) *(binomial(NumberofTypeFix,buffer_b) * ((TypeFixOfFalse)^buffer_b) * ((1 - TypeFixOfFalse)^(NumberofTypeFix-buffer_b)))
                    buffer_sum_a = buffer_sum_a + buffer_c
                end
            end

            buffer_sum_b = buffer_sum_b + buffer_sum_a

        end

        if buffer_sum_b >= Goal_F
            thresholdTofF = egg+1
            buffer_sum_b
            break
        end

    end

    buffer_sum_b = 0 # re initial
    buffer_sum_e = 0

    for j = thresholdTofF:NumberOfALL

        buffer_sum_a = 0
        buffer_sum_d = 0
        for k = 0:j
            buffer_a = (j - k)
            buffer_b = (j - buffer_a)

            if buffer_a > NumberofTypeMove | buffer_b > NumberofTypeFix
                continue
            else
                buffer_c = (binomial(NumberofTypeMove,buffer_a) * ((TypeMoveOfFalse)^buffer_a) * ((1 - TypeMoveOfFalse)^(NumberofTypeMove-buffer_a))) * (binomial(NumberofTypeFix,buffer_b) * ((TypeFixOfFalse)^buffer_b) * ((1 - TypeFixOfFalse)^(NumberofTypeFix-buffer_b)))
                buffer_sum_a = buffer_sum_a + buffer_c

                buffer_f = (binomial(NumberofTypeMove,buffer_a) * ((TypeMoveOfDetection)^buffer_a) * ((1 - TypeMoveOfDetection)^(NumberofTypeMove-buffer_a))) *  (binomial(NumberofTypeFix,buffer_b) * ((TypeFixOfDetection)^buffer_b) * ((1 - TypeFixOfDetection)^(NumberofTypeFix-buffer_b)))
                buffer_sum_d = buffer_sum_d + buffer_f

            end
        end

        buffer_sum_b = buffer_sum_b + buffer_sum_a
        buffer_sum_e = buffer_sum_e + buffer_sum_d
    end

    falsealarm = buffer_sum_b
    detecetion = buffer_sum_e

    if detecetion >= Goal_D &&  falsealarm <= Goal_F && NumberofTypeMove ==0
      println("Number of type-II sensor =")
      println(NumberofTypeMove)

      println("Detection =")
      println(detecetion)

      println("Falsealarm =")
      println(falsealarm)





        break
    end

    if detecetion >= Goal_D &&  falsealarm <= Goal_F && NumberofTypeMove !=0
       println("Number of type-II sensor =")
      println(NumberofTypeMove)

      println("Detection =")
      println(detecetion)

      println("Falsealarm =")
      println(falsealarm)
        break
    end

end

end

DissimilarSensorFusion(1, 0.1 , 0.9 , 0.2 , 0.8 , 0.4 , 0.6)
