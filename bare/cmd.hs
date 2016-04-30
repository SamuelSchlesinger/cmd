import System.Environment
import System.IO
import Feature

features :: [Feature]
features = []

main = do args <- getArgs
          case args of 
              []     -> run "" features []
              (x:xs) -> run x features xs
