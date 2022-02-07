# *********************
# Name: Erik Lance L. Tiongquico
# Language: Ruby
# Paradigm: Object-Oriented
# *********************

# This is a ruby program in handling string edit operations.

# X,Y is the pointer of the matrix.
class EditMatrix
    def initialize(matrix, x, y)
        @matrix = matrix
        @x = x
        @y = y
    end

    # Getters
    def getMatrix()     return @matrix             end

    def getPoint()      return @matrix[@x][@y]     end

    def getNorth()      return @matrix[@x][@y-1]   end

    def getWest()       return @matrix[@x-1][@y]    end

    def getNorthWest()  return @matrix[@x-1][@y-1] end

    # Setters
    def setMatrix(z)    @matrix = z             end

    def setPoint(z)     @matrix[@x][@y] = z     end

    def setNorth(z)     @matrix[@x][@y-1] = z   end
    
    def setWest(z)      @matrix[@x-1][@y] = z   end

    def setNorthWest(z) @matrix[@x-1][@y-1] = z end
end

class Distance
    # Constructor for the Distance Object
    def initialize(string1, string2, matrix)
        @editM = EditMatrix.new(matrix, string1.length, string2.length)
        @str1 = string1
        @str2 = string2
        @editPrompts = Array.new
        @distance = minEditDist(@editM, string1.length,string2.length)
    end

    # This performs all the calculations for the edit distance
    # x = pointer in x direction (initially length of str1)
    # y = pointer in y direction (initially length of str2)
    def minEditDist(m, x, y)
        matrix = EditMatrix.new(m.getMatrix,x,y)
        if x == 0 then return y end
        if y == 0 then return x end 

        # Skips calculated coordinates
        if (matrix.getPoint != -1) then return matrix.getPoint end

        # If pointers are equal, find the minimum distance.
        if @str1[x-1] == @str2[y-1] then
            if(matrix.getNorthWest == -1) then 
                matrix.setPoint(minEditDist(matrix, x-1,y-1))
                return matrix.getPoint
            else 
                matrix.setPoint(matrix.getNorthWest)
                return matrix.getPoint
            end
        else
            # Find the minimum cost operation between the three if not equal at pointer
            # Delete
            if    matrix.getWest != -1 then val1 = matrix.getWest
            else  val1 = minEditDist(matrix, x-1,y)
            end

            # Insert
            if    matrix.getNorth != -1 then val2 = matrix.getNorth
            else  val2 = minEditDist(matrix, x,y-1)
            end

            # Replace
            if    matrix.getNorthWest != -1 then val3 = matrix.getNorthWest
            else  val3 = minEditDist(matrix, x-1,y-1)
            end
            matrix.setPoint(1 + [val1,val2,val3].min)
            setMatrix(matrix)
            return matrix.getPoint
        end
    end

    # Prepare the edits to reach the goal string from [x][y]
    def prepareEdits
        # For print calculation purposes, the index 0,0 must be 0
        # instead of -1 due to dynamic programming and memoization.
        matrixTemp = @editM.getMatrix
        matrixTemp[0][0] = 0
        @editM.setMatrix(matrixTemp)
        
        # Grabs the length of horizontal and vertical in matrix
        x = @editM.getMatrix.length-1
        y = @editM.getMatrix[0].length-1
        

        printList = Array.new
        while(true) 
            if (x==0||y==0) then 
                break; 
            end
            if (@str1[x-1]==@str2[y-1])
                x = x-1
                y = y-1
            elsif (@editM.getPoint == @editM.getWest+1)
                printList.push("Delete "+@str1[x-1])
                x = x-1
            elsif (@editM.getPoint == @editM.getNorth+1)
                printList.push("Insert "+@str2[y-1])
                y= y-1
            elsif (@editM.getPoint == @editM.getNorthWest+1)
                printList.push("Replace "+@str1[x-1]+" with "+@str2[y-1])
                x = x-1
                y = y-1
            else
                puts "ERROR"
                break
            end
            # Moves the pointer
            @editM = EditMatrix.new(@editM.getMatrix, x,y)
        end
        @editPrompts = printList
    end

    def printPrompts
        # This prints in reverse order to show the proper logic
        (-@editPrompts.length()...1).each do |x|
            puts @editPrompts[x.abs]
        end
    end

    def getDistance() return @distance; end
    def getMatrix() return @editM.getMatrix; end

    def setMatrix(z) @editM = z end
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