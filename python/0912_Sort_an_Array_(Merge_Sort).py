class Solution:
    def sortArray(self, nums: List[int]) -> List[int]:

        def merge(array, left, right):
            l = r = i = 0
            # iterate through left and right placeing smallest
            # to largest into the parent array at index i
            while l < len(left) and r < len(right):
                if left[l] > right[r]:
                    array[i] = right[r]
                    r += 1
                # Ensure stable sort by choosing left if equal 
                else:
                    array[i] = left[l]
                    l+=1
                i += 1
            
            # iterate through any left over on left 
            while l < len(left):
                array[i] = left[l]
                l+=1
                i += 1
            
            # iterate through any left over on right
            while r < len(right):
                array[i] = right[r]
                r+=1
                i += 1

        def merge_sort(array):
            if len(array) <= 1:  # Base case
                return
            mid = len(array) // 2
            left = array[:mid]
            right = array[mid:]
            merge_sort(left)
            merge_sort(right)
            merge(array, left, right)
        
        merge_sort(nums)
        return nums
