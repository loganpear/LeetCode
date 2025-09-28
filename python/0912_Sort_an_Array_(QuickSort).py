class Solution:
    def sortArray(self, nums: List[int]) -> List[int]:

        def quicksort_inner(array, first, last):

            # base case: first and last are at the place or crossed
            if first >= last:
                return

            # initialize variables
            l = first
            r = last
            mid = (r - l) // 2 + l

            # use median of 3 to put median in the midpoint
            if array[l] > array[r]:
                array[l], array[r] = array[r], array[l]
            if array[l] > array[mid]:
                array[l], array[mid] = array[mid], array[l]
            if array[mid] > array[r]:
                array[mid], array[r] = array[r], array[mid]
            
            # since left and right ends are already sorted, incriment each
            l += 1
            r -= 1
            pivot = array[mid]

            # While pointers not crossed, perform swaps
            while l <= r:

                while l <= r and array[l] < pivot:
                    l += 1
                while l <= r and array[r] > pivot:
                    r -= 1

                if l <= r:
                    array[l], array[r] = array[r], array[l]
                    r -= 1
                    l += 1
            
            quicksort_inner(array, first, l - 1)
            quicksort_inner(array, l, last)

        quicksort_inner(nums, 0, len(nums) - 1)
        return nums
            
