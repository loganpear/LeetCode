# 003 Two Sum

### Brief problem description

Given an array of integers `nums` and an integer `target`, return the **indices** of the two numbers such that they add up to the target.
You may assume that each input would have **exactly one solution**, and you may not use the same element twice.

---

### Initial Solution

**Time complexity:** O(n)  
**Space complexity:** O(n)

This was the first approach I came up with.
It builds a dictionary where each unique number maps to a list of indices where it appears.
Then it looks for the complement of each number in the dictionary to find a valid pair.

The logic works, but it's more complex than needed, and it stores *lists of indices*, which isn’t space-efficient.
It also has to do extra checks to avoid returning the same index twice.

```python
class Solution:
    def twoSum(self, nums: List[int], target: int) -> List[int]:
        # keys: unique nums, values: list of indices they appear
        nums_dict = {}
        for i, num in enumerate(nums):
            if num in nums_dict:
                nums_dict[num].append(i)
            else:
                nums_dict[num] = [i]

        # check for complements
        for i, num in enumerate(nums):
            diff = target - num
            if diff in nums_dict:
                i2_list = nums_dict[diff]
                if i != i2_list[0]:
                    return [i, i2_list[0]]
                elif len(i2_list) >= 2:
                    return [i, i2_list[1]]
```

---

### Concise Solution

**Time complexity:** O(n)  
**Space complexity:** O(n)

This is the optimal one-pass solution.
It uses a single dictionary to track numbers we've already seen, mapping from number to index.
As we iterate, we check if the complement exists in the map.
If it does, we return the pair immediately.

Note: this solution is by NeetCode or whoever else came up with it first, not myself.  

```python
class Solution:
    def twoSum(self, nums: List[int], target: int) -> List[int]:
        # keys: nums we've seen, values: their indices
        num_map = {}
        for i, num in enumerate(nums):
            diff = target - num
            if diff in num_map:
                return [num_map[diff], i]
            num_map[num] = i
```
