import Data.List

-- question 1 - Find the last element of a list
myLast :: [a] -> a
myLast [] = error "No last element of empty list"
myLast (x:xs) = if null xs then x else myLast xs

-- question 2 - Find the second last element of a list
myButLast :: [a] -> a
myButLast [] = error "No second last element of empty list"
myButLast [x] = error "No second last element of one element list"
myButLast xs = (!! 1) $ reverse xs

-- question 3 - Find the kth element of a list where list is 1-indexed
elementAt :: (Integral b) => [a] -> b -> a
elementAt xs i
    | null xs = error "out of bounds"
    | i == 1 = head xs
    | i > 1 = elementAt (tail xs) (i-1)

-- question 4 - Find the number of element of a list
myLength :: [a] -> Int
myLength [] = 0
myLength x = accFn x 0
    where
        accFn [] n = n
        accFn (_:xs) n = accFn xs (n + 1)

-- or using a foldl
myLength' :: [a] -> Int
myLength' = foldl (\acc _ -> acc + 1) 0

-- question 5 - Reverse a list
myReverse :: [a] -> [a]
myReverse x = accFn x []
    where
        accFn [] acc = acc
        accFn x acc = accFn (tail x) ((head x):acc)

-- question 6 - Find out whether a list is a palindrome
isPalindrome :: (Eq a) => [a] -> Bool
isPalindrome x
    | length x <= 1 = True
    | head x == last x = isPalindrome $ init $ tail x
    | otherwise = False

-- question 7 - Flatten a nested list structure
data NestedList a = Elem a | List [NestedList a]
flatten :: NestedList a -> [a]
flatten (Elem a) = [a]
flatten (List []) = []
flatten (List (x:xs)) = flatten x ++ flatten (List xs)

-- question 8 - Eliminate consecutive duplicates of list elements
compress :: (Eq a) => [a] -> [a]
-- foldr is more efficient because it doesn't use the ++ operator
compress = foldr (\x acc -> if not (null acc) && head acc == x then acc else x:acc) []
--compress = foldl (\acc x -> if not (null acc) && last acc == x then acc else acc ++ [x]) []

compress' :: (Eq a) => [a] -> [a]
compress' [] = []
compress' [x] = [x]
compress' (x:x':xs) = if x == x' then compress' (x:xs) else x:(compress' (x':xs))

-- question 9 - Pack consecutive duplicates of list elements into sublists
-- this is equivilent to the group function in Data.List module
pack :: (Eq a) => [a] -> [[a]]
pack = foldr f [[]]
    where
        f x [[]] = [[x]]
        f x acc
            | head (head acc) == x = (x:(head acc)):(tail acc)
            | otherwise = [x]:acc

-- question 10 - Run length encoding of a list
encode :: Eq a => [a] -> [(Int, a)]
encode = map f . pack
    where f x = ((length x), (head x))

-- question 11 - Modified run length encoding of a list
data Item a = Single a | Multiple Int a deriving Show
encodeModified :: Eq a => [a] -> [Item a]
encodeModified = map f . group
    where
        f x
            | length x == 1 = Single (head x)
            | otherwise = Multiple (length x) (head x)

-- question 12 - Decode a modifired run length encoded list
decodeModified :: [Item a] -> [a]
decodeModified = concat . map f
    where
        f (Single x) = [x]
        f (Multiple i x) = replicate i x

-- question 13 - Run length encoding of a list (direct solution)
encodeDirect :: Eq a => [a] -> [Item a]
encodeDirect = map encodeHelper . encode'
    where
        encodeHelper (1, x) = Single x
        encodeHelper (n, x) = Multiple n x

encode' :: Eq a => [a] -> [(Int, a)]
encode' = foldr f []
    where
        f x [] = [(1, x)]
        f x y@((a, b):ys)
            | b == x = (a+1, b):ys
            | otherwise = (1, x):y

-- question 14 - Duplicate the elements of a list
dupli :: [a] -> [a]
dupli = concatMap (\x -> replicate 2 x)

-- question 15 - Replicate the elements of a list given a number of times
repli :: [a] -> Int -> [a]
repli xs n = (concat . map f) xs
    where f x = replicate n x

-- question 16 - Drop every N'th element from a list
dropEvery :: [a] -> Int -> [a]
dropEvery xs n = (map f . filter p . zip [1..]) xs
    where p (i, _) = i `mod` n /= 0
          f (_, x) = x

-- question 17 - Split a list into two parts; the length of the first part is given
split :: [a] -> Int -> ([a], [a])
split [] _ = ([], [])
split xs n =  (foldr f ([], []) . zip [1..]) xs
    where 
        f x acc
            | (fst x) > n = ((fst acc), (snd x):(snd acc))
            | otherwise = ((snd x):(fst acc), (snd acc))

-- question 18 - Extract a slice from a list
slice :: [a] -> Int -> Int -> [a]
slice xs l u = sliceHelper xs l u 1
    where 
        sliceHelper [] _ _ _ = []
        sliceHelper (x:xs) l u n
            | n < l = sliceHelper xs l u (n + 1)
            | n > u = []
            | otherwise = x:sliceHelper xs l u (n+1) 

-- question 19 - Rotate a list N places to the left
rotate :: [a] -> Int -> [a]
rotate xs 0 = xs
rotate xs n = if n < 0 
    then drop ((length xs) + n) xs ++ take ((length xs) + n) xs
    else drop n xs ++ take n xs

-- question 20 - Remove the Kth element from a list
removeAt :: Int -> [a] -> (Maybe a, [a])
removeAt n xs 
    | n > 0 && n <= length xs = (Just (xs !! (n-1)), removeAt' n xs)
    | otherwise = (Nothing, xs)
    where removeAt' n xs = take (n-1) xs ++ drop n xs

-- question 21 - Insert an element at a given position into a list
insertAt :: a -> [a] -> Int -> [a]
insertAt _ [] _ = []
insertAt c (x:xs) n = if n == 1 
    then c:x:insertAt c xs (n-1)
    else x:insertAt c xs (n-1)

-- question 22 - Create a list containing all integers within a given range
range :: Int -> Int -> Maybe [Int]
range l u 
    | l >= u = Nothing
    | otherwise = range' l u []
    where range' l current xs | l - 1 == current = Just xs
                              | otherwise = range' l (current - 1) (current:xs)


