#=
- Deterministic Rule
- Compute Detection and Falsealarm without care Minumun number of sensor
- We can't compute fusion value without decide a threshold value, I fix falsealarm value to obtain threshold here.
- last change: 8/21/2015
=#

function det_compute(NumberofSensor, FalseofSensor, DetectofSensor, FalseofCenter)

  threshold = 0  #initial threshold

  for renew_startpoint = 0 : NumberofSensor   #renew startpoint to find threshold

    startpoint = (NumberofSensor - renew_startpoint)
    sum_falsealarm = 0   #initial sum/fusion of falsealarm

    for find_threshold = startpoint : NumberofSensor    #compute sum of fusion value for find fit threshold

      buffer_sum = binomial(NumberofSensor,find_threshold)*((FalseofSensor)^find_threshold)*((1-FalseofSensor)^(NumberofSensor-find_threshold))   #binomial
      sum_falsealarm = sum_falsealarm + buffer_sum

    end

    if sum_falsealarm >= FalseofCenter  #check fusion velue

      threshold = startpoint + 1   #notice + 1

      Fusion_falsealarm = 0   #initial output
      Fusion_detection = 0

      for compute_output = threshold : NumberofSensor   #compute output

        buffer_falsealarm = binomial(NumberofSensor,compute_output)*((FalseofSensor)^compute_output)*((1-FalseofSensor)^(NumberofSensor-compute_output))
        buffer_detection = binomial(NumberofSensor,compute_output)*((DetectofSensor)^compute_output)*((1-DetectofSensor)^(NumberofSensor-compute_output))

        Fusion_falsealarm = Fusion_falsealarm + buffer_falsealarm
        Fusion_detection = Fusion_detection + buffer_detection

      end

      println("Threshold")
      println(threshold)

      println("Detection rate")
      println(Fusion_detection)

      println("Falsealarm rate")
      println(Fusion_falsealarm)

      break

    end

  end

end

det_compute(10,0.2,0.8,0.1)
