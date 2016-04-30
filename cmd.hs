import System.Environment
import System.IO
import Feature

features :: [Feature]

main = do
        args <- getArgs
        if args == [] 
            then run ""          features []
            else run (head args) features (tail args)

features = [
            Command "write" writef "<filename> {<stuff-to-write>}",
            Command "read" readf "<filename>",
            Command "intersperse" interspersef "<filename> <spacer> {<stuff-to-write>}"
           ] 

-- | Writes each argument to the file supplied, space separated ;)
interspersef :: [String] -> IO ()
interspersef (filename:space:args) = withFile filename AppendMode (\h -> i' h space args) where
                                        i' h _ [] = hClose h
                                        i' h _ (x:[]) = do { hPutStr h x; hClose h; }
                                        i' h space (x:xs) = do { hPutStr h (x ++ space); i' h space xs }

-- | Reads a file and prints it to the screen
readf :: [String] -> IO ()
readf [] = putStr "Missing arguments to write: filename\nUsage: cmd read <filename>\n"
readf (filename:_) = do
                  contents <- readFile filename 
                  putStr contents
                  putStr "\n"

-- | Writes each argument to the file supplied, space separated
writef :: [String] -> IO ()
writef [] = putStr "Missing arguments to write: filename\nUsage: cmd write <filename> {<stuff>}\n"
writef (filename:args) = withFile filename AppendMode (\h -> write' h args) where
                           write' h [] = hClose h 
                           write' h (x:[]) = do { hPutStr h x; hClose h; }
                           write' h (x:xs) = do { hPutStr h (x ++ " "); write' h xs; }
