# ruby-string-operations
A requirement in CS Advanced Programming. The language of choice is ruby.

The goal is to perform a distance of operations to copy the string in string 2 unto string 1 through dynamic programming.

## minEditDist
Simply put, it sets everything to -1. Afterwards, it does what is expected in a matrix through dynamic programming, which is if it expects a number of operations at this coordinate, it adds based on that number of operations. It then calculates the minimum number from it diagonally, from the west, and from the north. It stops when it reaches its  end. Note: not all boxes will actually be filled, it is efficient enough to avoid calculating too much.

## printEdit
Since this is dynamic programming, the approach is of course, top-down. We start at the last number at matrix[x][y] and this lets us view all the calculations from here.

It always calculates for a number equal to it diagonally first, which means it will simply move up since there is nothing interesting that happened. However, if it observes that the number diagonal from it is its number-1, it believes this is a replace statement! However if the approach is the same from y-1, it is an insert! Lastly, if it is from x-1, then it is a delete.

In a nutshell, the precedence is delete > insert > replace. It looks at [x-1] then [y-1] and then [x-1][y-1].

Note: Under the printEdits function, you may observe that the matrix at 0,0 is set to 0. This is merely to accommodate the calculations it takes top-down to read the operations. If it stayed as -1, it will produce an error.

For anyone new to ruby, the loop at the end is a simple range function reversed by setting the length to negative. Neat!
