# 004 Group Anagrams

### Problem Description

Given an array of strings, group the anagrams together.  
Two strings are anagrams if they contain the same characters in any order.

---

### 🐌 Brute Force Solution

**Time Complexity:** O(m * n log n)  
**Space Complexity:** O(m * n)  
Where:
- `m` is the number of strings in `strs`
- `n` is the maximum length of a string

This solution sorts each string to create a key and uses that to group the anagrams. It's straightforward but inefficient due to sorting overhead.

```python
class Solution:
    def groupAnagrams(self, strs: List[str]) -> List[List[str]]:
        dic = {}
        for s in strs:
            chars = sorted(list(s))  # O(n log n)
            sorted_s = ""
            for ch in chars:
                sorted_s += ch       # O(n) string concat

            if sorted_s in dic:
                dic[sorted_s].append(s)
            else:
                dic[sorted_s] = [s]

        return dic.values()
````

The main downside is the **string sorting and concatenation**, which is slower compared to a counting-based approach.

---

### 🚀 Optimal Solution

**Time Complexity:** O(m \* n)
**Space Complexity:** O(m \* n)

This solution avoids sorting by counting the frequency of each letter. The 26-length count tuple is used as a dictionary key, which is much more efficient.

```python
class Solution:
    def groupAnagrams(self, strs: List[str]) -> List[List[str]]:
        dic = {}  # key: tuple of 26 letter counts, value: list of anagrams
        for s in strs:
            l = [0] * 26  # Holds count of each letter

            for ch in s:
                i = ord(ch) - 97  # 'a' = 97, so this maps a-z to 0-25
                l[i] += 1

            k = tuple(l)  # Tuples are hashable; valid dict keys
            if k in dic:
                dic[k].append(s)
            else:
                dic[k] = [s]
                
        return dic.values()
```

