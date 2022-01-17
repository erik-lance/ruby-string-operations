# This is a ruby program in handling string operations.
puts ("CSADPRG MP String Operations w/ Distance")

@pointer = 0
operStr = ""

# Operation Methods
def copy(x)
    x
end

def insert(str,x)
    # Creates a substring from the pointer index to end.
    operStr = str
    subStr = operStr.slice!(@pointer..-1)
    operStr[@pointer] = x
    operStr+subStr
end

def delete(str)
    operStr = str
    subStr = operStr.slice!(@pointer..-1)
    # Pointer moved back by one so it stays in the same index.
    @pointer -= 1
    operStr+subStr.slice!(1..-1)
end

def replace(str, x)
    operStr = str
    operStr[@pointer] = x
    operStr
end

def editStringDist(str1, str2, x,y)
    if    x == 0 then y
    elsif y == 0 then x
    elsif (str1[x-1] == str2[y-1]) then editStringDist(str1,str2,x,y)
    else
        value = 1 + [editStringDist(str1,str2,x,y-1),
                    editStringDist(str1,str2,x-1,y),
                    editStringDist(str1,str2,x-1,y-1)].min
    end
end

string1 = "intention"
string2 = "execution"


distance = 0

print "Edit Distance: "
parseInt = gets.chomp
distance = Integer(parseInt)
operStr = copy(string1)

# # This performs the operations based on the size of distance.
# (0...distance).each do |i|
#     # puts "Operation #{i}"
#     operStr = replace(operStr,'a')
#     puts "Now: #{operStr}"
#     @pointer += 1
# end