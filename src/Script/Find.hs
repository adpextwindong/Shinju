{-# LANGUAGE DeriveFunctor #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE TypeSynonymInstances #-}
{-# LANGUAGE OverloadedStrings #-}

module Shinju.Script.Find
    ( module Shinju.Script.Find
    ) where

import Control.Monad.Free
import System.FilePath

data SearchStyle = NonRecursive | Recursive
    deriving (Show)

data ReplacementStrategy = Skip |
                           Warn |
                           ResumeLater |
                           Prompt FilePath
    deriving (Show)

data FindDir next = MissingDir FilePath | --TODO probably needs more refinement to differentiate filepath and dirpath
                    SkipDir FilePath |
                    PendingDir [FindFile]

--TODO liftF stuff and app Free FindDir a example
--TODO class InterpretingContex a instance example
--TODO mock example using RoseTree of filepaths or something
--TODO cli example
--TODO web server example
--
data FindFile = DoneFile |
                MissingFile FilePath |
                SimilarFiles [FilePath] | -- Levenshtein Distance?
                PromptFile (ReplacementStrategy -> IO ()) --Replace IO with File System Abstraction MonadIO?

--TODO lets try this Free Monad approach https://www.endpoint.com/blog/2016/03/11/strict-typing-fun-example-free-monads
--With dirs first and then layer in individual files

search :: (FilePath -> Bool) -> FilePath -> SearchStyle -> Free FindDir a
search = undefined
-- Given some predicate and a directory to go search

--NOTES
--For a cli version we just need to generate an IO monad that something else can run
--Mocking a file system with a RoseTree containing FP's and modifying it at each bind would be nice to
--simulate --dry-run or somethign
--Generating a handler for servant is still an open question. Maybe another framework is better
--A batch cli version could just substitute a replacement strategy everywhere and use a phantom type
--around an IO to differentiate Batch' IO () and Interactive' IO ()
