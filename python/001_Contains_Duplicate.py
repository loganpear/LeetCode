class Solution:
    def hasDuplicate(self, nums: List[int]) -> bool:
        
        # if quantity of nums != quantity of unique nums
        return len(set(nums)) != len(nums)
