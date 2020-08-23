def bubble_sort(arr= [4,3,78,2,0,2]) # We set an initial array "arr" equal to the example in the assignment.

  duplicate_number = get_duplicate_number(arr) # We've created a function called get_duplicate_number, which is further down, that we call here to get the duplicate number. When using array index values with duplicates, the first index value that matches the array element gets pulled, which makes it difficult to access the index of the second duplicate element, thus we need to ID the duplicates and put them into their own array of index values, so we can point to the correct duplicate element.
  duplicate_number_index_array = get_duplicate_number_index_array(arr) # We get the duplicate number's index array and declare it to access it later.
  duplicate_number_count = 0 # This count lines up with the index value of the duplicate in the duplicate number index array, so "0" would correspond to duplicate_number_index_array[0], and get the index position of the first duplicate inside the array being looped.
  swapped = false # We want a boolean (true or false variable) to keep track of whether there's a swap or not. If there's a swap, we can continue with another run of "bubble_sort", otherwise the sorting is complete and everything is in order.
  swapped_array = [] # We declare an empty array "swapped_array" that holds our modified "arr" array after swaps, after each "bubble_sort" cycle.

  # puts "duplicate_number: #{duplicate_number} and duplicate_number_index_array: #{duplicate_number_index_array}"

  arr.each do |current_number| # We loop through each element, or "current_number", in our array "arr".

    if current_number == duplicate_number # Here we want to see if the number we're working with is a duplicate. If it is...
      current_number_index = duplicate_number_index_array[duplicate_number_count] # Its index is the value of the duplicate_number_index_array at the "duplicate number count" number.
      duplicate_number_count += 1 # We tick up our duplicate number count so that the next duplicate shows the correct index spot in the original array.
    else 
      current_number_index = arr.find_index(current_number) # This is normally what the current number index is, just the index of its value inside our "arr"
    end

    next_number_index = current_number_index + 1 # The next number index is always the current number index plus 1, because we move from left to right in the array.
    next_number = arr[next_number_index] # Therefore next number is the array value at the next number index.

    # puts "current number: #{current_number}, current number index: #{current_number_index}, next number: #{next_number}, next number index: #{next_number_index}"

    if current_number_index < arr.length - 1 # We don't want to sort if the current number index is less than the array length minus 1. In the sample array of 6 numbers, that means we stop when current number index is at 4, because at 5, 5 is not less than 5.
      # puts "current_number_index: #{current_number_index}, is less than 5"

      if current_number > next_number # This is our swapping code. If the current number, or left number, is bigger than the next number, or right number, we want to switch their positions.
        arr[current_number_index] = next_number # To switch, we set the value in the array at the current number index equal to the next number...
        arr[next_number_index] = current_number # and the value in the array at the next number index equal to the current number.
        swapped = true # Once we swap, we want to change our "swapped" boolean to true so we can run bubble_sort again, until there are no more swaps needed, which means it is fully sorted.

        # puts "swapped array: #{arr}, swapped? #{swapped}"

        duplicate_number = get_duplicate_number(arr) # Everytime we swap, we need to run get duplicate number and get duplicate number index array to get the correct index spots for the duplicates, as they may have changed during a swap. We also reset the duplicate count, so the first instance of the duplicate always corresponds to the first element in the duplicate_number_index_array.
        duplicate_number_index_array = get_duplicate_number_index_array(arr)
        duplicate_number_count = 0

        
        

      else
        # puts "#{current_number} and #{next_number} did not get swapped" 
      end
    else
      # puts "loop stopped at current number: #{current_number}"

    end
  end

  swapped_array = arr # Once done with a loop through the array, we want to save the new swapped array.
  if swapped == true # If there was a swap in the cycle, then run another bubble_sort cycle.

    # puts "swapped? #{swapped}"
    bubble_sort(arr)
  else
    return swapped_array # If no more swaps are made, the array is sorted and we can return it as the solution.
  end
end

def get_duplicate_number(arr= [4,3,78,2,0,2]) # In order to get the duplicate numbers of an array "arr"...
  duplicate_number = arr.detect {|e| arr.count(e)>1 } # we run the detect method on the array, setting each array element to a variable e, then we run a count method for the array for e, and if e's count is 2 or more, then it has duplicates. Detect returns the duplicate number, which we set to a variable to access.
  # puts  "duplicate_number: #{duplicate_number}"
  return duplicate_number
end

def get_duplicate_number_index_array(arr= [4,3,78,2,0,2]) # In order to get the index values of each duplicate...
  duplicate_number_index_array = arr.each_index.select {|i| arr[i] == get_duplicate_number} # We run a select method on each index of the array "arr". We set variable "i" equal to each index, and only return the indexes that match the duplicate number, which is obtained by the "get_duplicate_number" function. 
  # puts "duplicate_number_index_array: #{duplicate_number_index_array}" 
  return duplicate_number_index_array
end

bubble_sort #=> [0, 2, 2, 3, 4, 78]



