class Solution:
    def reachNumber(self, target: int) -> int:
        target = abs(target)
        total = 0
        incriment = 0
        diff = 0 # initial val doesnt really matter

        # iterate until total is greater than the target
        # if the diff is even it means as long as our total is >= target there is a possible combo of plus and minus to get there at the current incriment 
        while total < target or diff % 2 == 1:
            incriment += 1
            total += incriment
            diff = total - target
            
        return incriment
