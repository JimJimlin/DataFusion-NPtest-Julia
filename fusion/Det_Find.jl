#=
- Deterministic Rule
- Under specific Falsealarm and Detection, find 'Minimum number of sensor' and 'threshold'
- the threshold of 'detection' rate equal to threshold of 'falsealarm' rate
- last change:
=#

function find_threshold(FalseofSensor, DetectofSensor, FalseofTarget, DetectofTarget)

  mim_sensor = 0   #initial minimum number of sensor

  while(true)   #find loop

    min_sensor++

    for inverse_start = 0 : min_sensor   # inverse start_point for compute binomial sum

      start_point = min_sensor - inverse_start

      sum_falsealarm = 0
      sum_detection = 0

      for compute = start_point : min_sensor

        buffer_sum_f = binomial(min_sensor,compute)*((FalseofSensor)^compute)*((1-FalseofSensor)^(min_sensor-compute))
        sum_falsealarm = sum_falsealarm + buffer_sum_f

        buffer_sum_d = binomial(min_sensor,compute)*((DetectofSensor)^compute)*((1-DetectofSensor)^(min_sensor-compute))
        sum_detection = sum_detection + buffer_sum_d

      end

      if sum_falsealarm


      end


    end

  end


end








