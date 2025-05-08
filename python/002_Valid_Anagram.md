# 002. Valid Anagram

### Problem Description

Given two strings `s` and `t`, return `true` if `t` is an anagram of `s`, and `false` otherwise.

An anagram is a word or phrase formed by rearranging the letters of another, using all original letters exactly once. The input strings will only contain lowercase alphabets.

---

### 🐢 Brute Force Solution

**Time Complexity:** `O(n²)`  
**Space Complexity:** `O(n)`

This is the first solution I came up with. It works by converting both strings to mutable lists, then checking character-by-character if each letter in `s` exists in `t`. If it does, we remove it from both lists. If not, the strings aren't anagrams.

However, this solution is inefficient because both `in` and `remove` operations on a list are `O(n)`, and we do them inside a loop — resulting in quadratic time.

```python
class Solution:
    def isAnagram(self, s: str, t: str) -> bool:
        if len(s) != len(t):
            return False

        # Convert to mutable lists
        list_s = []
        list_t = []
        for i in range(len(s)):
            list_s.append(s[i])
            list_t.append(t[i])

        # Check and remove matching characters
        for ch in s:
            if ch in list_t:
                list_t.remove(ch)
                list_s.remove(ch)
            else:
                return False

        return True
````

---

### ⚡ Optimal Solution

**Time Complexity:** `O(n)`  
**Space Complexity:** `O(1)`

I improved the solution by counting the frequency of each letter in both strings at the same time. Then I checked if all counts balance out to zero. Because we only use a fixed-size array or dictionary of 26 letters, the space is constant.

```python
class Solution:
    def isAnagram(self, s: str, t: str) -> bool:

        # if the strings are not same length
        if len(s) != len(t):
            return False

        # create a dict[letter] = difference
        # where the value is the difference in counts of each letter between the two strings `s` and `t`
        letters = "abcdefghijklmnopqrstuvwxyz"
        letters_dict = {}
        for ch in letters:
            letters_dict[ch] = 0
        
        # iterate through each char in each string 
        for i in range(len(s)):
            letters_dict[s[i]] += 1
            letters_dict[t[i]] -= 1
            # the resulting value at a given key is the difference in counts of that char in the two strings
        
        # if there is a diffenence in counts than its not an annogram
        for value in letters_map.values():
            if value != 0:
                return False
        
        return True
```
