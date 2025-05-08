class Solution:
    def hasDuplicate(self, nums: List[int]) -> bool:
        
        # if quantity of nums != quantity of unique nums then you know there must be duplicate values
        return len(nums) != len(set(nums))
