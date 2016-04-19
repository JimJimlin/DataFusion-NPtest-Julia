#=
- Binomial_table
- Last change: 8/27/2015
=#

function binomial_table(Number, Probability)

  for successive_values = 0 : Number

    binomial_sum = binomial(Number,successive_values)*((Probability)^successive_values)*((1-Probability)^(Number-successive_values))
    println(" ")
    println(Number," ",successive_values," ",binomial_sum)

  end

end

binomial_table(3, 0.6)    #test
