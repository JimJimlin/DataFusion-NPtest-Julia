using Formatting






sum = 0
probability = 0.8
error_point = 67

for count = 1: error_point

    buffer_sum = binomial(error_point, count) * ((probability)^count) * ((1-probability)^(error_point-count))
    sum = sum + buffer_sum

    println(count,"    ",sum)
end
