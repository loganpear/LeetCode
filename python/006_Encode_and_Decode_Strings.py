class Solution:

    def encode(self, strs: List[str]) -> str:
        out = ""
        for s in strs:
            out += str(len(s)) 
            out += '_'
            out += s
        return out
        
    def decode(self, s: str) -> List[str]:
        out = []
        i = 0
        while i < len(s):
            num_str = ""
            while s[i] != '_':
                num_str += s[i]
                i += 1
            i += 1
            word = ""
            for _ in range(int(num_str)):
                word += s[i]
                i += 1
            out.append(word)
        return out""
