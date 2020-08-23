# bubble-sort

Bubble sort is a apparently simple sorting method that passes through an array of numbers, comparing 2 neighboring numbers, and swapping them in the one on the left is greater than the one on the right. It does this however many times until all the numbers in the array are sorted in ascending order.

Going through the Bubble Sort cs50 youtube video gave a hint that we don't need to bubble sort more than array.length-1 times. He uses example arrays of length 2 and 3 to show this. Also, he says after a k + x number of sorts, we can check n - x number of elements. He says after every pass (k), the largest number will be on the right side, so each iteration can go one less space to the right (x less from the right). Furthermore, he says you know when you don't need to sort anymore, or when to stop, when nothing gets swapped on a iteration through the array, so maybe have a counter that keeps track, or a boolean, which says whether an iteration had a swap or not. 

OK, let's see if we can come up with some pseudocode. That youtube video was quite helpful. He pretty much covered all the steps, but we will summarize here. We have an array of numbers. We're gonna loop through each number, and on each loop, we take the current number, and compare it to the number to the right of it, or who's index is the current number's index, plus 1 (we can see us running into problems with the index spots and duplicates already lol). There will be a several conditions that the sort must adhere to. First, we're gonna stop at array.length - 1 (since array length starts at 1 but array indices start at 0), which we can adjust (if we want to optimize), to be 1 smaller with each iteration through the array. Also, once the comparison shows the current number is greater than the next number, they must be swapped, so we're gonna need a new array each time? Or maybe erase the last array after an iteration and replace with new array? That seems kinda complicated. Furthermore, we have have a boolean that will be true if a swap was made. This boolean should be checked at the end of each iteration, and if false, the sorting can stop. If true, we repeat, but with the partially sorted array instead of original array.

Alright, let's start with a function name and a loop through our array. Let's use the example array as the array to use. As we're writing the code, we realize we only need 1 loop through the array. We thought it might have been another loop within a loop, but I think we only need 1 loop, bc we just compare the next number. Alright, so we've coded the current and next number, now we need a limitation on the next number. When do we stop again? When next number index is >= arr.length - 1? Ok good, we put in the limitation. When we debugged this part, that duplicate array item problem crept back up. The first "2" has an index of 4, then the following "0" has an index of 5, but then the second "2" has an index of 4 again, instead of the correct index of 6. It matched the index to the first "2" in the array, and not the second "2" that we are working on. How are we gonna solve this? We see this code from a stack overflow post "fruits.each_index.select { |i| fruits[i]=="apples" } => [0,2,4]" So, if we take the array, call "each_index.select" on it, then select for the variable for index value "i" inside the array that is equal to our desired array item, we return an array of index values that equal our item. How do we implement this code to get around duplicates? Is it even relevant? 

So that code returns the index values for all items in the array that we "select", so how does this solve our duplicate problem? Expanding on the duplicate problem, whatever code we place inside the if statement, instead of stoping when the next_index_number is equal to array.length - 1, it will do the code bc it thinks the index number is smaller than it actually is. This is not an irrelevant problem, it will affect our results, so we're gonna need to find a way to resolve it. So, if we have an array with 2 "2"s, that are duplicates, and we run the "select" method and get their index position, 3 and 5, can we use some counter to track which index we're on? For example, let's talk more generically. Say we have a random array. We can run some duplicate checking method, which returns an array of, say the only duplicate, with their index values. Then the first time we hit the duplicate value, we get the index from the new duplicate array (index 0 of the duplicate array gives us the value of the index for the first duplicate), then we tick our duplicate counter to 1. So next time we hit the duplicate, we get the duplicate's correct index from "duplicate_array[#{duplicate_counter_value}]", or index 1 of the duplicate array. How feasible is this method with multiple duplicates? Not sure, but for one duplicate, I think it's a fine way to code it.

Alright, so what do we need? We're gonna need another array, a "duplicate_index_array", and another variable called "duplicate_counter_value", to keep track of our duplicates. That seems good, but what is the actual code for finding duplicates? We want to sort through the array, see if any of the values match the ones past it, but not exceeding the index value at array.length - 1. If we want to code for multiple duplicates, we can probably put the values inside a hash, so each duplicate has its value as a key, and all the index positions as the key values. If there's just one duplicate, as in this case, we can just get the index where each duplicate is, and then place them into our "duplicate_index_array'. When we run into a value that is a duplicate, the first time our "duplicate_counter_value" is 0, and we go the the 0 index of the "duplicate_index_array" and get that value, which represents that duplicates correct index position in the original array. Then we tick up the "duplicate_counter_value". If we're using a hash of multiple duplicates, we'd match the duplicate to all the hash keys, then we'd get a corresponding array. From there, we need to know that duplicates counter value, and match it to its duplicate index array inside the hash.

Wait a minute, if we are using each to loop through each array, then limiting each number by their index positions, we run into the same problem of the index values not displaying properly with duplicates. Let's review the code to get their index values again. We google and find this code for detecting dupes "a = ["A", "B", "C", "B", "A"]
a.detect{ |e| a.count(e) > 1 }". So, for an array "a", we run the "detect" method on it, which detects the first instance of a condition and returns it (I guess this means it only returns duplicates of 2, not 3?). Our condition is that the count for each element (e) in a be greater than 1, or that there's a duplicate. We will run the other select method to find the indices of the duplicates, but let's try this code and see if we get the correct duplicate count. When we ran the code in terminal, it only returned "A" as a duplicate, and now we know what it means when it says dectect "only returns the first instance of a condition". "A" was the first duplicate it found, and returned it, but we see that there are actually 2 duplicates in this array, and it only found 1. For the purposes of this assignment, since there's only 1 dupe, this is fine. but note this will not find multiple duplicates. Lol, we surrounded our parameter for the get_duplicates function with brackets instead of parantheses and couldn't figure out why it wasn't compiling in terminal. Alright, so that code worked to get the "2" duplicate, now let's run the other code to get the index values for "2".

Alright, so we end up with the correct duplicate index array. Now, we need to check this array each loop of the original array, and check if it matches a duplicate, then use the index of the duplicate index array corresponding to our duplicate counter value to find the duplicates correct index. Here's a question, we have the "duplicate_number" and the "duplicate_array_index" from the get_duplicates function, so can we return those values, and access them in the bubble_sort function? Let's try it. If we separate the values by a ',', we can return both values, but they return as an array [2, [3,5]], which isn't that good for access. Can't we just set duplicate value in bubble sort to be equal to the first index here. We can set both values actually, using this data, in the bubble_sort function. So we do this, and the output was a duplicate number and duplicate array index that we didn't code a puts for, so we thought maybe those values are in the bubble_sort function's memory, but when we removed the declarations for their values, they didn't print out. It might be some wonky interaction with the return of the values from the get_duplicates function, but for now, to be sure we'll explicitly redefine the variables.

Now that we think about it, making the getting of the duplicate value and the getting of the duplicate_index_array into 2 seperate methods, would work alot better and the code would be more clean? Let's refactor this code. Alright,so we managed to get those 2 functions separated, now let's combine them into our bigger bubble_sort function. Even though we have the functions to get the dupe number and index array, I think we just want to set it to its value at the beginning of the bubbe sort function. It doesn't make sense to keep performing those loops everytime we want those values, at least work wise.

So we finally resolved the issue of the duplicates, by putting their index values in their own array, using the select method. Now, let's outpute the code to actually sort, but put in the stipulation that if the array value is a duplicate, to use the duplicate_number_index_array instead, and see if we are outputting the correct index values for the dupes now. So what's the code logic? If the code is not a duplicate, do the not duplicate standard code. If code is duplicate("else..."). Actually put the condition for if duplicate first. So "if duplicate", then current_number index is "duplicate_number_index_array[duplicate_number_count]" and the next_number_index is still that index number plus 1.

Alright, we ran the, and it seemed to go 1 spot to far, so we changed the conditional to next_number_index <= array.length. Actually that still went 1 too far. Let's try next_number_index < array.length. Anyway, now I think we have the conditions set up. Now we can finallly put in our sorting code. Actually no, reviewing the outputs, it seems we want the limiting condition to be "current_number_index < arr.length - 1". We stop when the current number index is 1 from the last spot. Alright, now I think we're fine, the main sorting logic begins after "if current_number_index < arr.length - 1"... 

Let's create a function for swapping. It should have 2 parameters; the current number, and the next number. So, how exactly are we swapping? Well, we take the next number index value, and we subtract it by 1, and we take the current number index value, and add 1 to it. Actually, we set the current number index position to be equal to the next number. Can we do this for arrays? It seems we can use ".replace" as in "a[0].replace('HI')". Let's try it out. Lmao, that didn't work. Actually it's even simpler than that. Just set the array at the index position equal to the new value. So, in regards to our function, we'd set "arr[current_number_index] = next_number", then "arr[next_number_index]= current_number". This seems to modify the array immediately, so we don't need to create a new array after each loop as we had thought? But if the array changes after each loop, doesn't that affect the positioning of the duplicates? I think this is ok, as long as we move our setting of the duplicates and the duplicate array to inside the arr loop, so that when the loop starts again, the duplicates and duplicate array are recalculated. Wow, that change made it back to the original, with the 2nd "2" showing up with an index of 3 again. Let's finish our swapping code and see how it affects everything, but for now put that code outside the arr loop.

Alright, we've added the swap numbers code to our bubble sort function, with the condition that the current number > next number. This is the big part, the main part of the sorting function, so let's hope we don't break too many things. What's important here to see if the index numbers are still correct, after the array has been changed, and whether duplicates still work. Lol, it doesn't even compile, saying that "arr" is undefined in the swap numbers function, so we set a 3rd parameter for it, and include the array and define it. Now, we're thinking this array has to be changing as time goes on, so we'll need to save our new arrays or something. But for now, let's see if this bubble sort works when its sorted and the array values get moved around. Now it's saying we have to define current number index. Since our swap numbers function is only really  2 lines, and we made the function just to test if it works, let's just include the 2 lines inside our bubble sort function and not name it, so we don't have to keep defining them? Naming the function is clear, but variables being locked into their own functions making creating a bunch of functions very complicated with ruby. Is there a way to define local variables with Ruby? 

Ok, so the 3 and 4 in the beginning swapped, so that was good, leaving a 4 and 78 for the next loop. It actually swapped this one as well, so we went and looked back at the code, and our condition to swap was "if current number > next_number_index", which is obviously wrong. We want it to be if the current number is greater than the next number. I think this is just a mistake in the way visual studios tries to autotype what we want, but we wanted next number here, not next number index. So after fixing that, the code actually worked, which is very suprising honestly. Somehow, the code didn't go too far, it stopped at the last number, and it iterated through the correct swapped array each time. In addition, the number "2" was on the last loop, and it correctly got that it was index of 5, which I'm honestly not sure how it got the correct index. Well, not that we think about it, if the current number index is correct, that is, if "2" doesn't show up as a current number, or any duplicate, I think we've set it up where the current index + 1 is always the next number's index, so it doesn't matter if there's dupes in this case. It also looks like we returned the swapped array after 1 wholy cycle of loops. so now we just need to set this cycle to repeat, until nothing is swapped.

Let's try to make this cycle repeat, check that the get duplicates and get duplicate number array are correct for the new swapped array, and set a counter that denotes whether there was a swap in the cycle or not. I think we can start with a "swapped" boolean to keep track if something swapped. We've actually never coded a boolean before, so let's hope we don't run into any problems. While it's compiling, let's think. We know how many times we need to repeat the cycle, well we don't even need that, bc we have our swapped boolean, so as long as a cycle swapped, it keeps going, but how would we code for the function to keep repeating until there are no swaps in a cycle? We notice that when we "puts #{swapped}" it turned true on the first loop, and stayed true, which initially thought was wrong, since we wanted it to say false if it didn't swap, but then we remembered that the "swapped" boolean should just keep track if there's at least 1 swap within a whole cycle of loops, so after 1 swap, it should stay true.

Ok, so after the loop, we set an empty sorted_array equal to our arr, then  we add an if statement asking if swapped is true. If it is, we run bubble sort again, with the swapped array being the new arr parameter. We remember that we set swapped array to be empty in the beginning of bubble_sort, so not sure if that's gonna be a problem. To continue, if there is no swap, then we return the swapped array and we are done. If everything works with this code, which we doubt, then I think we are done, but I'm pretty sure we'll run into a few more problems lol. We should probably uncomment the puts duplicate number line and puts duplicate number index array, to see if the new duplicate number and index array are correct.

Hmmm.. it's taking so long to compile, and we've closed and opened up terminal again several times. I think it's stuck in a loop, let's just try  to compile it, without running the bubble_sort function yet. It finally compiled, I think we had the bubble_sort repeat inside too far and it took so long to compile. The new code works almost perfectly, we got 3 loops in or so with no problems. However, we noticed that the duplicate array was incorrect after the first iteration. It didn't affect the swapping, which was good, until 2 got on the left hand side. Then it said the first "2" was at index 3, but it was actually at index 0, bc the swapped array at the time was [2, 0, 2, 3, 4, 78]. We need to look into this and see why the duplicate arrays are incorrect when bubble sort is repeated. Ok, I think we identified the problem. We ran the get duplicate number and get duplicated number index array functions, without putting the parameter in there, which is the array we want, so it went with the default arr, which is just the original array. Let's set the array parameters for both functions equal to the arr in bubble sort, which should carry over the original array, and each sorted array in the cycle. Honestly we don't think this code is that long, it just has quite a bit of commented out comments, but it takes so long to compile, like 5 to 10 mins, it's kinda rediculous. We don't want to erase out the commented comments either, bc sometimes we need them, and they are very insightful into what we've tried before. Hmmm.. we get an "undefined method + for nil class". I think we've seen this before, we're adding arrays that are out of range probably? All we did was add the arr parameters to the duplicate number and duplicate number array functions...

Alright, we get to the [2, 0, 2, 3, 4, 78] sorted array again, and it actually sorted the first 2 and 0 correctly, making the arrray [0, 2, 2, 3, 4, 78], then on this loop, it says current number is "2" which is correct, but it says current number index was 2, when it shoulda been 1. Note that at the beginning of this cycle, it identified "2" as the dupe, and said the number_index_array for "2" was [0, 2], which we can see above is correct. The problem we're seeing here it, since the first "2" ticked up the duplicate_counter_value, the second "2", which is still the first "2", is registered as an index of 2, instead of the first "2" being shifted 1 spot to the right. However, I think the more relevant problem here is that each time a swap is made, there's a new array, but we're using a duplicate array index from when the loop first started. Let's try out a smaller function and see if we can fix this. I mean, let's use a smaller array to debug this. Actually, can't the solution be as simple as running the get duplicate and get duplicate array everytime a swap occurs?

OK, so we stick " duplicate_number = get_duplicate_number(arr) duplicate_number_index_array = get_duplicate_number_index_array(arr)duplicate_number_count = 0" from the beginning of bubble_sort function into the area after the code that swaps the numbers if current number is greater than next number. In theory, this should get the duplicate number and its array indexes everytime there's a swap, which should solve our problem. Man, the compiling is slowing down to a snail's pace again. Not sure if our code is bad or what, but it's taking forever. We're gonna time it and see how long it actually takes to compile. Wow, I think that was 4 mins. Shorter than we thought, but still really long. Alright, I think that worked, we got the correct final answer. So, the code handled the duplicates well, as the numbers and the indices were all correct, but we forgot to put a puts inside the duplicate number and duplicate number index array to see if they were being generated. Let's run the code one more time and see if the correct duplicate index arrays were being generated when there was a swap.

Below is our unedited rb file after assignment completion.

def bubble_sort(arr= [4,3,78,2,0,2])

  # double_array = get_duplicates

  # duplicate_number = double_array[0]
  # duplicate_index_array = double_array[1]

  duplicate_number = get_duplicate_number(arr)
  duplicate_number_index_array = get_duplicate_number_index_array(arr)
  duplicate_number_count = 0
  swapped = false
  swapped_array = []

  puts "duplicate_number: #{duplicate_number} and duplicate_number_index_array: #{duplicate_number_index_array}"

  arr.each do |current_number|
    # next_number_index = arr.find_index(current_number) + 1
    # next_number = arr[next_number_index]
    # puts "current number: #{current_number}"
    # puts "next number: #{next_number}"

    # duplicate_number = get_duplicate_number
    # duplicate_number_index_array = get_duplicate_number_index_array
    # duplicate_number_count = 0

    if current_number == duplicate_number
      current_number_index = duplicate_number_index_array[duplicate_number_count]
      duplicate_number_count += 1
    else 
      current_number_index = arr.find_index(current_number)
    end

    # puts "duplicate number count: #{duplicate_number_count}"

    next_number_index = current_number_index + 1
    next_number = arr[next_number_index]

    puts "current number: #{current_number}, current number index: #{current_number_index}, next number: #{next_number}, next number index: #{next_number_index}"


    # if next_number_index < arr.length
    if current_number_index < arr.length - 1
      # puts "current_number_index: #{current_number_index}, is less than 5"

      if current_number > next_number
        arr[current_number_index] = next_number
        arr[next_number_index] = current_number
        swapped = true

        duplicate_number = get_duplicate_number(arr)
        duplicate_number_index_array = get_duplicate_number_index_array(arr)
        duplicate_number_count = 0

        
        puts "swapped array: #{arr}, swapped? #{swapped}"

      else
        puts "#{current_number} and #{next_number} did not get swapped" 
      end
    else
      puts "loop stopped at current number: #{current_number}"

    end

    # swapped_array = arr
    # if swapped == true

    #   puts "swapped? #{swapped}"
    #   # swapped = false
    #   bubble_sort(arr)
    # else
    #   return swapped_array
  end

  swapped_array = arr
  if swapped == true

    puts "swapped? #{swapped}"
    # swapped = false
    bubble_sort(arr)
  else
    return swapped_array
  end
end

# def get_duplicates(arr= [4,3,78,2,0,2])
#   # duplicate_index_array = []
#   # duplicate_counter_value = 0

#   # arr.each do |number1|
#   #   arr.each do |number2|

#   # duplicate_number = arr.detect {|e| arr.count(e)>1 }
#   # puts  "duplicate_number: #{duplicate_number}"

#  duplicate_index_array = arr.each_index.select {|i| arr[i] == duplicate_number}
#  puts "duplicate_index_array: #{duplicate_index_array}" 
#  return duplicate_number, duplicate_index_array
# end

# get_duplicates

def get_duplicate_number(arr= [4,3,78,2,0,2])
  duplicate_number = arr.detect {|e| arr.count(e)>1 }
  # puts  "duplicate_number: #{duplicate_number}"
  return duplicate_number
end

# get_duplicate_number

def get_duplicate_number_index_array(arr= [4,3,78,2,0,2]) 
  duplicate_number_index_array = arr.each_index.select {|i| arr[i] == get_duplicate_number}
  puts "duplicate_number_index_array: #{duplicate_number_index_array}" 
  return duplicate_number_index_array
end

bubble_sort

# get_duplicate_number_index_array
# bubble_sort
# def swap_numbers(current_number, next_number, arr= [4,3,78,2,0,2])
 
#   # arr= [4,3,78,2,0,2]
#   # current_number_index = arr.find_index(current_number)
#   # next_number_index = current_number_index + 1

#   arr[current_number_index] = next_number
#   arr[next_number_index] = current_number
  
#   puts "swapped array: #{arr}"

# end