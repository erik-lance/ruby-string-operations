# *********************
# Name: Erik Lance L. Tiongquico
# Language: Ruby
# Paradigm: Object-Oriented
# *********************

# This is a ruby program in handling string operations.
puts ("CSADPRG MP String Operations w/ Distance")

operStr = ""

# Operation Methods
def copy(x)
    x
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

def minEditDist(str1,str2, x, y, matrix)
    # matrix.each { |x|
    #     puts x.join(" ")
    #    }
    if    x == 0 then return y
    elsif y == 0 then return x
    elsif (matrix[x][y] != -1) then return matrix[x][y]
    elsif str1[x-1] == str2[y-1] then
        if(matrix[x-1][y-1] == -1) then return matrix[x][y] = minEditDist(str1,str2,x-1,y-1,matrix)
        else return matrix[x][y] = matrix[x-1][y-1]
        end
    else
        val1 = 0
        val2 = 0
        val3 = 0

        if    matrix[x-1][y] != -1 then val1 = matrix[x-1][y]
        else  val1 = minEditDist(str1,str2,x-1,y, matrix)
        end

        if    matrix[x][y-1] != -1 then val2 = matrix[x][y-1]
        else  val2 = minEditDist(str1,str2,x,y-1, matrix)
        end

        if    matrix[x-1][y-1] != -1 then val3 = matrix[x-1][y-1]
        else  val3 = minEditDist(str1,str2,x-1,y-1, matrix)
        end
        
        return matrix[x][y] = 1 + [val1,val2,val3].min
    end
end

string1 = "intention"
string2 = "execution"

distance = 0
strMatrix = Array.new(string1.length+1) { Array.new(string2.length+1) {-1} }


print "Edit Distance: "
print minEditDist(string1, string2, string1.length, string2.length, strMatrix)
# print editStringDist(string1,string2,string1.length,string2.length)
# parseInt = gets.chomp
# distance = Integer(parseInt)
operStr = copy(string1)

# # This performs the operations based on the size of distance.
# (0...distance).each do |i|
#     # puts "Operation #{i}"
#     operStr = replace(operStr,'a')
#     puts "Now: #{operStr}"
#     @pointer += 1
# end