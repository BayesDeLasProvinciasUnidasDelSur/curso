class MersenneTwister:
    def __init__(self, seed):
        # Tamaño de la palabra
        self.w = 32 # bits para integer sin signo
        # Grado de recurrencia
        self.n = 624 # La longitud del vector de palabras
        # Palabra del medio
        self.m = 397 # Usada para la transformación twist
        # Punto de separación
        self.r = 31 # La palabra de longitud w se divide en parte superior (w-r bits) e inferior (r bits).
        #
        self.a = 0x9908B0DF
        self.u, self.d = 11, 0xFFFFFFFF
        self.s, self.b = 7, 0x9D2C5680
        self.t, self.c = 15, 0xEFC60000
        self.l = 18
        self.f = 1812433253
        # Create a length n array to store the state of the generator
        self.mt = [0] * self.n
        self.index = self.n + 1
        self.lower_mask = (1 << self.r) - 1  # The binary number of r 1's
        self.upper_mask = (~self.lower_mask) & 0xFFFFFFFF  # The binary number of w-r 0's followed by r 1's
        # Initialize the generator from a seed
        self.mt[0] = seed
        for i in range(1, self.n):
            self.mt[i] = (self.f * (self.mt[i - 1] ^ (self.mt[i - 1] >> (self.w - 2))) + i) & 0xFFFFFFFF
    def extract_number(self):
        if self.index >= self.n:
            if self.index > self.n:
                raise Exception("Generator was never seeded")
            self.twist()
        y = self.mt[self.index]
        y ^= (y >> self.u) & self.d
        y ^= (y << self.s) & self.b
        y ^= (y << self.t) & self.c
        y ^= (y >> self.l)
        self.index += 1
        return y & 0xFFFFFFFF
    def twist(self):
        for i in range(self.n):
            x = (self.mt[i] & self.upper_mask) + (self.mt[(i + 1) % self.n] & self.lower_mask)
            xA = x >> 1
            if x % 2 != 0:  # lowest bit of x is 1
                xA ^= self.a
            self.mt[i] = self.mt[(i + self.m) % self.n] ^ xA
        self.index = 0




# Example usage
mt = MersenneTwister(5489)  # Seed the generator
random_numbers = [mt.extract_number() for _ in range(10)]
print(random_numbers)
