module Feature where

import Data.List
import System.IO

-- | A feature which is implemented within a program
data Feature = Command String ([String] -> IO ()) String

mkCommand :: String -> ([String] -> IO ()) -> String -> Feature
mkCommand name exec info = Command name exec info

getFeature :: String -> [Feature] -> Maybe Feature
getFeature x = find (\f-> case f of
                              c @ (Command name cmd info) -> name == x)

usage :: [Feature] -> String
usage features = "Usage: \n" ++ usage' features where
                    usage' [] = ""
                    usage' ((Command name _ info):xs) = "\t" ++ name 
                                                     ++ " " ++ info 
                                                     ++ "\n" ++ (usage' xs)

run :: String -> [Feature] -> [String] -> IO ()
run name features args = cmd args where
                             cmd = case getFeature name features of
                                        Just (Command _ cmd _) -> cmd
                                        Nothing -> (\_ -> putStr $ usage features)
