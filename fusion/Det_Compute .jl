# Deterministic Rule
# Compute Detection and Falsealarm without care Minumun number of sensor
# We can't compute fusion value without decide a threshold value, I fix falsealarm value to obtain threshold here.


function (NumofSensor, FalseofSensor, DetectofSensor, FalseofCenter)

  threshold = 0  #initial threshold

  for renew_startpoint = 0 : NumberofSensor   #renew startpoint to find threshold

    startpoint = (NumberofSensor - renew_startpoint)
    sum_falsealarm = 0   #initial sum/fusion of falsealarm

    for find_threshold = startpoint : NumberofSensor    #compute sum of fusion value for find fit threshold

      buffer_sum = binomial(NumberofSensor,find_threshold)*((FalseofSensor)^find_threshold)*((1-FalseofSensor)^(NumberofSensor-find_threshold))   #binomial
      sum_falsealarm = sum_falsealarm + buffer_sum

    end

    if sum_falsealarm >= FalseofCenter

      threshold = startpoint + 1



    end




  end





end
