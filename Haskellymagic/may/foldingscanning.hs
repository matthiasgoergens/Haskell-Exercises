import Test.QuickCheck
import Test.QuickCheck.Function
import Data.List

scanl' :: (a -> b -> a) -> a -> [b] -> [a]
scanl' f initial [] = [initial]
scanl' f initial (x : xs) = initial : scanl' f (f initial x) xs  

testscanl :: Fun (Int, Int)  Int -> Int -> [Int] -> Bool 
testscanl f' init l = scanl' f init l == scanl f init l where
    f a b = apply f' (a,b)

testr :: Fun (Int, Int) Int -> Int -> [Int] -> Bool 
testr f' init l = head (scanr f init l) == foldr f init l where 
    f a b = apply f' (a,b)

scanr' :: (a -> b -> b) -> b -> [a] -> [b] 
scanr' f terminal [] = terminal : []
scanr' f terminal [a] = f a terminal : terminal : []
scanr' f terminal [a, b] = let newb = f b terminal in 
                           f a newb : newb : terminal : []
scanr' f terminal [c,b,a] = let newa = f a terminal
                                newb = f b newa
                                newc = f c newb in
                            newc : newb : newa : terminal : []
scanr' f terminal [d,c,b,a] = let newa = f a terminal
                                  newb = f b newa
                                  newc = f c newb 
                                  newd = f d newc in
                              newd : newc : newb : newa : terminal : []
scanr' f terminal [e,d,c,b,a] =
    let newa = f a terminal
        newb = f b newa
        newc = f c newb 
        newd = f d newc 
        newe = f e newd
    in
    newe : newd : newc : newb : newa : terminal : []
scanr' f terminal (x : xs) =
    case scanr' f terminal xs of
        [] -> error "Can't happen!"
        rest@(newv : _) -> f x newv : rest
{-
scanr' f terminal list = let sr l [] = l 
                             sr l (y : ys) = sr ys (y : l) in
                          undefined sr
-}
                           

testscanr :: Fun (Int, Int) Int -> Int -> [Int] -> Bool
testscanr f' term l = scanr' f term l == scanr f term l where
    f a b = apply f' (a,b) 

safehead :: [a] -> Maybe a
safehead [] = Nothing
safehead l = Just $ head l 

rhead :: [a] -> a
rhead l = foldr (\a b -> Just a) Nothing l

testrhead :: [Char] -> Bool
testrhead l = safehead l == rhead l 
manytail :: [a] -> [[a]] 
manytail [] = [[]]
manytail (x : xs) = (x : xs) : manytail xs 

testtails :: [Char] -> Bool
testtails l = manytail l == tails l  

rev :: [a] -> [a] 
rev [] = [] 
rev [a] = [a] 
rev (x : xs) = rev xs ++ [x] 

testreverse :: [Char] -> Bool
testreverse l = rev l == reverse l 

main = do
    quickCheck testscanl 
    quickCheck testreverse
    quickCheck testtails 
    quickCheck testr
    quickCheck testscanr
    quickCheck testrhead
