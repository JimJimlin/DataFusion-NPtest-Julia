# Deterministic Rule
# Compute Detection and Falsealarm without care Minumun number of sensor
# We can't compute fusion value without decide a threshold value, I fix falsealarm value to obtain threshold here.


function (NumofSensor, FalseofSensor, DetectofSensor, FalseofCenter)

  threshold = 0  #initial threshold

  for renew_startpoint = 0 : NumberofSensor   #renew startpoint to find threshold

    startpoint = (NumberofSensor - renew_startpoint)
    sum_falsealarm = 0   #initial sum/fusion of falsealarm

    for find_threshold = startpoint : NumberofSensor


      buffer_sum = nchoosek(NumberOfSensor,flag_2)*((F_Sensor)^flag_2)*((1-F_Sensor)^(NumberOfSensor-flag_2))


    end


  end







end
