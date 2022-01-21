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
    if x == 0 then return y end
    if y == 0 then return x end

    if (matrix[x][y] != -1) then return matrix[x][y] end

    # If characters are equal, perform a recursive function of finding the minimum distance.
    if str1[x-1] == str2[y-1] then
        if(matrix[x-1][y-1] == -1) then 
            matrix[x][y] = minEditDist(str1,str2,x-1,y-1,matrix)
            return matrix[x][y]
        else 
            matrix[x][y] = matrix[x-1][y-1]
            return matrix[x][y]
        end
    else
        # If characters are not equal, we find the minimum cost operation between the three.
        val1 = 0
        val2 = 0
        val3 = 0

        # Remove
        if    matrix[x-1][y] != -1 then val1 = matrix[x-1][y]
        else  val1 = minEditDist(str1,str2,x-1,y, matrix)
        end

        # Insert
        if    matrix[x][y-1] != -1 then val2 = matrix[x][y-1]
        else  val2 = minEditDist(str1,str2,x,y-1, matrix)
        end

        # Replace
        if    matrix[x-1][y-1] != -1 then val3 = matrix[x-1][y-1]
        else  val3 = minEditDist(str1,str2,x-1,y-1, matrix)
        end
        matrix[x][y] = 1 + [val1,val2,val3].min
        @globalMatrix = matrix
        return matrix[x][y]
    end
end

# Prints the edits to reach the goal string from [x][y]
def printEdits(matrix, str1, str2)
    # Grabs the length of horizontal and vertical in matrix
    x = matrix.length-1
    y = matrix[0].length-1
    loop = true
    printList = Array.new
    while(loop) 
        if (x==0||y==0) then 
            loop = false
            break; 
        end
        if (str1[x-1]==str2[y-1])
            x = x-1
            y = y-1
        elsif (matrix[x][y] == matrix[x-1][y-1]+1)
            printList.push("Replace "+str1[x-1]+" with "+str2[y-1])
            x = x-1
            y = y-1
        elsif (matrix[x][y] == matrix[x-1][y]+1)
            puts "test"
            printList.push("Delete "+str1[x-1])
            x = x-1
        elsif (matrix[x][y] == matrix[x][y-1]+1)
            printList.push("Insert "+str2[y-1])
            y= y-1
        else
            puts "ERROR "+x.to_s+" and "+y.to_s
            loop = false
        end
    end

    # This prints in reverse order to show the proper logic
    (-printList.length()...0).each do |x|
        puts printList[x.abs]
    end
end

string1 = "intention"
string2 = "execution"

distance = 0
# This simply creates a matrix of value -1 (which is the base value)
strMatrix = Array.new(string1.length+1) { Array.new(string2.length+1) {-1} }
@globalMatrix = Array.new(string1.length+1) { Array.new(string2.length+1) {-1} }

puts "Input string 1 = #{string1}"
puts "Input string 2 = #{string2}"

print "Edit Distance: "
print minEditDist(string1, string2, string1.length, string2.length, strMatrix)

puts "\nOperations: "
strMatrix = @globalMatrix
printEdits(strMatrix, string1, string2)
# (0...string1.length+1).each do |i|
#     puts "Operation "+@globalMatrix[i][i].to_s

# end

# puts "Matrix rn: "
# @globalMatrix.each { |x|
#     if (x.length < 2) then x = " a#{x}" end
#         puts x.join(" ")
# }

width = @globalMatrix.flatten.max.to_s.size+2
  #=> 4
puts strMatrix.map { |a| a.map { |i| i.to_s.rjust(width) }.join }