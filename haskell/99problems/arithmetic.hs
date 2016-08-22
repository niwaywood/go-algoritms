
-- question 31 - determine whether a given integer number is prime
isPrime :: (Integral a) => a -> Bool
isPrime n = isPrime' 2
    where isPrime' x
            | x >= n = True 
            | n `mod` x == 0 = False
            | otherwise = isPrime' (x + 1)

-- question 32 - determine the great common divisor of two positive integer numbers (using Euclid's algorithm)
myGCD :: Integral a => a -> a -> a
myGCD 0 y = y
myGCD x 0 = x
myGCD x y 
    | x > y = myGCD (x-y) y
    | otherwise = myGCD (y-x) x

-- question 33 - Determine whether two positive integer numbers are coprime
coprime x y = myGCD x y == 1

-- question 34 - Calculate Euler's totient function phi(m)
phi :: Integral a => a -> Int
phi n = length (foldl f [] [1..(n - 1)])
    where f acc x = if coprime x n then x:acc else acc 

-- question 35 - determine the prime factors of a given positive integer
primeFactors n = primeFactors' n 2
  where
    primeFactors' 1 _ = []
    primeFactors' n f
      | n `mod` f == 0 = f : primeFactors' (n `div` f) f
      | otherwise      = primeFactors' n (f + 1)

-- question 36 - Determine the prime factors of a given positive integer
