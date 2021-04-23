module Shinju.Cli.Control
    ( module Shinju.Cli.Control
    ) where

import Data.Maybe

endoPChain :: [(Bool, a -> a)] -> (a -> a)
endoPChain = foldl (.) id . map snd . filter fst

endoMaybeChain :: [Maybe (a -> a)] -> (a -> a)
endoMaybeChain = foldl (.) id . catMaybes

--TODO usage examples from wamphfind
