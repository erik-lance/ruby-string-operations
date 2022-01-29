# *********************
# Name: Erik Lance L. Tiongquico
# Language: Ruby
# Paradigm: Object-Oriented
# *********************

# This is a ruby program in handling string edit operations.
class Distance
    # Constructor for the Distance Object
    def initialize(string1, string2, matrix)
        @matrix = matrix
        @str1 = string1
        @str2 = string2
        @editPrompts = Array.new
        @distance = minEditDist(string1.length,string2.length)
    end

    # This performs all the calculations for the edit distance
    # x = pointer in x direction (initially length of str1)
    # y = pointer in y direction (initially length of str2)
    def minEditDist(x, y)
        if x == 0 then return y end
        if y == 0 then return x end 

        # Skips calculated coordinates
        if (@matrix[x][y] != -1) then return @matrix[x][y] end

        # If pointers are equal, find the minimum distance.
        if @str1[x-1] == @str2[y-1] then
            if(@matrix[x-1][y-1] == -1) then 
                @matrix[x][y] = minEditDist(x-1,y-1)
                return @matrix[x][y]
            else 
                @matrix[x][y] = @matrix[x-1][y-1]
                return @matrix[x][y]
            end
        else
            # Find the minimum cost operation between the three if not equal at pointer
            # Delete
            if    @matrix[x-1][y] != -1 then val1 = @matrix[x-1][y]
            else  val1 = minEditDist(x-1,y)
            end

            # Insert
            if    @matrix[x][y-1] != -1 then val2 = @matrix[x][y-1]
            else  val2 = minEditDist(x,y-1)
            end

            # Replace
            if    @matrix[x-1][y-1] != -1 then val3 = @matrix[x-1][y-1]
            else  val3 = minEditDist(x-1,y-1)
            end
            @matrix[x][y] = 1 + [val1,val2,val3].min
            return @matrix[x][y]
        end
    end

    # Prepare the edits to reach the goal string from [x][y]
    def prepareEdits
        # For print calculation purposes, the index 0,0 must be 0
        # instead of -1 due to dynamic programming and memoization.
        @matrix[0][0] = 0
        
        # Grabs the length of horizontal and vertical in matrix
        x = @matrix.length-1
        y = @matrix[0].length-1
        printList = Array.new
        while(true) 
            if (x==0||y==0) then 
                break; 
            end
            if (@str1[x-1]==@str2[y-1])
                x = x-1
                y = y-1
            elsif (@matrix[x][y] == @matrix[x-1][y]+1)
                printList.push("Delete "+@str1[x-1])
                x = x-1
            elsif (@matrix[x][y] == @matrix[x][y-1]+1)
                printList.push("Insert "+@str2[y-1])
                y= y-1
            elsif (@matrix[x][y] == @matrix[x-1][y-1]+1)
                printList.push("Replace "+@str1[x-1]+" with "+@str2[y-1])
                x = x-1
                y = y-1
            else
                puts "ERROR"
                break
            end
        end
        @editPrompts = printList
    end

    def printPrompts
        # This prints in reverse order to show the proper logic
        (-@editPrompts.length()...1).each do |x|
            puts @editPrompts[x.abs]
        end
    end

    def getDistance 
        return @distance;
    end
    def getMatrix
        return @matrix;
    end
end

puts ("CSADPRG MP String Operations w/ Distance\n")

print "Input string 1 = "
string1 = gets.chomp
print "Input string 2 = "
string2 = gets.chomp

# This simply creates a matrix of value -1 (which is the base value)
strMatrix = Array.new(string1.length+1) { Array.new(string2.length+1) {-1} }
distProgram = Distance.new(string1,string2, strMatrix)

print "Edit Distance: "
print distProgram.getDistance

distProgram.prepareEdits
print "\n\nOperations: "
distProgram.printPrompts

# Feel free to uncomment to debug how the matrix looks like.
# width = distProgram.getMatrix.flatten.max.to_s.size+2
# puts distProgram.getMatrix.map { |a| a.map { |i| i.to_s.rjust(width) }.join }