# This is a ruby program in handling string operations.


string1 = "intention"
string2 = "execution"
operStr = ""

distance = 0

puts "Edit Distance: "
distance = (Integer)gets

(0..distance).each do |i|
    puts "Operation #{i}"
end