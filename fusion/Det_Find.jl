#=
- Deterministic Rule
- Under specific Falsealarm and Detection, find 'Minimum number of sensor' and 'threshold'
- the threshold of 'detection' rate equal to threshold of 'falsealarm' rate
- last change:
=#

function find_threshold(FalseofSensor, DetectofSensor, FalseofTarget, DetectofTarget)

  min_sensor = 0 #initial minimum number of sensor
  threshold_f = 0
  threshold_d = 0

  gofind = true

  while  gofind == true #find loop

    min_sensor = min_sensor +1

    for inverse_start = 0 : min_sensor   # inverse start_point for compute binomial sum

      start_point = (min_sensor - inverse_start)

      sum_falsealarm = 0
      sum_detection = 0

      for compute = start_point : min_sensor

        buffer_sum_f = binomial(min_sensor,compute)*((FalseofSensor)^compute)*((1-FalseofSensor)^(min_sensor-compute))
        sum_falsealarm = sum_falsealarm + buffer_sum_f

        if sum_falsealarm >= FalseofTarget

          threshold_f = start_point +1
          break

        end

      end

      for compute = start_point : min_sensor

        buffer_sum_d = binomial(min_sensor,compute)*((DetectofSensor)^compute)*((1-DetectofSensor)^(min_sensor-compute))
        sum_detection = sum_detection + buffer_sum_d

        if sum_detection >= DetectofTarget

          threshold_d = start_point
          break

        end

      end

      if threshold_f == threshold_d

        println("Minmum number of sensor")
        println(min_sensor)

        println("Threshold")
        println(threshold_d)

        gofind = false

        break
      end

    end

  end    #while

end   #function

find_threshold(0.2, 0.6, 0.05, 0.95)
