def to_currency(number_string)
  raise "Invalid currency entry" if /[^\d|.]/ =~ number_string

  dollars = number_string.split(".")[0]
                         .reverse
                         .chars
                         .each_slice(3)
                         .map do |interval|
                            interval.reverse.join 
                          end
                         .reverse
                         .join(',')

  cents = sprintf("%.2f", number_string).scan(/\.\d/)[0]

  "$" + dollars + cents
end