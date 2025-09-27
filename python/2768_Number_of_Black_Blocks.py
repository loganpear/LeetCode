# 2768. Number of Black Blocks
class Solution:
    def countBlackBlocks(self, m: int, n: int, coordinates: List[List[int]]) -> List[int]:
        # identify each square as its top left corder coords
        dic = defaultdict(int)

        for r, c in coordinates:
            # add a black count to each square that contains it in bounds
            for x, y in [(r, c), (r, c-1), (r-1, c), (r-1, c-1)]:
                if 0 <= x < m-1 and 0 <= y < n-1:
                    dic[(x, y)] += 1
    
        # count the quantity of each occurance 1 to 4
        counts = [0] * 5
        for count in dic.values():
            counts[count] += 1

        # the quantity of zeros is not already accounted for 
        total_squares = (m - 1) * (n - 1) 
        counts[0] = total_squares - sum(counts)

        return counts
