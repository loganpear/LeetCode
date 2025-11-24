class Solution:
    """ Brute force solution
    def maxSlidingWindow(self, nums: List[int], k: int) -> List[int]:
        output = []
        for i in range(0, len(nums) - k + 1):
            sub = nums[i:k+i]
            output.append(max(sub))
        return output
    """
    def maxSlidingWindow(self, nums: List[int], k: int) -> List[int]:
        """ 
        Credit: This solution is by @niits on Leetcode
        """
        output = []
        q = deque()

        for i, num in enumerate(nums):
            # Maintain the deque in decending order
            while q and q[-1] < num:
                q.pop()
            q.append(num)

            # remove leftmost element in q if out of the window
            if i >= k and nums[i - k] == q[0]:
                q.popleft()

            # appaend the maximum of the current window to the result
            if i >= k - 1:
                output.append(q[0])

        return output
