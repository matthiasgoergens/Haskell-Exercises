import Test.QuickCheck 
import Data.Char
type Bit = Int 

bin2int :: [Bit] -> Int 
bin2int bits = sum [w * b | (w, b) <- zip weights bits]
	where weights = iterate (*2) 1

int2bin :: Int -> [Bit] 
int2bin 0 = [] 
int2bin n = n `mod` 2 : int2bin (n `div` 2) 

make8 :: [Bit] -> [Bit] 
make8 bits = take 8 (bits ++ repeat 0) 

encode :: String -> [Bit] 
encode = concat . map (make8 . int2bin . ord) 

--before map, add (if count of ones is odd then 1 else 0) : map something or other 
chop8 :: [Bit] -> [[Bit]]
chop8 [] = [] 
chop8 bits = take 8 bits : chop8 (drop 8 bits)

decode :: [Bit] -> String 
decode = map (chr . bin2int) . chop8 

transmit :: String -> String 
transmit = decode . channel . encode 

channel :: [Bit] -> [Bit] 
channel = id 

