# *********************
# Name: Erik Lance L. Tiongquico
# Language: Ruby
# Paradigm: Object-Oriented
# *********************

# This is a ruby program in handling string operations.
puts ("CSADPRG MP String Operations w/ Distance")



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

        # Insert
        if    matrix[x-1][y] != -1 then val1 = matrix[x-1][y]
        else  val1 = minEditDist(str1,str2,x-1,y, matrix)
        end

        # Remove
        if    matrix[x][y-1] != -1 then val2 = matrix[x][y-1]
        else  val2 = minEditDist(str1,str2,x,y-1, matrix)
        end

        # Replace
        if    matrix[x-1][y-1] != -1 then val3 = matrix[x-1][y-1]
        else  val3 = minEditDist(str1,str2,x-1,y-1, matrix)
        end
        @globalMatrix = matrix
        return matrix[x][y] = 1 + [val1,val2,val3].min
    end
end

string1 = "intention"
string2 = "execution"

distance = 0
strMatrix = Array.new(string1.length+1) { Array.new(string2.length+1) {-1} }
@globalMatrix = Array.new(string1.length+1) { Array.new(string2.length+1) {-1} }

puts "Input string 1 = #{string1}"
puts "Input string 2 = #{string2}"

print "Edit Distance: "
print minEditDist(string1, string2, string1.length, string2.length, strMatrix)

puts "\nOperations: "

(0...string1.length+1).each do |i|
    puts "Operation "+@globalMatrix[i][i].to_s
end
