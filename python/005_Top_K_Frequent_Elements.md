initial sol 

class Solution:
    def topKFrequent(self, nums: List[int], k: int) -> List[int]:
        dic = {}
        for n in nums:
            if n in dic:
                dic[n] += 1
            else:
                dic[n] = 1

        print(dic)

        # construct parelell lists
        keys = list(dic.keys())
        vals = list(dic.values())
        
        output = []
        
        for _ in range(k):
            i = vals.index(max(vals)) # max index
            output.append(keys.pop(i))
            vals.pop(i)
    
        return output
